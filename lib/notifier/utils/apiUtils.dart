

import 'dart:convert';

import 'package:flutter/material.dart';

import '../../api/ApiManager.dart';
import '../../api/sp.dart';
import '../../models/parameterMode.dart';
import '../../utils/constants.dart';
import '../Billing/configuration.dart';

int loginUserId=0;
int customerId=0;
String databaseName="";
int outletId=0;
List<ParameterModel> params=[];

//String devURL="https://scutisoft.in/QMS_UAT_Test";
//String devURL="http://45.126.252.78/QMS_UAT_Test";
String devURL="http://192.168.1.102/QMS_UAT_Test";
String GetBaseUrl(){
 // return "http://45.126.252.78/QMS_UAT_Test";
  //return "http://45.126.252.78/RestaBilling_Dev";
  //return MyConstants.isLive? "http://45.126.252.78/Restabilling_uat":devURL;
  //return MyConstants.isLive? "http://192.168.1.140:5000":devURL;
  return MyConstants.isLive? "https://restapos.in/billing":devURL;
  return MyConstants.isLive? "http://45.126.252.78/RestaBilling":devURL;
}

getParameterEssential({bool needUUID=false,String uuidKey="KOTKey",String uuidSPKey=kotUUID}) async{
  return [
    ParameterModel(Key: "LoginUserId", Type: "int", Value: await getLoginId()),
    ParameterModel(Key: "IsMobile", Type: "int", Value: 1),
    ParameterModel(Key: "database", Type: "String", Value: await getDatabase()),
    ParameterModel(Key: "OutletId", Type: "String", Value: await getOutletId()),
    ParameterModel(Key: "DeviceId", Type: "String", Value: getDeviceId()),
    ParameterModel(Key: "CustomerId", Type: "String", Value: customerId),
    if(needUUID)
      ParameterModel(Key: uuidKey, Type: "String", Value: await getUUID(uuidSPKey)),
  ];
}

getLoginId() async{
  //SharedPreferences sp=await SharedPreferences.getInstance();
  // return sp.getInt("LoginUserId");
  return 0;
}

getDatabase() async{
//  SharedPreferences sp=await SharedPreferences.getInstance();
//  return sp.getString("DatabaseName");
  return "RestaPos_Dev_53";
  return databaseName;
}

getOutletId() async{
//  SharedPreferences sp=await SharedPreferences.getInstance();
//  return sp.getString("DatabaseName");
  return outletId;
}

Future<List> getMasterDrp(String page,String typeName, dynamic refId,  dynamic hiraricalId) async {

  List<ParameterModel> parameters= await getParameterEssential();
  parameters.add(ParameterModel(Key: "SpName", Type: "String", Value: "${Sp.MasterdropDown}"));
  parameters.add(ParameterModel(Key: "TypeName", Type: "String", Value: typeName));
  parameters.add(ParameterModel(Key: "Page", Type: "String", Value: page));
  parameters.add(ParameterModel(Key: "RefId", Type: "String", Value: refId));
  parameters.add(ParameterModel(Key: "RefTypeName", Type: "String", Value: typeName));
  parameters.add(ParameterModel(Key: "HiraricalId", Type: "String", Value: hiraricalId));
  var result=[];
  try{
    await ApiManager.GetInvoke(parameters).then((value) {

      if(value[0]){
        var parsed=jsonDecode(value[1]);
        var table=parsed['Table'] as List;
        if(table.isNotEmpty){
          result=table;
        }
      }
    });
    return result;
  }
  catch(e){
    return result;
    //CustomAlert().commonErrorAlert(Get.context!, "Error G01", "Contact Administration");
  }
}
Future<Map> getMasterDrpMap(String page,String typeName, dynamic refId,  dynamic hiraricalId) async {

  List<ParameterModel> parameters= await getParameterEssential();
  parameters.add(ParameterModel(Key: "SpName", Type: "String", Value: "${Sp.MasterdropDown}"));
  parameters.add(ParameterModel(Key: "TypeName", Type: "String", Value: typeName));
  parameters.add(ParameterModel(Key: "Page", Type: "String", Value: page));
  parameters.add(ParameterModel(Key: "RefId", Type: "String", Value: refId));
  parameters.add(ParameterModel(Key: "RefTypeName", Type: "String", Value: typeName));
  parameters.add(ParameterModel(Key: "HiraricalId", Type: "String", Value: hiraricalId));
  var result={};
  try{
    await ApiManager.GetInvoke(parameters).then((value) {
      if(value[0]){
        var parsed=jsonDecode(value[1]);
        result=parsed;
      }
    });
    return result;
  }
  catch(e){
    return result;
    //CustomAlert().commonErrorAlert(Get.context!, "Error G01", "Contact Administration");
  }
}