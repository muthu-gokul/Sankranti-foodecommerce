import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../Popup/alertDialog.dart';
import '../../../api/ApiManager.dart';

import '../../../api/sp.dart';
import '../../../models/BillingModel/paymentTypeModel.dart';
import '../../../models/parameterMode.dart';

import '../../../models/BillingModel/cartModel.dart';
import '../../../styles/app_theme.dart';
import '../../../styles/constants.dart';
import '../../../utils/constants.dart';
import '../../../utils/sizeLocal.dart';
import '../../../widgets/animeDialog.dart';
import '../../dynamicTableOrderNumbersNotifier.dart';
import '../../utils.dart';
import '../../utils/apiUtils.dart';
import '../billComplimentNotifier.dart';
import '../cartNotifier.dart';
import '../configuration.dart';
import '../orderSettlementNotifier.dart';
import '../outletDetail.dart';
import '../servicePageNotifier.dart';
import '../settings/getUtils.dart';

var isQSKotBusy=false.obs;
void QuickServiceAddNewHandler() {
  Provider.of<DynamicTableDetails>(Get.context!,listen:false).GetDynamicDetailsHit(c_OrderTypeId.value??0).then((value){
    c_orderDetail.value=new OrderModel();
    c_orderDetail.value!.initOtherServices(value['Table1'][0]['OrderId'], value['Table1'][0]['OrderNumber'], value['Table'][0]['DynamicTable']);
    c_orderDetail.value!.setOrderType();
    c_orderDetail.value!.isMergeTable = false;
    /*Get.back();*/
    clearClickEvents();
   // Get.to(BillingPage());
    if(MyConstants.needUtilRefreshOnEachOrder){
      getBillingUtils();
    }
  });
}

void QuickServiceHandler({ orderId, dynamicNumber, status }) {
  clearClickEvents();
  getTableStatus(null, dynamicNumber.split('-')[1],callback: (response){ getTableStatusResponse(response); },orderId: orderId);
}




List<PaymentTypeMapping> QS_PaymentTypeList = [];
void QuickServiceSingleSettlement(type, {fromCustomerDetailDialog = false}) {
  //console(isQSKotBusy.value,v2: IsBillRaised());
  if (!HasCurrentOrder()) {
    selectTableAlert();
    return;
  }
  if (!HasTotalProducts() && !HasCurrentItems()) {
    CustomAlert().commonErrorAlert("No Orders to Pay...", "");
   // addNotifications(1,msg: "No Orders to Pay...");
    return;
  }
  if(isQSKotBusy.value){
    return;
  }
  if(!fromCustomerDetailDialog && softControls['hasEBill']){
    phoneNumberDialog(type);
    return;
  }
  QS_PaymentTypeList.clear();
  if (type == '1') {
    //CASH
    QS_PaymentTypeList.add(PaymentTypeMapping().createPaymentType( CASH_ID, CASH_NAME, c_orderDetail.value!.grandTotalAmount!.roundToDouble()));
  }
  else if (type == '2') {
    //CARD
    QS_PaymentTypeList.add(PaymentTypeMapping().createPaymentType( CARD_ID, CARD_NAME,c_orderDetail.value!.grandTotalAmount!.roundToDouble()));
  }

  if (IsBillRaised()) {
    QS_InsertSettlement();
  }
  else {
    QS_InsertKot(true);
  }
}

void QS_InsertKot(needSettlement) async{
  log("QS_InsertKot ${isQSKotBusy.value}");
  if(isQSKotBusy.value){
    return;
  }
  isQSKotBusy.value=true;
  try{
    List<ParameterModel> params= await getParameterEssential(needUUID: true);
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.InsertOrderDetail));
    params.addAll(c_orderDetail.value!.insertKotParameters());
    ApiManager.GetInvoke(params,needInputJson: true).then((value){
      if(value[0]){

        //addNotifications(2);
        var response=json.decode(value[1]);
        c_orderDetail.value!.createTotalOrderKotWise(response['Table1'], response['Table2']);
        c_orderDetail.value!.updateTaxOCList(response['Table3'], response['Table4']);
        c_orderDetail.value!.updateConsolidateOtherCharges(response['Table8'],response['Table10']);
        c_orderDetail.value!.updateAddons(response['Table5']);

        if (response['Table9']!=null) {
          if(response['Table9'].length > 0){
            var printerDetail = response['Table9'][0]['OutPutJson'];

          }
        }
        c_orderDetail.value!.productList!.clear();
        c_orderDetail.refresh();
        // addNotifications(2);
        //clearLNProductList();
        setUUID(kotUUID);
        isQSKotBusy.value=false;
        if(IsBillCompliment()){
          InsertBillCompliment(1,"");
        }
        else{
          QS_InsertBill(needSettlement);
        }
      }
      else{
        isQSKotBusy.value=false;
      }
    });
  }catch(e){
    isQSKotBusy.value=false;
  }
}

void QS_InsertBill(needSettlement) async{
  if(!isHasBillSettingsAccess(featuresAccessId['Bill'])){
    CustomAlert().commonErrorAlert("Access Denied","");
    return;
  }
  log("QS_InsertBill ${isQSKotBusy.value}");
  if(isQSKotBusy.value){
    return;
  }
  isQSKotBusy.value=true;
  try{
    List<ParameterModel> params= await getParameterEssential(needUUID: true,uuidKey: "BillKey",uuidSPKey: billUUID);
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.InvoiceBill));
    params.addAll(c_orderDetail.value!.insertBillParameters());
    ApiManager.GetInvoke(params,needInputJson: true).then((value){
      if(value[0]){

        var response=json.decode(value[1]);
        c_orderDetail.value!.billId=response['Table'][0]['BillId'];
        // billSuccessToast(isSettle: false);
        setUUID(billUUID);
        isQSKotBusy.value=false;
        if(needSettlement){
          QS_InsertSettlement();
        }
        if(isHasBillSettingsAccess(featuresAccessId['BillPrint'])){
          if (response['Table1']!=null) {
            if(response['Table1'].length > 0){
              var printerDetail = response['Table1'][0]['OutPutJson'];
              //getPrinterTemplate(printerDetail);
            }
          }
        }
      }
      else{
        isQSKotBusy.value=false;
      }
    });
  }catch(e){
    isQSKotBusy.value=false;
  }
}

void QS_InsertSettlement() async{
  if(!isHasBillSettingsAccess(featuresAccessId['BillSettlement'])){
    return;
  }
  if(isQSKotBusy.value){
    return;
  }
  isQSKotBusy.value=true;
  try{
    List<ParameterModel> params= await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.InvoiceBillSettlement));
    params.addAll(c_orderDetail.value!.insertSettlementParameters(QS_PaymentTypeList));
    params.add(ParameterModel(Key: "InputJson", Type: "String", Value: json.encode(params)));
    ApiManager.GetInvoke(params).then((value){
      //console("settle",v2: value);
      isQSKotBusy.value=false;
      if(value[0]){
        var response=json.decode(value[1]);
        /*var response=json.decode(value[1]);
      c_orderDetail.value!.billId=response['Table'][0]['BillId'];
      print("c_orderDetail.value!.billId ${c_orderDetail.value!.billId}");*/
        //billSuccessToast(isSettle: true);
        if(isHasBillSettingsAccess(featuresAccessId['BillSettlementPrint'])){
          if (response['Table']!=null) {
            if(response['Table'].length > 0){
              var printerDetail = response['Table'][0]['OutPutJson'];
              //getPrinterTemplate(printerDetail);
            }
          }
        }
        if(isHasBillSettingsAccess(featuresAccessId['BillSettlementNotification']))
          addNotifications(NotificationType.success,msg: errorMessages['billSettled']);
        DestroyOrder();
        QuickServiceAddNewHandler();
      }
    });
  }catch(e){
    isQSKotBusy.value=false;
  }
}

Color smsBorderColor=Colors.grey[300]!;
void phoneNumberDialog(type){
  AnimeDialog().fadeTransition(
    Get.context!,
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      content: Container(
        //height: SizeConfig.screenHeight!*0.7,
        width: SizeConfig.screenWidth!*0.45,
        padding: EdgeInsets.all(50),
        child: Form(
          //key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 80,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 60,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Color(0xFFE4E4E4),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Text("Email",style: TextStyle(fontFamily: 'RR',fontSize: 20,color: AppTheme.darkGrey2),),
                            Text("SMS",style: TextStyle(fontFamily: 'RR',fontSize: 20,color: AppTheme.darkGrey2)),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset("assets/payScreen/send.png",height: 80,),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: TextFormField(
                  //controller: bnn.phoneNoController,
                  style: TextStyle(fontFamily: 'RR',fontSize: 20,color: AppTheme.darkGrey2),
                  decoration: InputDecoration(
                      fillColor: Color(0xFFe4e4e4),
                      labelText: "Phone Number",
                      labelStyle: TextStyle(fontFamily: 'RL',color: Color(0xFF9D9D9D)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: smsBorderColor)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: smsBorderColor)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: smsBorderColor)
                      ),
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                      errorStyle: TextStyle(color: Colors.red.withOpacity(0.8),fontSize: 16)
                  ),
                  keyboardType: TextInputType.phone,
                  validator:(value){

                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(phoneNoLength),
                    FilteringTextInputFormatter.allow(RegExp(digitRegEx)),
                  ],
                ),
              ),
              SizedBox(height: 40,),
              /*  Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(5)
                ),
                alignment: Alignment.center,
                child: TextFormField(
                  onTap: (){
                   // formKey.currentState!.reset();
                  },
                 // controller: bnn.emailController,
                  style: TextStyle(fontFamily: 'RR',fontSize: 20,color: AppTheme.darkGrey2),
                  decoration: InputDecoration(
                      fillColor: Color(0xFFe4e4e4),
                      labelText: "Email",
                      labelStyle: TextStyle(fontFamily: 'RL',color: Color(0xFF9D9D9D)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: smsBorderColor)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: smsBorderColor)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: smsBorderColor)
                      ),
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                      errorStyle: TextStyle(color: Colors.red.withOpacity(0.8),fontSize: 16)
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator:(value){

                    Pattern pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = new RegExp(pattern as String);
                    if (!regex.hasMatch(value!)) {
                      return '* Email format is invalid';
                    } else {
                      return null;
                    }
                  },
                  inputFormatters: [
                    // FilteringTextInputFormatter.allow(RegExp(alphaSpaceRegEx)),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SizedBox(width: 20,),
                      Text("Add More details",
                        style: TextStyle(fontFamily: 'RR',color: AppTheme.red,fontSize: 20,letterSpacing: 0.2),
                      ),
                      SizedBox(width: 15,),
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.red,
                        ),
                        child: Center(
                          child: Icon(Icons.keyboard_arrow_right_rounded,color: Colors.white,),
                        ),
                      )
                    ],
                  ),
                ),
              ),*/
              //Spacer(),
              GestureDetector(
                onTap: (){
                  QuickServiceSingleSettlement(type,fromCustomerDetailDialog: true);
                  Get.back();
                },
                child: Container(
                  height: 65.0,
                  width: 165.0,
                  // margin: EdgeInsets.only(bottom: 20,top:20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
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
                    child: Text("Pay",
                      style: TextStyle(fontFamily:'RM',color: Colors.white,fontSize: 20,letterSpacing: 0.2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    200,
    isBarrierDismissable: false, onclose: () {  },
  );
}
