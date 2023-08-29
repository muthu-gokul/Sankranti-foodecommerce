import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/ApiManager.dart';
import '../../api/sp.dart';
import '../../models/BillingModel/cartModel.dart';
import '../../models/parameterMode.dart';

import '../utils.dart';
import '../utils/apiUtils.dart';
import 'cartNotifier.dart';
import 'configuration.dart';
import 'floorsOrderTypePopulate.dart';
import 'outletDetail.dart';


var ServiceScreenload=false.obs;
var isLongPress=false.obs;
changeLongPress(){
  isLongPress.value=!isLongPress.value;
}

PageController floorPageController=new PageController();
var floorCarouselIndex=0.obs;
void floorPageViewController(int index){
  floorCarouselIndex.value=index;
  floorPageController.animateToPage(index,duration: Duration(milliseconds: 300),curve: Curves.ease);
}

void getTableStatus(tableNumberId, dynamicTable,{callback, orderId,needFullResponse=false, setOrderType=false,isMergeTable=false }) async{
  if(showBillPreview.value)
    showBillPreview.value=false;
  params=await getParameterEssential();
  params.add(ParameterModel(Key: "SpName",Value: Sp.GetTableStatusSp,Type: "string"));
  params.add(ParameterModel(Key: "TableNumberId",Value: tableNumberId,Type: "string"));
  params.add(ParameterModel(Key: "DynamicTable",Value: dynamicTable,Type: "string"));
  params.add(ParameterModel(Key: "OrderId",Value: orderId,Type: "string"));
  params.add(ParameterModel(Key: "IsTableMerge",Value: isMergeTable,Type: "string"));
  ApiManager.GetInvoke(params).then((value) {
    if(value[0]){
      var response=json.decode(value[1]);
      if(needFullResponse){
        if(setOrderType){
          setOutletDetail("TableList", response['Table']);
          populateTables(c_FloorId.value);
          setOutletDetail("TakeAwayList", response['Table1']);
          populateTakeAway(c_FloorId.value);
          setOutletDetail("HomeDeliveryList", response['Table2']);
          populateHomeDelivery(c_FloorId.value);
          setOutletDetail("QuickServiceList", response['Table3']);
          populateQuickService(c_FloorId.value);
        }
        callback(response);
      }
      else if (response !=null && response['Table']!=null && response['Table'].length > 0) {
        //log("getTableStatus $response");
        setOutletDetail("TableList", response['Table']);
        populateTables(c_FloorId.value);
        setOutletDetail("TakeAwayList", response['Table1']);
        populateTakeAway(c_FloorId.value);
        setOutletDetail("HomeDeliveryList", response['Table2']);
        populateHomeDelivery(c_FloorId.value);
        setOutletDetail("QuickServiceList", response['Table3']);
        populateQuickService(c_FloorId.value);
        if (response['Table5']!=null && response['Table5'].length > 0) {
          callback(response);
        }
        /*
        //TakeAway
        setOutletDetail("TakeAwayList", response.Table1);
        PopulateTakeAway(c_FloorId);
        //HomeDelivery
        setOutletDetail("HomeDeliveryList", response.Table2);
        PopulateHomeDelivery(c_FloorId);

        if (response.Table5 && response.Table5.length > 0) {
          callback(response);
        }*/
      }
    }
  });
}

void getTableStatusResponse(response){
  c_orderDetail.value=new OrderModel();
  c_orderDetail.value!.OrderDetailFromJson(response['Table5'][0], response['Table8'], response['Table9']);
  c_orderDetail.value!.createTotalOrderKotWise(response['Table6'], response['Table7']);
  c_orderDetail.value!.updateConsolidateOtherCharges(response['Table12'],response['Table14']);
  c_orderDetail.value!.updateAddons(response['Table10']);
  if (response["Table13"].length > 0) {
    c_orderDetail.value!.createProductFromHold(response['Table13']);
    //c_orderDetail.CreateProductFromHold(response.Table13);
  }
  //Get.back();
  //Get.to(BillingPage());
}
