import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/BillingModel/productModel.dart';


import '../../models/BillingModel/addonsModel.dart';
import '../utils.dart';
import 'cartNotifier.dart';
import 'configuration.dart';

ProductModel? backUpProductDetail;
var backUpIndex;
var backUpQty;
TextEditingController productNotes=TextEditingController();
var node;
void openOTP(productId, index) {
  //backUpProductDetail = null;
  backUpIndex = null;
  backUpIndex = index;
 // backUpQty = c_orderDetail.value!.productList![index].quantity;
  //backUpProductDetail = json.decode(json.encode(c_orderDetail.value!.productList![index]));
/*  $("#OTP_ProductName").text(c_orderDetail.productList[index].productName);
  $("#OTP_ProdutSubTotal").empty();
  $("#OTP_ProdutSubTotal").append(getCurSym(getIndianFormat(c_orderDetail.productList[index].subTotal)));
  $("#OTP_Quantity").val(c_orderDetail.productList[index].quantity);
  ToggleOTP('o_OTP');*/
  PopulateAddons();
  PopulateKitchenComments();
  productNotes.clear();
  List<KOTCommentandAddOnMapping> filterNotes=c_orderDetail.value!.addOnCommentsList!.where((element) => element.commentId==null && element.kOTId==null && element.addonId==null && element.orderProductId==productId).toList();
  if(filterNotes.isNotEmpty){
    productNotes.text=filterNotes[0].comments??"";
  }
}

RxList<KOTCommentandAddOnMapping> addonsList=RxList<KOTCommentandAddOnMapping>();
RxList<KOTCommentandAddOnMapping> kitchenCommentsList=RxList<KOTCommentandAddOnMapping>();
void PopulateAddons() async{
  addonsList.clear();
  List<dynamic> AddonsList= await getOutletDetail("AddonsList");
  addonsList.value=AddonsList.map((e) => KOTCommentandAddOnMapping.fromGetBilling(e)).toList();
}

void PopulateKitchenComments() async{
  kitchenCommentsList.clear();
  List<dynamic> KitchenCommentsList= await getOutletDetail("KOTCommentsList");
  kitchenCommentsList.value=KitchenCommentsList.map((e) => KOTCommentandAddOnMapping.fromGetBillingComments(e)).toList();
  print("hi");
}
void activeAddonById(data, id, isActive, {hasPrice = false}) {
    int productId=c_orderDetail.value!.productList![backUpIndex].productId!;
    if (isActive) {
      var price = parseDouble(data.price);
      if (hasPrice) {
        c_orderDetail.value!.manipulateAddOnCommentsList(productId, 2, id, price, 1);
      }
      else
        c_orderDetail.value!.manipulateAddOnCommentsList(productId, 1, id, price, 1);
    }
    else {
      var price = parseDouble(data.price);
      if (hasPrice) {
        c_orderDetail.value!.manipulateAddOnCommentsList(productId, 2, id, price, 2);
      }
      else
        c_orderDetail.value!.manipulateAddOnCommentsList(productId, 1, id, price, 2);
    }
    c_orderDetail.refresh();
}

void cancelAddons(productId, isAddOn) {
  if (isAddOn == "1") {
    c_orderDetail.value!.manipulateAddOnCommentsList(productId, 2, null, 0, 3);
  }
  else if(isAddOn == "2"){
    c_orderDetail.value!.manipulateAddOnCommentsList(productId, 1, null, 0, 3);
  }
}


void cancelChangesInOTP(){
  if(backUpIndex!=null){
    c_orderDetail.value!.updateProductQty(c_orderDetail.value!.productList![backUpIndex].productId, c_orderDetail.value!.productList![backUpIndex].quantity);
    cancelAddons(c_orderDetail.value!.productList![backUpIndex].productId, "1");
    c_orderDetail.value!.manipulateAddOnCommentsList(c_orderDetail.value!.productList![backUpIndex].productId, 3, "", 0, 2);
    c_orderDetail.refresh();
  }
  backUpIndex = null;
  if(node!=null){
    node.unfocus();
  }
}

void acceptChangesInOTP(){
  if(productNotes.text.isNotEmpty){
    c_orderDetail.value!.manipulateAddOnCommentsList(c_orderDetail.value!.productList![backUpIndex].productId, 3, productNotes.text, 0, 1);
  }
  else{
    c_orderDetail.value!.manipulateAddOnCommentsList(c_orderDetail.value!.productList![backUpIndex].productId, 3, "", 0, 2);
  }
  backUpIndex = null;
  if(node!=null){
    node.unfocus();
  }
}