import 'dart:convert';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';
import '../../Popup/alertDialog.dart';
import '../../api/sp.dart';
import '../../pages/navHomeScreen.dart';
import '../../utils/constants.dart';
import '../../widgets/calculation.dart';
import '../../api/ApiManager.dart';
import '../../models/BillingModel/cartModel.dart';
import '../../models/BillingModel/paymentTypeModel.dart';
import '../../models/parameterMode.dart';
import '../utils.dart';
import '../utils/apiUtils.dart';
import 'billComplimentNotifier.dart';
import 'cartNotifier.dart';
import 'configuration.dart';
import 'otherServices/homeDeliveryNotifier.dart';
import 'otherServices/quickServiceHandler.dart';
import 'otherServices/takeAwayNotifier.dart';
import 'outletDetail.dart';
import 'servicePageNotifier.dart';
import 'settings/getUtils.dart';
bool HasDirectPayOption() {
  return isHasBillSettingsAccess(featuresAccessId["HasDirectPayOption"]);
}
kotClickHandler() async{
  if (!HasCurrentOrder()) {
    selectTableAlert();
    return;
  }
  if (!HasCurrentItems()) {
    CustomAlert().commonErrorAlert("Select items to make KoT.", "");
    return;
  }
  if (IsBillRaised()) {
    CustomAlert().commonErrorAlert("Bill Raised...", "You cant place KOT...");
    return;
  }
  if(kotClick.value){
    return;
  }
  log("QS_InsertKot ${kotClick.value}");
  kotClick.value=true;

  try{
    InsertKotWithCallback((response){
      if (c_OrderTypeId.value == DINEIN_ID) {
        SetOrderDetailFromKot(response);
        //openKotWiseOrder();
      }
      else if (c_OrderTypeId.value == TAKEAWAY_ID) {
        getxOverlayClose();
        getTableStatus(null, null);
      }
      else if (c_OrderTypeId.value == HOMEDELIVERY_ID) {
        HomeDeliveryAddNewHandler();
      }
    });
  }catch(e){
    kotClick.value=false;
  }
}

void InsertKotWithCallback(callback) async{
  List<ParameterModel> params= await getParameterEssential(needUUID: true);
  params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.InsertOrderDetail));
  params.addAll(c_orderDetail.value!.insertKotParameters());
  ApiManager.GetInvoke(params,needInputJson: true).then((value){

    if(value[0]){

      var response=json.decode(value[1]);
      callback(response);


      if(isHasBillSettingsAccess(featuresAccessId['KOTPrint'])){
        log("${response['Table9']}");
        if (response['Table9']!=null) {
          if(response['Table9'].length > 0){
            try{
              var printerDetail = response['Table9'][0]['OutPutJson'];
              //getPrinterTemplate(printerDetail);
            }
            catch(e){
              CustomAlert().commonErrorAlert("KoT Print Response", e.toString());
            }
          }
        }
      }

      c_orderDetail.value!.productList!.clear();
      c_orderDetail.refresh();
      setUUID(kotUUID);
      try{
        if(isHasBillSettingsAccess(featuresAccessId['KOTNotification']))
          addNotifications(NotificationType.success,msg: errorMessages['kotRaised']);
      }catch(e){}
      kotClick.value=false;
    }
    else{
      kotClick.value=false;
    }
  });
}
void SetOrderDetailFromKot(response) {
  c_orderDetail.value!.updateConsolidateOtherCharges(response['Table8'] as List,response['Table10']);
  c_orderDetail.value!.updateTaxOCList(response['Table3'] as List,response['Table4'] as List);
  c_orderDetail.value!.createTotalOrderKotWise(response['Table1'] as List,response['Table2'] as List);
  c_orderDetail.value!.updateAddons(response['Table5'] as List);
}



RxList<PaymentTypeMapping> paymentTypeList = RxList<PaymentTypeMapping>();
RxDouble toPay = 0.0.obs;
var balanceToPay = 0.0.obs;
var totalAmount = 0.0.obs;
var balance = 0.0.obs;
var payScreenRoundOffAmount = 0.0.obs;
var PS_OT_Header = "".obs;
var PS_OT_Title = "".obs;
TextEditingController PS_NumpadEntry = new TextEditingController();

void OpenPayScreenLN() {
  if (!HasCurrentOrder()) {
    selectTableAlert();
    return;
  }
  if (c_orderDetail.value!.productList!.length != 0) {
    CustomAlert().commonErrorAlert("Clear Pending Items to make payment", "");
    //errorToast("Clear Pending Items to make payment");
    return;
  }
  //Provider.of<PayPopUpNotifier>(Get.context!,listen: false).changePopUpStatus(true);
  PopulatePayScreenLN(c_orderDetail.value!);

}

var PS_SubTotal=0.0.obs;
var PS_DiscountAmount=0.0.obs;
var PS_AddOnsAmount=0.0.obs;
//var PS_TaxList=[].obs;
RxList<dynamic> PS_TaxList=new RxList<dynamic>();
RxList<dynamic> PS_ConsolidateOtherCharges=new RxList<dynamic>();

var isTaxExemption=false.obs;

void PopulatePayScreenLN(OrderModel orderDetail){
  paymentTypeList.clear();
  toPay.value = 0.0;
  payScreenRoundOffAmount.value = orderDetail.roundOffAmount!;
  var grandTotalAmount = orderDetail.grandTotalAmount;
  PS_AddOnsAmount.value=0.0;
  PS_SubTotal.value=orderDetail.subTotal!;
  PS_DiscountAmount.value=orderDetail.discountAmount!;
  PS_TaxList.clear();
  PS_ConsolidateOtherCharges.clear();
  orderDetail.taxList!.forEach((element) {
    PS_TaxList.add(json.decode(json.encode(element)));
  });
  orderDetail.consolidateOtherCharges!.forEach((element) {
    PS_ConsolidateOtherCharges.add(json.decode(json.encode(element)));
  });
  if(orderDetail.addonAmount!>0){
    PS_AddOnsAmount.value=orderDetail.addonAmount!;
  }
  balanceToPay.value=grandTotalAmount!;
  toPay.value=grandTotalAmount;
  totalAmount.value=grandTotalAmount;

  PS_OT_Header.value=GetPSOTHeader(orderDetail.orderTypeId.toString());
  PS_OT_Title.value=orderDetail.tableNumber.toString();
  PS_NumpadEntry.text=orderDetail.grandTotalAmount!.toString();
  isTaxExemption.value=orderDetail.isTaxExemption!;

  CalcWithExemption();
}


void CalcWithExemption() {
  paymentTypeList.clear();
  totalAmount.value = toPay.value;
  if (c_orderDetail.value!.isBillSplit!) {
    /*if ($("#divPayScreenLN").find(".tax-charge").hasClass('no-charge')) {
      totalAmount = nerdamerCalc('-', totalAmount, c_orderDetail.billSplitDetailArr[BS_CoversCustomerIndex].orderDetail.taxAmount);
      c_orderDetail.billSplitDetailArr[BS_CoversCustomerIndex].orderDetail.taxList.forEach((e) => { e.isExemption = true; });
    }
    else {
      c_orderDetail.billSplitDetailArr[BS_CoversCustomerIndex].orderDetail.taxList.forEach((e) => { e.isExemption = false; });
    }

    c_orderDetail.billSplitDetailArr[BS_CoversCustomerIndex].orderDetail.consolidateOtherCharges.forEach((e) => {
        if (e.isExemption) {
            totalAmount = nerdamerCalc('-', totalAmount, e.OtherChargesAmount);
      }
    });*/
  }
  else {
    if(isTaxExemption.value){
      totalAmount.value=Calculation().sub(totalAmount.value, c_orderDetail.value!.taxAmount);
      PS_TaxList.forEach((element) {  element['isExemption']=true;  });
    }
    else{
      PS_TaxList.forEach((element) {  element['isExemption']=false;  });
    }
    PS_TaxList.refresh();
    PS_ConsolidateOtherCharges.forEach((e){
        if (e['isExemption']) {
          totalAmount.value = Calculation().sub(totalAmount.value, e['OtherChargesAmount']);
        }
      });
  }



  PaymentTotalCalculation();
}

void PaymentTotalCalculation() {
  var paidAmt = 0.0;
  payScreenRoundOffAmount.value=Calculation().sub(totalAmount.value.round(), totalAmount.value);
  totalAmount.value=Calculation().add(totalAmount.value, payScreenRoundOffAmount.value);
  paymentTypeList.forEach((element) {
    paidAmt=Calculation().add(paidAmt, element.amount);
  });
  balanceToPay.value=Calculation().sub(totalAmount.value.round(), paidAmt);
  balance.value=0.0;
  PopulatePSAfterCalc();
/*  paymentTypeList.forEach((v, i) => {
  paidAmt = nerdamerCalc('+', paidAmt, v.Amount);
  });
  balanceToPay = nerdamerCalc('-', totalAmount, paidAmt);
  balance = 0;
  ;*/
}

PopulatePSAfterCalc(){
  PS_NumpadEntry.text=balanceToPay.value.toString();
}

void PaymentCalculation(typeId, typeName) {
  var paidAmt = 0.0;
  paymentTypeList.forEach((element) {
    paidAmt=Calculation().add(paidAmt, element.amount);
  });
  balanceToPay.value=Calculation().sub(totalAmount.value, paidAmt);
  var currentEntryAmt = parseDouble(PS_NumpadEntry.text);
  if (currentEntryAmt > balanceToPay.value) {
    balance.value = Calculation().sub(currentEntryAmt, balanceToPay.value);
    checkPaymentTypeExists(typeId, typeName, balanceToPay);
    balanceToPay.value = 0.0;
  }
  else {
    checkPaymentTypeExists(typeId, typeName, currentEntryAmt);
    balanceToPay.value = double.parse(p.parse("${totalAmount.value}-($paidAmt+$currentEntryAmt)").evaluate(EvaluationType.REAL, cm).toStringAsFixed(13));
    balance.value = 0;
  }
  PopulatePSAfterCalc();
  if (balanceToPay.value == 0) {
    if (c_orderDetail.value!.isBillSplit!) {
      //BillSplitSettlement();
    }
    else {
      Settlement();
    }
  }
}
void PaymentTypeHandler(type) {
  if (type == '1') {
    //CASH
    PaymentCalculation(CASH_ID, CASH_NAME);
  }
  else if (type == '2') {
    //CARD
    PaymentCalculation(CARD_ID, CARD_NAME);
  }
}

void checkPaymentTypeExists(typeId, typeName, balanceToPay){
  int index = paymentTypeList.indexWhere((e) => e.paymentId.toString() == typeId.toString());
  if (index == -1) {
    paymentTypeList.add(PaymentTypeMapping().createPaymentType( typeId, typeName, balanceToPay));
  }
  else {
    paymentTypeList[index].amount = Calculation().add(paymentTypeList[index].amount, balanceToPay);
  }
  paymentTypeList.refresh();
}

void deletePaymentType(index){
  paymentTypeList.removeAt(index);
  paymentTypeList.refresh();
  PaymentTotalCalculation();
}

void numberPadEntryFunc(int keypad){
  if (keypad == -1) {
    //"X"
    var disVal = PS_NumpadEntry.text;
    PS_NumpadEntry.text=disVal.substring(0, disVal.length - 1);
  }
  else if (keypad == -2) {
    //'C'
    PS_NumpadEntry.text="";
  }
  else if (keypad == -3) {
    //'.'
    var disVal = PS_NumpadEntry.text;
    if (!disVal.contains('.') && disVal.isNotEmpty) {
      disVal += '.';
      PS_NumpadEntry.text=disVal;
    }

  }
  else {
    var disVal = PS_NumpadEntry.text;
    if(parseDouble(PS_NumpadEntry.text) == balanceToPay.value){
      disVal="";
    }
    disVal += keypad.toString();
    PS_NumpadEntry.text=disVal;
  }
}

void Settlement() {
  if (IsBillCompliment()) {
    if(isHasBillSettingsAccess(featuresAccessId['BillSettlement'])){
      SettleBillCompAlert();
    }
    else{
      CustomAlert().commonErrorAlert("Access Denied", "");
    }
  }
  else{
    if (HasDirectPayOption()){
      if (HasCurrentItems()) {
        InsertKotWithCallback((response){
          SetOrderDetailFromKot(response);
          InsertBillDetail(needSettlement: true,needNewOrder: true);
        });
      }
      else {
        if (IsBillRaised()) {
          InsertSettlement(needNewOrder: true);
        }
        else {
          InsertBillDetail(needSettlement: true,needNewOrder: true);
        }
      }
    }
    else{
      if (IsBillRaised()) {
        InsertSettlement();
      }
      else {
        InsertBillDetail(needSettlement: true);
      }
    }
  }
}

void InsertBillDetail({needSettlement=false,needNewOrder=false}) async{
  if(!isHasBillSettingsAccess(featuresAccessId['Bill'])){
    CustomAlert().commonErrorAlert("Access Denied","");
    return;
  }
  if(!HasTotalProducts()){
    CustomAlert().commonErrorAlert(errorMessages['noOrdersToBill'],"");
    return;
  }
/*  c_orderDetail.value!.taxList!.forEach((element) {
    element.isExemption= c_orderDetail.value!.isTaxExemption;
  });
  for(int i=0;i<PS_ConsolidateOtherCharges.length;i++){
    c_orderDetail.value!.otherChargesList!.where((element) => element.OtherChargesCategoryId==PS_ConsolidateOtherCharges[i]['OtherChargesCategoryId']).toList().forEach((element) {element.isExemption=PS_ConsolidateOtherCharges[i]['isExemption'];});
  }*/

  if(billClick.value){
    return;
  }
  billClick.value=true;
  try{
    params=await getParameterEssential(needUUID: true,uuidKey: "BillKey",uuidSPKey: billUUID);
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.InvoiceBill));
    params.addAll(c_orderDetail.value!.insertBillParameters());
    ApiManager.GetInvoke(params,needInputJson: true).then((value){
      billClick.value=false;
      if(value[0]){
        var response=json.decode(value[1]);
        c_orderDetail.value!.billId=response['Table'][0]['BillId'];
        setUUID(billUUID);
        if(isHasBillSettingsAccess(featuresAccessId['BillNotification']))
          addNotifications(NotificationType.success,msg: errorMessages['billRaised']);
        if(needSettlement){
          InsertSettlement(needNewOrder: needNewOrder);
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
    });
  }catch(e){
    billClick.value=false;
  }
}
void InsertBillDetailWithCallback(callback,{needSettlement=false,needNewOrder=false}) async{
  if(!HasTotalProducts()){
    addNotifications(NotificationType.error,msg: errorMessages['noOrdersToBill']);
    return;
  }
  if(billClick.value){
    return;
  }
  billClick.value=true;

  try{
    c_orderDetail.value!.taxList!.forEach((element) {
      element.isExemption= isTaxExemption.value;
    });
    for(int i=0;i<PS_ConsolidateOtherCharges.length;i++){
      c_orderDetail.value!.otherChargesList!.where((element) => element.OtherChargesCategoryId==PS_ConsolidateOtherCharges[i]['OtherChargesCategoryId']).toList().forEach((element) {element.isExemption=PS_ConsolidateOtherCharges[i]['isExemption'];});
    }

    params=await getParameterEssential(needUUID: true,uuidKey: "BillKey",uuidSPKey: billUUID);
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.InvoiceBill));
    params.addAll(c_orderDetail.value!.insertBillParameters());

    ApiManager.GetInvoke(params,needInputJson: true).then((value){

      if(value[0]){
        var response=json.decode(value[1]);
        c_orderDetail.value!.billId=response['Table'][0]['BillId'];
        setUUID(billUUID);
        billClick.value=false;
        if(isHasBillSettingsAccess(featuresAccessId['BillNotification']))
          addNotifications(NotificationType.success,msg: errorMessages['billRaised']);
        if(isHasBillSettingsAccess(featuresAccessId['BillPrint'])){
          if (response['Table1']!=null) {
            if(response['Table1'].length > 0){
              var printerDetail = response['Table1'][0]['OutPutJson'];
              //getPrinterTemplate(printerDetail);
            }
          }
        }
        callback(response);
      }
      else{
        billClick.value=false;
      }
    });
  }catch(e){
    billClick.value=false;
  }
}

void InsertSettlement({needNewOrder=false}) async{
  if(!isHasBillSettingsAccess(featuresAccessId['BillSettlement'])){
    return;
  }
  if(paymentTypeList.isEmpty){
    paymentTypeList.add(PaymentTypeMapping().createPaymentType( CASH_ID, CASH_NAME, c_orderDetail.value!.grandTotalAmount!.round()));
  }
  params=await getParameterEssential();
  params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.InvoiceBillSettlement));
  params.addAll(c_orderDetail.value!.insertSettlementParameters(paymentTypeList.value));

  ApiManager.GetInvoke(params,needInputJson: true).then((value){
    if(value[0]){print("needNewOrder $needNewOrder");
      var response=json.decode(value[1]);
      /*var response=json.decode(value[1]);
      c_orderDetail.value!.billId=response['Table'][0]['BillId'];
      print("c_orderDetail.value!.billId ${c_orderDetail.value!.billId}");*/
      if(isHasBillSettingsAccess(featuresAccessId['BillSettlementPrint'])){
        if (response['Table']!=null) {
          if(response['Table'].length > 0){
            var printerDetail = response['Table'][0]['OutPutJson'];
            //getPrinterTemplate(printerDetail);
          }
        }
      }
      DestroyOrder();
      /*Get.back();
      CustomAlert().commonErrorAlert("Bill Settled Successfully...", "");
      getTableStatus(null, null);*/
      if(isHasBillSettingsAccess(featuresAccessId['BillSettlementNotification']))
        addNotifications(NotificationType.success,msg: errorMessages['billSettled']);
      if (needNewOrder) {
        if (c_OrderTypeId.value == DINEIN_ID) {
          ToggleOrderType(c_OrderTypeId.value!, c_OrderTypeName.value!);
          getxOverlayClose();
          getTableStatus(null,null);

        }
        else if (c_OrderTypeId.value == TAKEAWAY_ID) {
          if(MyConstants.needUtilRefreshOnEachOrder){
            getBillingUtils();
          }
          TakeAwayAddNewHandler();
        }
        else if (c_OrderTypeId.value == HOMEDELIVERY_ID) {
          HomeDeliveryAddNewHandler();
        }
        else if (c_OrderTypeId.value == QUICLSERVICE_ID) {
          QuickServiceAddNewHandler();
        }
      }
      else{
        getxOverlayClose();
        if(isHasBillSettingsAccess(featuresAccessId['BillSettlementNotification']))
          addNotifications(NotificationType.success,msg: errorMessages['billSettled']);
        getTableStatus(null, null);
      }
    }
  });
}

bool IsBillRaised() {
  if (c_orderDetail.value!.billId!=null) {
    return true;
  }
  return false;
}


void PlaceOrder(VoidCallback onSuccess) async{
  c_orderDetail.value!.customerId=customerId;
  List<ParameterModel> params= await getParameterEssential(needUUID: true);
  params.add(ParameterModel(Key: "SpName", Type: "String", Value: "RB_Billing_TabServiceCustomerPostPaidDetail_Mobile"));
  params.add(ParameterModel(Key: "BalanceToPay", Type: "String", Value: HasOutletRoundOff()?c_orderDetail.value!.grandTotalAmount!.round():c_orderDetail.value!.grandTotalAmount));
  params.add(ParameterModel(Key: "IsIncludeWallet", Type: "String", Value: false));
  params.add(ParameterModel(Key: "WalletAmount", Type: "String", Value: 0));
  params.add(ParameterModel(Key: "CustomerCouponCode", Type: "String", Value: ""));
  params.add(ParameterModel(Key: "TabServiceTypeId", Type: "String", Value: 2));
  params.addAll(c_orderDetail.value!.insertKotParameters());
  ApiManager.GetInvoke(params,needInputJson: true).then((value){
    debugPrint("$value");
    if(value[0]){
      var response=json.decode(value[1]);
      c_orderDetail.value!.productList!.clear();
      c_orderDetail.refresh();
      setUUID(kotUUID);
      kotClick.value=false;
      TakeAwayAddNewHandler();
      onSuccess();

    }
    else{
      kotClick.value=false;
    }
  });
}