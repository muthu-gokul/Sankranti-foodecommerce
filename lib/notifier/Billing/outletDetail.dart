import 'dart:convert';
import 'dart:developer';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Popup/alertDialog.dart';
import '../../api/sp.dart';

import '../../api/ApiManager.dart';
import '../../models/getBillingOutletModels.dart';
import '../../models/parameterMode.dart';
import '../../utils/constants.dart';
import '../itemPageViewNotifier.dart';
import '../utils.dart';
import '../utils/apiUtils.dart';
import 'billingController.dart';
import 'cartNotifier.dart';
import 'configuration.dart';
import 'floorsOrderTypePopulate.dart';
import 'otherServices/quickServiceHandler.dart';
import 'otherServices/takeAwayNotifier.dart';
import 'servicePageNotifier.dart';
import 'settings/itemBlockNotifier.dart';

final BillingController billingController = Get.put(BillingController());
List OVERALL_SETTINGS=[];
void getBillingOutlet() async{
  params=await getParameterEssential();
  params.add(ParameterModel(Key: "SpName",Value: Sp.BilingOutletSp,Type: "string"));
  ApiManager.GetInvoke(params).then((value){
      if(!value[0]){
       return;
      }

      var response=json.decode(value[1]);
      //log("$response");
       setOutletDetail("UserDetail", response["Table"]);
       setOutletDetail("OutletAddress", response["Table1"]);
       billingController.fetchOutletDetails(response);
      setOutletDetail("CaptainList", response["Table2"]);
      setOutletDetail("WaiterList", response["Table3"]);
      setOutletDetail("FloorList", response["Table4"]);
      setOutletDetail("OrderTypeList", response["Table5"]);
      setOutletDetail("TableList", response["Table6"]);
      setOutletDetail("MenuList", response["Table7"]);
      setOutletDetail("CategoryList", response["Table8"]);
      setOutletDetail("ProductList", response["Table9"]);
      setOutletDetail("KOTCommentsList", response["Table10"]);
      setOutletDetail("AddonsList", response["Table11"]);
      setOutletDetail("PaymentTypeList", response["Table12"]);
      setOutletDetail("StartedDate", response["Table13"]);
      setOutletDetail("StationList", response["Table14"]);

      setOutletDetail("ErrorMessage", response["Table15"]);
      setOutletDetail("OrderStatusList", response["Table16"]);
      setOutletDetail("OtherChargesList", response["Table17"]);
      setOutletDetail("BillDate", response["Table18"]);
      setOutletDetail("ProductOtherChargesList", response["Table19"]);
      setOutletDetail("ProductTaxList", response["Table20"]);
      setOutletDetail("ParentOtherChargesList", response["Table21"]);

      setOutletDetail("ModifiersList", response['Table23']);
      setOutletDetail("ProductFloorPriceList", response['Table24']);
      setOutletDetail("ModifiersFloorPriceList", response['Table25']);
      PRODUCT_BLOCKDETAIL.value=response['Table28']??[];
      setOutletDetail("TakeAwayList", []);
      setOutletDetail("HomeDeliveryList", []);
      setOutletDetail("QuickServiceList", []);
      OVERALL_SETTINGS=response['Table29']??[];
      print("c_OrderTypeId ${c_OrderTypeId.value}");
      OutletInit();
  });
}


RxnInt c_FloorId=RxnInt();
Rxn c_FloorName=Rxn();
RxnInt c_OrderTypeId = RxnInt(2);//ParentOrderTypeId
Rxn c_OrderTypeName=Rxn();
RxnInt c_MenuId = RxnInt();
RxnInt c_CategoryId = RxnInt();
RxnInt c_SubCategoryId = RxnInt();
RxnInt c_InnerSubCategoryId = RxnInt();
bool isDefaultMenu=false;
void OutletInit(){
  if(filtermenu.isNotEmpty){

    int index=filtermenu.indexWhere((element) => element.isDefault);
    if(index!=-1){
      updateMenu(index);

    }
  }
  //populateFloor();
  //getTableStatus(null, null);
}

void updateMenu(int index){
  if(c_MenuId.value!=filtermenu[index].MenuId){
    c_MenuId.value=filtermenu[index].MenuId;
    isDefaultMenu=filtermenu[index].isDefault;
    print("isCustom ${filtermenu[index].isCustomMenu}");
    populateMainCategory();
  }
}

void populateMainCategory() async{
  print("c_MenuId.value ${c_MenuId.value} ${billingController.productDetail.subCategory!.length} $isDefaultMenu");
  filtermainCategory.clear();
  List<dynamic> categoryList= await getOutletDetail("CategoryList");
  categoryList.forEach((element) {
    if(element['ParentProductCategoryId']==null && c_MenuId.value==element['MenuId']){
      filtermainCategory.add(new MainCategoryTable4(
        MainCategoryName: element['ProductCategoryName'],
        MainCategory: element['ProductCategoryId'],
        MenuId: element['MenuId'],
        totalProducts: element['TotalProducts']
      ));
    }
  });


  if(isDefaultMenu){
    int totalProducts=0;
    filtermainCategory.forEach((element) {
      totalProducts=totalProducts+element.totalProducts;
    });
    filtermainCategory.insert(0, new MainCategoryTable4(
        MainCategoryName: "All",
        MainCategory: 0,
        MenuId: c_MenuId.value,
        imgPath: "CategoryItems/DefaultCategory.png",
      totalProducts: totalProducts
    ));
  }
  filtermainCategory.refresh();
  if(filtermainCategory.isEmpty){
    c_CategoryId.value=null;
    c_SubCategoryId.value=null;
    populateProducts(null, c_OrderTypeId.value);
    filterInnersubCategory.clear();
    filtersubCategory.clear();
    return;
  }
    updateMainCategory(0);

  print("filtermainCategory ${filtermainCategory.length} _  ${categoryList.length}");
}
void updateMainCategory(index){
  if(filtermainCategory.isEmpty){
    c_CategoryId.value=null;
    populateProducts(null,c_OrderTypeId.value);
    return;
  }
  if(c_CategoryId.value!=filtermainCategory[index].MainCategory){
    c_CategoryId.value=filtermainCategory[index].MainCategory;
  }
  //Populate SubCategory
  //populateSubCategory();
  populateProducts(null,c_OrderTypeId.value);
}
String getCategoryName(){
  if(c_CategoryId.value==null){
    return "";
  }
  if(c_CategoryId.value==0){
    return "All";
  }
  else{
    return StringUtils.capitalize(filtermainCategory.where((p0) => p0.MainCategory==c_CategoryId.value).toList()[0].MainCategoryName??"");
  }
}

void populateSubCategory() async{
  filterInnersubCategory.clear();
  filtersubCategory.clear();
  List<dynamic> categoryList= await getOutletDetail("CategoryList");
  List<SubCategory> subCategoryList=categoryList.map((e) => SubCategory.fromJson(e)).toList();
  filterproduct.clear();
  if(c_CategoryId.value==0){
    filtersubCategory.value=subCategoryList.where((element) => element.MenuId == c_MenuId.value && element.CategoryOrder==1).toList();
  }
  else{
    filtersubCategory.value=subCategoryList.where((element) => element.ParentProductCategoryId==c_CategoryId.value && element.MenuId==c_MenuId.value && element.CategoryOrder==1).toList();
  }
  print("populateSubCategory ${c_CategoryId.value} ${filtersubCategory.length}");
  if(filtersubCategory.length==0){

  }
  else{

  }
}
void onSubCategoryClick(int index) async{
  filterInnersubCategory.clear();
  List<dynamic> categoryList= await getOutletDetail("CategoryList");
  List<SubCategory> subCategoryList=categoryList.map((e) => SubCategory.fromJson(e)).toList();
  for(int i=0;i<subCategoryList.length;i++){
    if(filtersubCategory[index].ProductCategoryId==subCategoryList[i].ParentProductCategoryId){
      filterInnersubCategory.add(subCategoryList[i]);
    }
  }
  if(filterInnersubCategory.length==0){
    updateSubCategory(index,0);
    //updateSUBCS(selectedSub,0);
  }
  else{
    print("has inner sub");
    filterproduct.clear();
    onInnerSubClick(0);
  }
}
void updateSubCategory(int index,int isInnerSub){

  if(isInnerSub==0){
    c_SubCategoryId.value=filtersubCategory[index].ProductCategoryId;
    populateProducts(c_SubCategoryId.value,c_OrderTypeId.value);
    //filterproduct=productDetail.productList!.where((element) => element.ProductCategoryId==filtersubCategory![subCategorySelected].ProductCategoryId).toList();
  }else{
    c_SubCategoryId.value=filterInnersubCategory[index].ProductCategoryId;
    populateProducts(c_SubCategoryId.value,c_OrderTypeId.value);
    //filterproduct=productDetail.productList!.where((element) => element.ProductCategoryId==filterInnersubCategory[subCategorySelected].ProductCategoryId).toList();
  }
}
Future<void> onInnerSubClick(int selectedSubIndex) async {

  List<dynamic> categoryList= await getOutletDetail("CategoryList");
  List<SubCategory> subCategoryList=categoryList.map((e) => SubCategory.fromJson(e)).toList();

  for(int i=0;i<subCategoryList.length;i++){
    if(filterInnersubCategory[selectedSubIndex].ProductCategoryId==subCategoryList[i].ParentProductCategoryId){
      tempInnersubCategory.add(subCategoryList[i]);
    }
  }
  if(tempInnersubCategory.length==0){
    updateSubCategory(selectedSubIndex,1);
    //updateSUBCS(selectedSubIndex, 1);
  }else{
    filterInnersubCategory.clear();
    filterInnersubCategory.addAll(tempInnersubCategory);
    tempInnersubCategory.clear();
  }
}
void clearInnerSub(){
  filterInnersubCategory.clear();
  populateSubCategory();
}

void populateProducts(categoryId, orderTypeId) async{
  try{
    print("populateProducts ${showLoader.value} ${categoryId} ${c_CategoryId.value}");
    filterAlphabets.clear();
    List<dynamic> productList = await getOutletDetail("ProductList");
    List<dynamic> productOtherChargesMappingList = await getOutletDetail("ProductOtherChargesList");
    List<dynamic> productTaxMappingList = await getOutletDetail("ProductTaxList");
    if(categoryId==null && c_CategoryId.value==null){
      filterproduct.value=productList.where((element) => element['MenuId'] == c_MenuId.value).toList();
    }
    else if (categoryId==null){
      if(c_CategoryId.value==0)
        filterproduct.value=productList.where((element) => element['MenuId'] == c_MenuId.value).toList();
      else
        filterproduct.value=productList.where((element) =>element['MenuId'] == c_MenuId.value && element['ParentProductCategoryId'] == c_CategoryId.value).toList();
    }

    //var filterProductList = $.grep(productList, function (e, i) { return e.ParentProductCategoryId == c_CategoryId; });
    else
      filterproduct.value=productList.where((element) => element['MenuId'] == c_MenuId.value && element['ProductCategoryId'] == categoryId).toList();
    //var filterProductList = $.grep(productList, function (e, i) { return e.ProductCategoryId == categoryId; });

    var productFloorWisePriceList=[];
    if(c_OrderTypeId.value==DINEIN_ID){
      productFloorWisePriceList = await getOutletDetail('ProductFloorPriceList');
      productFloorWisePriceList=productFloorWisePriceList.where((y) => y['MenuId']==c_MenuId.value).toList();
    }

    filterproduct.forEach((element) {
      List<dynamic> productOCList=productOtherChargesMappingList.where((f) => f['ProductId']==element['ProductId'] && f['OrderTypeId']==orderTypeId).toList();
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
      if(!filterAlphabets.contains(element['ProductName']![0].toUpperCase())){
        filterAlphabets.add(element['ProductName']![0].toUpperCase());
      }
      filterAlphabets.sort();
      filterAlphabetSelected.value=-1;
    });
    //print("filterproduct ${filterproduct}");
    itemSplashCountArray=List.filled(filterproduct.length, 0);
    itemIndicator();
  }catch(e){
    showLoader.value=false;
    CustomAlert().commonErrorAlert("populateProducts",e.toString());
  }

}


Future<void> populateModifiers(parentProductId) async {
  filterModifiers.clear();
  List<dynamic> modifiersList = await getOutletDetail("ModifiersList");
  filterModifiers.value=modifiersList.where((element) => element['ParentProductId'] == parentProductId).toList();

  List<dynamic> productOtherChargesMappingList = await getOutletDetail("ProductOtherChargesList");
  List<dynamic> productTaxMappingList = await getOutletDetail("ProductTaxList");

  var productFloorWisePriceList=[];
  if(c_OrderTypeId.value==DINEIN_ID){
    productFloorWisePriceList = await getOutletDetail('ModifiersFloorPriceList');
    productFloorWisePriceList=productFloorWisePriceList.where((y) => y['MenuId']==c_MenuId.value).toList();
  }

  filterModifiers.forEach((element) {
    List<dynamic> productOCList=productOtherChargesMappingList.where((f) => f['ProductId']==parentProductId && f['OrderTypeId']==c_OrderTypeId.value).toList();
    List<dynamic> productTaxList=productTaxMappingList.where((e) => e['ProductId']==parentProductId).toList();
    element['ProductOtherChargesList']=productOCList;
    element['ProductTaxList']=productTaxList;
    var productPrice = 0.0;
    if (c_OrderTypeId.value == DINEIN_ID) {
      var currentPP = productFloorWisePriceList.where((z) => z['ProductId']==element['ProductId']).toList();;
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
  itemSplashCountArray=List.filled(filterModifiers.length, 0);

}

List<int> itemSplashCountArray=[];
RxInt itemSplashSelected=RxInt(-1);
RxInt itemSplashModifierSelected=RxInt(-1);


void clearClickEvents(){
  kotClick.value=false;
  isQSKotBusy.value=false;
}

void itemIndicator(){
  if(filterproduct.length>0){
    try{
      itemPageViewController.jumpTo(0);
    }catch(e){}
  }
}