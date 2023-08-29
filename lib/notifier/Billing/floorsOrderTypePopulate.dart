import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/getBillingOutletModels.dart';
import 'billingController.dart';
import 'configuration.dart';
import 'outletDetail.dart';


var selectedFloorMap={}.obs;
void populateFloor() async{
  List<dynamic> floorList = await getOutletDetail("FloorList");
  //print("floorList $floorList");
  filteroutletFloor.value=floorList.map((e) => OutletFloor.fromJson(e)).toList();
  outletFloorList.value=floorList;
  selectedFloorMap.value={"FloorId":filteroutletFloor[0].FloorId,"FloorName":filteroutletFloor[0].FloorName};
/*  floorDrp.clearValues();
  floorDrp.setDataArray(outletFloorList.value);
  floorDrp.setValues({"FloorId":filteroutletFloor[0].FloorId,"FloorName":filteroutletFloor[0].FloorName});*/
  setFloor(filteroutletFloor[0].FloorId,filteroutletFloor[0].FloorName);
}
void setFloor(id,name){
  c_FloorId.value=id;
  c_FloorName.value=name;
  getOrderTypeByFloor(id);


  if (c_OrderTypeId.value == DINEIN_ID) {
    populateTables(id);
  }
  else{
    populateTakeAway(id);
  }
}


void getOrderTypeByFloor(floorId) async{
  c_OrderTypeId.value = 1;
  c_OrderTypeName.value ="Select OrderType";
  List<dynamic> tempOrderTypeList = await getOutletDetail("OrderTypeList");
  //List<dynamic> floorOrderType = $.grep(orderTypeList, function (e, i) { return e.FloorId == floorId && e.ParentOrderType!=null; });
  orderTypeList.value = tempOrderTypeList.where((element) => element['FloorId']==floorId && (element['ParentOrderType']==1||element['ParentOrderType']==2 || element['ParentOrderType']==4)).toList()
      .map((e) => OrderType.fromJson(e)).toList();
  //PopulateOrderType(floorOrderType)
  //print("${json.encode(orderTypeList)}");
  setOrderType(orderTypeList[0].ParentOrderType,orderTypeList[0].OrderTypeName);
}

setOrderType(id,text){
  c_OrderTypeId.value = id;
  c_OrderTypeName.value =text;
}

RxList<TablesFloor> tablesList=<TablesFloor>[].obs;
void populateTables(floorId) async{
  List<dynamic> tables = await getOutletDetail("TableList");
  List<dynamic> filtertables=tables.where((element) => element['FloorId']==floorId).toList();
  tablesList.value=filtertables.map((e) => TablesFloor.fromJson(e)).toList();
}

RxList<TablesFloor> takeAwayList=<TablesFloor>[].obs;
void populateTakeAway(floorId) async{
  List<dynamic> tables = await getOutletDetail("TakeAwayList");
  List<dynamic> filtertables=tables.where((element) => element['FloorId']==floorId).toList();
  takeAwayList.value=filtertables.map((e) => TablesFloor.fromJson(e)).toList();
}


RxList<TablesFloor> homeDeliveryList=<TablesFloor>[].obs;
void populateHomeDelivery(floorId) async{
  List<dynamic> tables = await getOutletDetail("HomeDeliveryList");
  List<dynamic> filtertables=tables.where((element) => element['FloorId']==floorId).toList();
  homeDeliveryList.value=filtertables.map((e) => TablesFloor.fromJson(e)).toList();
}

RxList<TablesFloor> quickServiceList=<TablesFloor>[].obs;
void populateQuickService(floorId) async{
  List<dynamic> tables = await getOutletDetail("QuickServiceList");
  List<dynamic> filtertables=tables.where((element) => element['FloorId']==floorId).toList();
  quickServiceList.value=filtertables.map((e) => TablesFloor.fromJson(e)).toList();
}