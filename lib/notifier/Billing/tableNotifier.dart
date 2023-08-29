import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../Popup/alertDialog.dart';
import '../../models/BillingModel/cartModel.dart';
import '../../models/getBillingOutletModels.dart';
import '../../styles/app_theme.dart';
import '../../utils/sizeLocal.dart';
import '../dynamicTableOrderNumbersNotifier.dart';
import '../utils.dart';
import 'cartNotifier.dart';
import 'configuration.dart';
import 'floorsOrderTypePopulate.dart';
import 'otherServices/quickServiceHandler.dart';
import 'outletDetail.dart';
import 'servicePageNotifier.dart';

bool HasTableLock() {
  return false;
}
bool HasCoversSelection() {
  return isHasBillSettingsAccess(featuresAccessId['Covers']);
}
bool HasWaiterSelection() {
  return isHasBillSettingsAccess(featuresAccessId['Waites']);
}
bool HasCaptainSelection() {
  return isHasBillSettingsAccess(featuresAccessId['CaptainSelection']);
}

var x_tableId, x_seats, x_status, x_isDynamic, x_isMergeTable, x_isNewDynamicTable;
var x_coverEntry="".obs;
var x_tableNumber="Table No".obs;
var x_waiterSelected=-1;
var x_waiterName="".obs;
var x_captainSelected=-1;
var x_captainName="".obs;
RxInt x_CoversWaiterType=RxInt(1);
late AnimationController guestNoController;
ScrollController guestPageController=new ScrollController();

void coversPageJump(int page){
  guestPageController.animateTo((page*SizeConfig.screenWidth!), duration: Duration(milliseconds: 300), curve: Curves.easeIn);
}


void OnCoversDone() {
  int covers = parseInt(x_coverEntry.value);
  if (covers == 0 && HasCoversSelection()) {
    CustomAlert().commonErrorAlert("Enter Covers...", "");
    return;
  }
  if(HasWaiterSelection() && x_waiterName.isEmpty){
    CustomAlert().commonErrorAlert("Select Waiter...", "");
    return;
  }
  if(HasCaptainSelection() && x_captainName.isEmpty){
    CustomAlert().commonErrorAlert("Select Captain...", "");
    return;
  }
  TogglePopUp('c_Covers');
  CreateTableOrder(covers: covers);
}

void DestroyXTable() {
  x_tableId=null; x_tableNumber.value="Table No "; x_seats=null; x_status=null; x_isDynamic=null; x_isMergeTable=null; x_isNewDynamicTable=null;x_waiterSelected=-1;
  x_waiterName.value="";x_captainSelected=-1;x_captainName.value="";
}

void TableHandler({ tableId, tableNumber, seats, status, isDynamic = false, isMergeTable = false, isNewDynamicTable = false }) {

  x_coverEntry.value="";
  x_waiterSelected=-1;
  x_captainSelected=-1;
  x_waiterName.value="";
  x_captainName.value="";
  x_tableId = tableId; x_tableNumber.value = tableNumber; x_seats = seats; x_status = status;
  x_isDynamic = isDynamic; x_isMergeTable = isMergeTable; x_isNewDynamicTable = isNewDynamicTable;

  getTableStatus(tableId, isDynamic ? tableNumber:null,needFullResponse:true,setOrderType:true,
      isMergeTable: isMergeTable,
      callback: (response){
    int tableIndex = response['Table'].indexWhere((e) => e['TableNumberId'] == tableId && e['TableNumber'] == tableNumber && e['FloorId'] == c_FloorId.value);
    if (tableIndex == -1 && !isNewDynamicTable) {
      CustomAlert().commonErrorAlert("Table Not Found","");
      DestroyXTable();
      return;
    }
    var tableStatus = isNewDynamicTable ? status: response['Table'][tableIndex]['TableStatus'];
    if (tableStatus.toLowerCase() == "free") {
      if (HasCoversSelection() || HasWaiterSelection() || HasCaptainSelection()) {
        //Open PopUp
        if (isNewDynamicTable) {
          tableIndex = response['Table'].indexWhere((e) => e['TableNumberId'] == (tableId) && e['FloorId'] == c_FloorId.value);
        }
        try{
          if(response['Table'][tableIndex]['CaptainId']!=null) {
            x_captainSelected = response['Table'][tableIndex]['CaptainId'];
            x_captainName.value = response['Table'][tableIndex]['CaptainName'];
          }
          if(response['Table'][tableIndex]['WaiterId']!=null) {
            x_waiterSelected = response['Table'][tableIndex]['WaiterId'];
            x_waiterName.value = response['Table'][tableIndex]['WaiterName'];
          }
        }catch(e){}

        coversPageJump(0);
        guestNoController.forward();
      }
      else{
        CreateTableOrder();
      }
    }
    else {
      clearClickEvents();
      getTableStatus(tableId, isDynamic ? tableNumber:null,isMergeTable: isMergeTable,callback: (response){ getTableStatusResponse(response); });
    }
  });

}

void CreateTableOrder({int covers=0}){
  Provider.of<DynamicTableDetails>(Get.context!,listen:false).GetDynamicDetailsHit(c_OrderTypeId.value??0).then((value){
    //print("GetDynamicDetailsHit $value");
    c_orderDetail.value=new OrderModel();
    c_orderDetail.value!.initDineIn(value['Table'][0]['OrderId'], value['Table'][0]['OrderNumber'], x_tableId, x_tableNumber.value, x_seats,isDynamic: x_isDynamic);
    c_orderDetail.value!.setOrderType();
    c_orderDetail.value!.isMergeTable = x_isMergeTable;
    c_orderDetail.value!.covers = covers;
    c_orderDetail.value!.waiterId = x_waiterSelected;
    c_orderDetail.value!.captainId = x_captainSelected;
    TogglePopUp('c_AllServices');
    TogglePopUp('clearCoversEntry');
    clearClickEvents();
    //Get.to(BillingPage());
  });
}


int c_TableClickIndex=-1;
RxList<dynamic> c_TableList=new RxList() ;
void TableMultiOptionHandler({ tableId, tableNumber, seats, status, isDynamic = false, isMergeTable = false }) {
  c_TableClickIndex=-1;
  getTableStatus(tableId, isDynamic ? tableNumber:null,isMergeTable:isMergeTable,callback: (response){
    log("$response");
    if (response !=null && response['Table']!=null && response['Table'].length > 0){
      //var t=response['Table'] as List;

      setOutletDetail("TableList", response['Table']);
      populateTables(c_FloorId.value);
      setOutletDetail("TakeAwayList", response['Table1']);
      populateTakeAway(c_FloorId.value);
      setOutletDetail("HomeDeliveryList", response['Table2']);
      populateHomeDelivery(c_FloorId.value);

      c_TableList.value = response['Table'].where((f) => f['TableNumberId']==tableId).toList();
      c_TableClickIndex = c_TableList.value.indexWhere((e) => e['TableNumberId'] == tableId && e['TableNumber'] == tableNumber);
      showTableMultiOptions(tableNumber);
      print("c_TableList $c_TableList");
    }
  },
      needFullResponse: true
  );
}

void showTableMultiOptions(tableNo,){
  showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: (){
            // tn.InsertTableBlockDbHit(context, 1, tn.filtertablesFloor[i].FloorId, tn.filtertablesFloor[i].TableNumberId, tn.filtertablesFloor[i].IsDynamic==0?null:tn.filtertablesFloor[i].TableNumber,  tn.filtertablesFloor[i].IsDynamic==0?false:true,'Cancel');
          },
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Obx(() => Container(
              height: 250+((c_TableList.length).toDouble()*60),
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,

              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.ce,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.red
                      ),
                      child: Center(
                          child: SvgPicture.asset("assets/icon/tableservice.svg",color:Colors.white,
                            height: 30,
                            width: 30,
                          )
                      ),
                    ),

                    SizedBox(height: 10,),

                    Text("Table-$tableNo",
                      style: TextStyle(fontFamily: 'RR',fontSize: 16),
                    ),

                    SizedBox(height: 10,),

                    Expanded(
                      child: ListView.builder(
                          itemCount: c_TableList.length,
                          itemBuilder: (context,index){
                            return Container(
                              width: 200,
                              height: 50,

                              margin: EdgeInsets.only(bottom: 10,left: 50,right: 50),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Color(0xFFCDCDCD)),
                                // color: Colors.red
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("${c_TableList[index]['TableNumber']}",style: TextStyle(fontFamily:'RR',color: Colors.grey[700],fontSize: 16),),
                                  Text("${c_TableList[index]['GrandTotalAmount']}",style: TextStyle(fontFamily:'RR',color: Colors.grey[700],fontSize: 16),),
                                ],
                              ),
                            );


                          }),
                    ),

                    //ADD New Table
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: (){
                        Get.back();
                        AddTableHandler();
                      },
                      child: Container(
                        height: 50.0,
                        width: 230.0,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppTheme.red,
                            boxShadow: [
                              BoxShadow(
                                color:AppTheme.red.withOpacity(0.6),
                                offset: const Offset(0, 8.0),
                                blurRadius: 15.0,
                                // spreadRadius: 2.0,
                              ),
                            ]
                        ),
                        child: Center(
                          child: Text("Add New Table",
                            style: TextStyle(fontFamily:'RR',color: Colors.white,fontSize: 16),
                          ),
                        ),
                      ),
                    ),

                    //Shift Table

                  ],
                ),
              ),
            )),
          ),
        );
      }).then((value) {});
}

void AddTableHandler() {
  print("c_TableClickIndex $c_TableClickIndex");
  if (c_TableList.length > 0) {
    if ((c_TableList[c_TableClickIndex]['TableStatus'] != "Free" || c_TableList[c_TableClickIndex]['IsHold'])&& c_TableList[c_TableClickIndex]['IsTableMerge']==0) {
      if (c_TableList[c_TableClickIndex]['IsHold']) {
        //Hold Order
      }
      else {
        int count = c_TableList.length - 1;
        var dynTNo = GenerateDynamicTableNumber(count);
        TableHandler(
            tableId: c_TableList[0]['TableNumberId'],
            tableNumber: dynTNo,
            seats: c_TableList[0]['NoOfSeats'],
            status: 'Free',
            isDynamic: true,
            isNewDynamicTable: true,
            isMergeTable: c_TableList[0]['IsTableMerge']==1
        );
      }
    }
    else {
      print("a1");
      //Get.snackbar("ffff", "In Free Table, you cant able to create Dynamic Table.");

      CustomAlert().commonErrorAlert("",c_TableList[c_TableClickIndex]['IsTableMerge']==0?errorMessages['freeTable']:errorMessages['mergeTable']);
    }
  }
  else {
    print("a2");
    CustomAlert().commonErrorAlert("Not Found","");
    // errorToast("Not Found")
  }
}

String GenerateDynamicTableNumber(int count) {
  String dynTNo = c_TableList[0]['TableNumber'] + String.fromCharCode(65 + count);
  int z = c_TableList.indexWhere((e) => e['TableNumber'] == dynTNo);
  if (z == -1) {
    return dynTNo;
  }
  else {
    return GenerateDynamicTableNumber(count + 1);
  }
}


/*MERGE TABLE*/
RxBool isMergeTable=RxBool(false);
Future<void> populateFreeTablesOnMerge() async {
  List<dynamic> tables = await getOutletDetail("TableList");
  List<dynamic> filtertables1=tables.where((element) => element['FloorId']==c_FloorId.value && element['TableStatus']=='Free').toList();
  tablesList.value=filtertables1.map((e) => TablesFloor.fromJson(e)).toList();
  tablesList.refresh();
}

