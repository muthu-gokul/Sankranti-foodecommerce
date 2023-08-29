import 'dart:convert';

import 'package:get/get.dart';

import '../../../utils/constants.dart';
import '../billingController.dart';
import '../outletDetail.dart';

RxList<dynamic> PRODUCT_BLOCKDETAIL=RxList<dynamic>();
void updateProductsOnItemBlock(String productListJson, String modifiedListJson) async{
  PRODUCT_BLOCKDETAIL.value=json.decode(productListJson);
  List<dynamic> modifiedProductList=json.decode(modifiedListJson);
  modifiedProductList.forEach((element) {
    int index=filterproduct.indexWhere((f) => f['ProductId']==element['ProductId']);
    if(index!=-1){
      filterproduct[index][MyConstants.itemBlockPrefix+c_OrderTypeId.value.toString()]=element[c_OrderTypeId.value.toString()];
    }
  });
  filterproduct.refresh();
}