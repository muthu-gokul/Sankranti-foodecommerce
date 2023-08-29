import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../styles/app_theme.dart';
import '../styles/style.dart';
import '../utils/constants.dart';
import 'Billing/billingController.dart';
import 'Billing/cartNotifier.dart';
import 'Billing/configuration.dart';
import 'Billing/floorsOrderTypePopulate.dart';
import 'Billing/outletDetail.dart';
import 'Billing/settings/intervalCallManager.dart';
import 'Billing/tableNotifier.dart';


var isMenuListClick=false.obs;
var isFunctionPopUpOpen=false.obs;
var showKotWiseOrder=false.obs;
var blurAboveBillScreen=false.obs;
var showBillPreview=false.obs;
var cartOpen=false.obs;
var isFilter=false.obs;

var kotClick=false.obs;
var billClick=false.obs;
var settlementClick=false.obs;
var isProductWeightOpen=false.obs;


void openKotWiseOrder(){
    showKotWiseOrder.value=true;
    showBillPreview.value=false;
}

void changeCartClick(){
    cartOpen.value=!cartOpen.value;
}

void TogglePopUp(action) {
  switch (action) {
      case 'o_Menu': { isMenuListClick.value=true; }
      break;
      case 'c_Menu': {isMenuListClick.value=false;}
      break;
      case 'o_Function': {isFunctionPopUpOpen.value=true;}
      break;
      case 'c_Function': {isFunctionPopUpOpen.value=false;}
      break;
      case 'c_AllServices': {
        /*var isMergeChecked = $("#merge-table").prop('checked');
        if (isMergeChecked)
          $("#merge-table").prop('checked', false).trigger('change');
        document.getElementById("mySidenav").style.left = "-100%";*/
      };
      break;
      case 'o_OverAllDiscount': {

      }
      break;
      case 'c_OverAllDiscount': {

      }
      break;
      case 'o_ItemwiseDiscount': {
      }
      break;
      case 'c_ItemwiseDiscount': {
      }
      break;
      case 'o_PayScreen': {
      }
      break;
      case 'c_PayScreen': {
      }
      break;
      case 'o_BillHistory': {

      }
      break;
      case 'c_BillHistory': {
      }
      break;
      case 'c_Covers': {
          guestNoController.reverse();
      }
      break;
      case 'clearCoversEntry': {
          x_coverEntry.value="";
          x_tableNumber.value="Table No";
      }
      break;
  }
}

String GetOrderTypeImage(id, isActive) {
    switch (id) {
        case '1': {
            if (isActive)
                return "assets/ordertype/dinein.svg";
            else
                return "assets/ordertype/dineinactive.svg";
        }

        case '2': {
            if (isActive)
                return "assets/ordertype/takeaway.svg";
            else
                return "assets/ordertype/takeawayinactive.svg";
        }

        case '3': {
            if (isActive)
                return "assets/ordertype/homedelivery.svg";
            else
                return "assets/ordertype/homedeliveryinactive.svg";
        }

        case '4': {
            if (isActive)
                return "assets/ordertype/quickservice.svg";
            else
                return "assets/ordertype/quickserviceinactive.svg";
        }
        default:
            return "assets/ordertype/dinein.svg";

    }
}

int subCategoryMaxLength=10;
int itemCrossAxisCount=6;
int itemCount=18;

void ToggleOrderType(int orderType, String otName){
    //DestroyOrder();
    setOrderType(orderType,otName);
    //populateProducts(c_CategoryId.value, orderType);

    switch(orderType){
        case DINEIN_ID:{
            populateTables(c_FloorId.value);
        }
        break;
        case TAKEAWAY_ID:{
            populateTakeAway(c_FloorId.value);
        }
        break;
        case HOMEDELIVERY_ID:{
            populateHomeDelivery(c_FloorId.value);
        }
        break;
        case QUICLSERVICE_ID:{
            populateQuickService(c_FloorId.value);
        }
        break;
    }
}

parseDouble(var value){
    try{
        return double.parse(value.toString());
    }catch(e){}
    return 0.0;
}
parseInt(var value){
    try{
        return int.parse(value.toString());
    }catch(e){}
    return 0;
}
String GetPSOTHeader(type) {
    switch (type.toString()) {
        case '1': return 'Table No';
        case '2': return 'TakeAway No';
        case '3': return 'HomeDelivery No';
        case '4': return 'QuickService No';
        default: return 'Order No';
    }
}

class BillPreviewFooter extends StatelessWidget {
    String? title;
    dynamic value;
    double padding;
    BillPreviewFooter({this.title,this.value,this.padding=10});
    @override
    Widget build(BuildContext context) {
        return Padding(
            padding:  EdgeInsets.only(bottom: padding),
            child: Row(
                children: [
                    Text(title!,style: TextStyle(fontFamily: 'RM',color: Color(0xFF575757),fontSize: 16),),
                    Spacer(),
                    Text("${value!}",style: TextStyle(fontFamily: 'RM',color: Color(0xFF575757),fontSize: 16),),
                ],
            ),
        );
    }
}


//Filters


RxList<String> filterAlphabets=RxList<String>();
RxnInt filterAlphabetSelected=RxnInt(-1);
void filterProductAlphabet(String letter,int index) async{
    console(c_CategoryId.value);
    filterAlphabetSelected.value=index;
    List<dynamic> productList = await getOutletDetail("ProductList");
    List<dynamic> productOtherChargesMappingList = await getOutletDetail("ProductOtherChargesList");
    List<dynamic> productTaxMappingList = await getOutletDetail("ProductTaxList");
    if(c_CategoryId.value==0 || c_CategoryId.value==null){
        filterproduct.value=productList.where((element) =>element['MenuId'] == c_MenuId.value && element['ProductName'][0].toString().toUpperCase()==letter).toList();
    }
    else{
        filterproduct.value=productList.where((element) =>element['MenuId'] == c_MenuId.value && element['ParentProductCategoryId'] == c_CategoryId.value &&
            element['ProductName'][0].toString().toUpperCase()==letter).toList();
    }

    var productFloorWisePriceList=[];
    if(c_OrderTypeId.value==DINEIN_ID){
        productFloorWisePriceList = await getOutletDetail('ProductFloorPriceList');
        productFloorWisePriceList=productFloorWisePriceList.where((y) => y['MenuId']==c_MenuId.value).toList();
    }

    filterproduct.forEach((element) {
        List<dynamic> productOCList=productOtherChargesMappingList.where((f) => f['ProductId']==element['ProductId'] && f['OrderTypeId']==c_OrderTypeId.value).toList();
        List<dynamic> productTaxList=productTaxMappingList.where((e) => e['ProductId']==element['ProductId']).toList();
        element['ProductOtherChargesList']=productOCList;
        element['ProductTaxList']=productTaxList;
        var productPrice = 0.0;
        if (c_OrderTypeId.value == DINEIN_ID) {
            var currentPP = productFloorWisePriceList.where((z) => z['ProductId']==element['ProductId']).toList();
            if (currentPP.length > 0) {
                productPrice = currentPP[0][c_FloorId.value.toString()] ?? 0;
            }
        }
        else {
            productPrice = element[c_OrderTypeId.value.toString()]??0.0;
        }
        element['Price']=productPrice;
    });
    itemSplashCountArray=List.filled(filterproduct.length, 0);
    itemIndicator();
    filterproduct.refresh();
}


bool isNumeric(String result) {
    if (result == null) {
        return false;
    }
    return double.tryParse(result) != null;
}


Future<void> itemSearchFunc(String value) async {
    if(value.isEmpty){
        updateMainCategory(0);
    }
    else{
        List<dynamic> productList = await getOutletDetail("ProductList");
        List<dynamic> productOtherChargesMappingList = await getOutletDetail("ProductOtherChargesList");
        List<dynamic> productTaxMappingList = await getOutletDetail("ProductTaxList");

        int menuIndex=filtermenu.indexWhere((element) => element.MenuId==c_MenuId.value);
        int menuId=c_MenuId.value??0;
        if(menuIndex==-1){
            return;
        }

        if(filtermenu[menuIndex].isCustomMenu){
            int defaultMenuIndex=filtermenu.indexWhere((element) => element.isDefault==true);
            if(defaultMenuIndex!=-1){
                menuId=filtermenu[defaultMenuIndex].MenuId??0;
            }
        }

        if(isNumeric(value)==true){
            filterproduct.value=productList.where((element) => element['MenuId'] == menuId &&
            element['ProductCode'].toString()==value).toList();
        }
        else{
            filterproduct.value=productList.where((element) => element['MenuId'] == menuId &&(
                element['ProductCode'].toString()==value ||  element['ProductShortform'].toString().toLowerCase().contains(value.toLowerCase())
                    ||  element['ProductName'].toString().toLowerCase().contains(value.toLowerCase()))).toList();
        }

        var productFloorWisePriceList=[];
        if(c_OrderTypeId.value==DINEIN_ID){
            productFloorWisePriceList = await getOutletDetail('ProductFloorPriceList');
            productFloorWisePriceList=productFloorWisePriceList.where((y) => y['MenuId']==menuId).toList();
        }

        filterproduct.forEach((element){
            List<dynamic> productOCList=productOtherChargesMappingList.where((f) => f['ProductId']==element['ProductId'] && f['OrderTypeId']==c_OrderTypeId.value).toList();
            List<dynamic> productTaxList=productTaxMappingList.where((e) => e['ProductId']==element['ProductId']).toList();
            element['ProductOtherChargesList']=productOCList;
            element['ProductTaxList']=productTaxList;
            var productPrice = 0.0;
            if (c_OrderTypeId.value == DINEIN_ID) {
                var currentPP = productFloorWisePriceList.where((z) => z['ProductId']==element['ProductId']).toList();
                if (currentPP.length > 0) {
                    productPrice = currentPP[0][c_FloorId.value.toString()] ?? 0;
                }
            }
            else {
                productPrice = element[c_OrderTypeId.value.toString()]??0.0;
            }
            element['Price']=productPrice;
            element[MyConstants.itemBlockPrefix+c_OrderTypeId.value.toString()]=IsProductBlock(element['ProductId'], c_OrderTypeId.value.toString())?1:0;
        });
        itemSplashCountArray=List.filled(filterproduct.length, 0);
        itemIndicator();
    }
}

const int SOCKET_TIMEOUT=800;

Map<String,dynamic> softControls={
    "hasExeBillPrinting":false,
    "hasExeKotPrinting":false,
    "hasExePrinting":false,
    "printerActionUrl":"http://192.168.1.140:9876/api/Printer/InvokePOSPrinter",
    "printerActionIp":"192.168.1.140",
    "hasEBill":false
};

Map<String,dynamic> errorMessages={
    "onlineOrderExeNotConnected": "Online Order Not initiated. Contact Administrator",
    "loginToSwiggy": "Please Login to swiggy account...",
    "noswiggy": "Outlet doesnot have Swiggy Integration",
    "nozomato": "Outlet doesnot have Zomato Integration",
    "loginToZomato": "Please Login to Zomato account...",
    "kotNotiMsg": "KoT Raised...",
    "discountAmountHigher": "Discount Amount Should be less than ",
    "clearCurrentItems": "Clear Pending Items to Raise Bill...",
    "freeTable": "In Free Table, you cant able to create Dynamic Table.",
    "mergeTable": "In Merge Table, you cant able to create Dynamic Table.",
    "deleteKot": "Bill Raised, you cant able to Delete KoT.",
    "billComp":"No Orders to make Bill Compliment",
    "billCompBR":"Bill Raised, you cant able to make Bill Compliment...",
    "billCompDis":"You cant apply Discount for Compliment Bill...",
    "noOrdersToBill":"No Orders to Raise Bill...",
    "kotRaised":"Kot Raised Successfully...",
    "billRaised":"Bill Raised Successfully...",
    "billSettled":"Bill Settled Successfully..."
};

List<dynamic> accessData=[];
List<dynamic> billSettingsAccessData=[];
bool isHasAccess(int uniqueId){
    try{
        int IsHasAccess=accessData.where((element) => element['UniqueId']==uniqueId).toList()[0]['IsHasAccess'];
        return IsHasAccess==1;
    }catch(e){
        return false;
    }
}
bool isHasBillSettingsAccess(int uniqueId){
    try{
        bool IsHasAccess=billSettingsAccessData.where((element) => element['SettingModuleId']==uniqueId).toList()[0]['IsActive'];
        return IsHasAccess;
    }catch(e){
        return false;
    }
}



const String SP_IMAGEDOWNLOADED="id";
const String SP_LOCAL_IP="localip";
setSharedPrefBool(bool value,String key) async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    sp.setBool(key, value);
}
getSharedPrefBool(String key) async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    return sp.getBool(key)??false;
}

setSharedPrefString(dynamic value,String key) async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    sp.setString(key, value.toString());
}
getSharedPrefString(String key) async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    return sp.getString(key)??"";
}

Map<String,dynamic> tabCustomSettingsInfo={
    "bluetoothPrinterBrand":"dmin"
};

String getCustomSubString(dynamic x,int length){
    if(x.toString().length>length){
        return x.toString().substring(0,length);
    }
    else{
        return x.toString();
    }
}

class MySeparatorPrinter extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        return Container(
            width: 400,
            child: Text("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                style: TextStyle(fontSize: 20,),textAlign: TextAlign.center,overflow: TextOverflow.clip,maxLines: 1
            )
        );
    }
}

void DestroyOnLogout(){
    cancelIntervalTimer();
    sysTimer=null;
    destroySecTimer();
    //closeSignalRConn();
    if(secondaryTimer!=null){
        secondaryTimer!.cancel();
        secondaryTimer=null;
    }
    //signalRHelper=null;
}

enum NotificationType {
    success,
    error,
    info
}
void addNotifications(NotificationType notificationType,{String msg=""}){
    if(notificationType==NotificationType.success){
        Get.snackbar(
            "",
            "",
            titleText:Text("Success",style: ts18(AppTheme.bgColor,fontfamily: 'RM'),),
            messageText: Text(msg,style: ts15(AppTheme.darkGrey2),),
            icon: Container(
                height: 20,
                width: 20,
                child: Image(image: AssetImage("assets/icons/success.png",), width: 20,)),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white,
            borderRadius: 20,
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            colorText: AppTheme.bgColor,
            duration: Duration(milliseconds: 1000),
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack,
        );
       /* ElegantNotification.success(
            title:  Text("Success",style: ts18(AppTheme.bgColor),),
            description:  Text(msg,style: ts15(AppTheme.darkGrey1),),
        ).show(Get.context!);*/
    }
    else if(notificationType==NotificationType.error){
        Get.snackbar(
            "",
            "",
            titleText:Text("Error",style: ts18(AppTheme.bgColor,fontfamily: 'RM'),),
            messageText: Text(msg,style: ts15(AppTheme.darkGrey2),),
            icon: Container(
                height: 20,
                width: 20,
                child: Image(image: AssetImage("assets/icons/error.png",), width: 20,)),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white,
            borderRadius: 20,
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            colorText: AppTheme.bgColor,
            duration: Duration(milliseconds: 1500),
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack
        );
    }
    else if(notificationType==NotificationType.info){
        Get.snackbar(
            "Info",
            "",
            titleText:Text("Info",style: ts18(AppTheme.bgColor,fontfamily: 'RM'),),
            messageText: Text(msg,style: ts15(AppTheme.darkGrey2),),
            icon: Container(
                height: 20,
                width: 20,
                child: Image(image: AssetImage("assets/icons/info.png",), width: 20,)),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white,
            borderRadius: 20,
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            colorText: AppTheme.bgColor,
            duration: Duration(milliseconds: 1000),
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack,
        );
    }
}

void getxOverlayClose(){
    Get.back(closeOverlays: true);
}

void console(dynamic v1,{dynamic v2="",dynamic v3=""}){
    log(v1.toString()+"#"+v2.toString()+"#"+v3.toString());
}


// Local Settings
var isListView=false.obs;

Future<Directory?> getApplicationPath() async{
    print("Platform.isAndroid ${Platform.isAndroid}");
    if(Platform.isAndroid){
        return await getExternalStorageDirectory();
    }
    return await getApplicationDocumentsDirectory();
}
