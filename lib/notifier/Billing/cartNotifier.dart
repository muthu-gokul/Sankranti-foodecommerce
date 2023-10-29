import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import '../../models/BillingModel/productModel.dart';
import '../../Popup/alertDialog.dart';
import '../../api/ApiManager.dart';
import '../../api/sp.dart';
import '../../models/BillingModel/cartModel.dart';
import '../../models/parameterMode.dart';
import '../../widgets/calculation.dart';
import '../utils.dart';
import '../utils/apiUtils.dart';
import 'billingController.dart';
import 'configuration.dart';
import 'orderSettlementNotifier.dart';
import 'outletDetail.dart';
import 'servicePageNotifier.dart';
import 'settings/itemBlockNotifier.dart';

Rxn<OrderModel> c_orderDetail=new Rxn<OrderModel>();
RxInt slideItemIndex=RxInt(-1);

void DestroyOrder() {
  c_orderDetail.value = null;
  slideItemIndex.value=-1;
  c_orderDetail.refresh();
  paymentTypeList.clear();
  /*Kotorderclose();
  KotWiseOrderUihandler();
  billSplitBackUpOrderDetail = null;*/
}

bool HasCurrentOrder() {
  if (c_orderDetail.value!=null)
    return true;
  return false;
}

bool HasCurrentItems() {
  if (c_orderDetail.value!=null && c_orderDetail.value!.productList!.length>0)
    return true;
  return false;
}
bool HasTotalProducts() {
  if (c_orderDetail.value!=null && c_orderDetail.value!.totalOrderKotWiseList!.length>0)
    return true;
  return false;
}
bool IsBillCompliment(){
  return c_orderDetail.value!.isBillCompliment!;
}
bool IsProductBlock(pId,orderType){
  var blockDet = PRODUCT_BLOCKDETAIL.where((f) => f['ProductId'] == pId).toList();
  if(blockDet.isNotEmpty){
    var isBlocked = blockDet[0][orderType.toString()];
    if (isBlocked == 1) {
      return true;
    }
  }
  return false;
}

Future<void> onProductClick(e) async {
  
  if(IsProductBlock(e['ProductId'], c_OrderTypeId.value)){
    return;
  }

  showKotWiseOrder.value=false;
  showBillPreview.value=false;
  slideItemIndex.value=-1;
  if (!HasCurrentOrder()) {
    selectTableAlert();
    return;
  }
  if (IsBillRaised()) {
    billRaisedAlert();
    return;
  }


  if(e['IsSeveralProduct']??false){
    await populateModifiers(e['ProductId']);
    //subProducts();
    return;
  }
  if (e['IsProductWeightEnable'].toString() == "true") {
    if(e['ParentProductId']!=null){
      //Get.back();
    }
    onWQClick(e);
    return;
  }
  else {
    c_orderDetail.value!.addProduct(e, 1);
    c_orderDetail.refresh();
  }
}

void onProductDelete(productId){
  c_orderDetail.value!.deleteProduct(productId);
  c_orderDetail.refresh();
}

void selectTableAlert() {
  CustomAlert().selectTableAlert(Get.context!, 'assets/errors/select-table.png', "Select Table To Take Orders.");
}

void billRaisedAlert(){
  CustomAlert().commonErrorAlert("Bill Raised", "Your Bill has been raised.You cant take Orders anymore...");
}

void updateSlideItemIndex(int index){
  slideItemIndex.value=index;
}

void onClearAll(){
  if (!HasCurrentOrder()) {
    selectTableAlert();
    return;
  }
  if (!HasCurrentItems()) {
    CustomAlert().commonErrorAlert("No Products To Clear...", "");
    return;
  }
  CustomAlert(
    callback: (){
      List<ProductModel> holdProducts=c_orderDetail.value!.productList!.where((element) => element.isHoldProduct).toList();
      c_orderDetail.value!.productList = [];
      c_orderDetail.value!.orderCalculation();
      c_orderDetail.value!.otherChargesList=c_orderDetail.value!.otherChargesList!.where((element) => element.OrderAmountClassificationId!=null).toList();
      c_orderDetail.refresh();
      if(holdProducts.isNotEmpty){
        onHoldOrderProductDelete(holdProducts);
      }
    },
    cancelCallback: (){

    }
  ).yesOrNoDialog2( "assets/bottomBar/clear-order.svg", "Are you sure want to clear current Items ?", true,imgHeight: 150,textWidth: 250,hei: 400);
}

void onHoldOrder(){
  if (!HasCurrentOrder()) {
    selectTableAlert();
    return;
  }
  if (!HasCurrentItems()) {
    CustomAlert().commonErrorAlert("No Products To Hold...", "");
    return;
  }
  CustomAlert(
      callback: () async {
        c_orderDetail.value!.isHold = true;
        List<ParameterModel> params= await getParameterEssential(needUUID: true);
        params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.InsertOrderDetail));
        params.addAll(c_orderDetail.value!.insertKotParameters());
        params.add(ParameterModel(Key: "InputJson", Type: "String", Value: json.encode(params)));
        ApiManager.GetInvoke(params).then((value){
          if(value[0]){
            setUUID(kotUUID);
            DestroyOrder();
            Get.back();
            //Get.to(ServicePage());
            getTableStatus(null,null);
          }
        });
      },
      cancelCallback: (){

      }
  ).yesOrNoDialog2( "assets/bottomBar/hold-icon.svg", "Are you sure want to hold current Items ?", true,imgHeight: 150,textWidth: 250,hei: 400);
}

void onHoldOrderProductDelete(List<ProductModel> productList) async{
  List<ParameterModel> params= await getParameterEssential();
  params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.deleteHoldProduct));
  params.addAll(c_orderDetail.value!.holdProductDeleteParams(productList));
  params.add(ParameterModel(Key: "Reason", Type: "String", Value: ""));
  ApiManager.GetInvoke(params).then((value){
    if(value[0]){
      console(value);
    }
  });
}


var bk_weightProduct;
String WQ_Item="",WQ_Unit="";
var WQ_Qty="".obs;
var WQ_Subtotal="".obs;
double WQ_Price=0.0;
void onWQClick(e) {
  bk_weightProduct = e;
  WQ_Item=e['ProductName'];
  WQ_Unit=e['UnitShortCode'];
  WQ_Price=e['Price'];
  isProductWeightOpen.value=true;
  blurAboveBillScreen.value=true;
}

void clearWQ_Qty(){
  if(WQ_Qty.isNotEmpty){
    WQ_Qty.value = WQ_Qty.value.substring(0, WQ_Qty.value.length - 1);
    WQ_Change(WQ_Qty.value);
  }
}
void clearAllWQ_Qty(){
  WQ_Qty.value ="";
}
void updateWQ_Qty(String keypad){
  var disVal = "";
  if (keypad == 'X') {
    disVal = WQ_Qty.value;
    if(WQ_Qty.isNotEmpty){
      WQ_Qty.value = WQ_Qty.value.substring(0, WQ_Qty.value.length - 1);
    }
  }
  else if (keypad == 'C') {
    WQ_Qty.value="";
  }
  else if (keypad == '.') {
    disVal = WQ_Qty.value;
    if (!disVal.contains('.')) {
      if (disVal.length < 6) {
        disVal += keypad;
        WQ_Qty.value=(disVal);
      }
    }
  }
  else {
    disVal = WQ_Qty.value;
    if (disVal.length < 6) {
      disVal += keypad;
      WQ_Qty.value=(disVal);
    }
    else if (disVal.contains('.')) {
      var x = disVal.split('.');
      if (x[1].length < 3) {
        disVal += keypad;
        WQ_Qty.value=(disVal);
      }
    }
  }
  WQ_Change(WQ_Qty.value);
}

void WQ_Change(e) {
  var qty = parseDouble(e);
  var price = WQ_Price;
  var z=Calculation().mul(qty, price);
  WQ_Subtotal.value = parseDouble(z.toStringAsFixed(maxPrecision)).toString();
}

void onWQDone() {
  var qty = parseDouble(WQ_Qty.value);
  if (qty <= 0) {
    CustomAlert().commonErrorAlert("Enter Quantity to Add Product...", "");
    //addNotifications(2,msg: "Enter Quantity to Add Product...",img: MyConstants.notificationErrorIcon);
    return;
  }
  c_orderDetail.value!.addProduct(bk_weightProduct, qty);
  c_orderDetail.refresh();
  onWQClose();
}

void onWQClose() {
  isProductWeightOpen.value=false;
  blurAboveBillScreen.value=false;
  WQ_Item="";
  WQ_Unit="";
  WQ_Price=0.0;
  WQ_Qty.value="";
  WQ_Subtotal.value="";
  bk_weightProduct = null;
}

getCurrentProductQty(productId){
  if(!HasCurrentItems()){
    return 0;
  }
  int index=c_orderDetail.value!.productList!.indexWhere((element) => element.productId==productId);
  if(index==-1){
    return 0;
  }
  else{
    return c_orderDetail.value!.productList![index].quantity!.toInt();
  }
}
bool checkCurrentProduct(productId){
  if(!HasCurrentItems()){
    return false;
  }
  int index=c_orderDetail.value!.productList!.indexWhere((element) => element.productId==productId);
  if(index==-1){
    return false;
  }
  else{
    return true;
  }
}
RxBool addBtnRefresh=RxBool(false);
void addBtnHandler(productId,{bool isAdd=true}){
  int index=c_orderDetail.value!.productList!.indexWhere((element) => element.productId==productId);
  if(isAdd){
    c_orderDetail.value!.updateProductQty(c_orderDetail.value!.productList![index].productId, c_orderDetail.value!.productList![index].quantity!+1);
    c_orderDetail.refresh();
  }
  else{
    if(c_orderDetail.value!.productList![index].quantity!>1){
      c_orderDetail.value!.updateProductQty(c_orderDetail.value!.productList![index].productId, c_orderDetail.value!.productList![index].quantity!-1);
      c_orderDetail.refresh();
    }
    else{
      onProductDelete(productId);
    }
  }

}