import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/parameterMode.dart';
import '../notifier/utils/apiUtils.dart';
import '../utils/constants.dart';

RxBool showLoader=RxBool(false);


//BuildContext context
class ApiManager{
  ApiManager._();
  static int timeOut=120;
  static Future<List> GetInvoke(List<ParameterModel> parameterList,{needElegantNoti=false,hideLoaders=false,needInputJson=false}) async {
    String invokeUrl="";
    parameterList.add(ParameterModel(Key: "Version", Type: "String", Value: MyConstants.appVersion));
    if(needInputJson) {
      parameterList.add(ParameterModel(Key: "InputJson", Type: "String", Value: json.encode(parameterList)));
    }
    if(hideLoaders){
      showLoader.value=false;
    }
    else{
      showLoader.value=true;
    }
    try{
      //log(json.encode(parameterList));
      invokeUrl=GetBaseUrl()+"/api/Mobile/GetInvoke";
      var body={
        "Fields": parameterList.map((e) => e.toJson()).toList()
      };
      log(json.encode(parameterList));
      final response = await http.post(Uri.parse(invokeUrl),
          headers: {"Content-Type": "application/json"},
          body: json.encode(body)
      ).timeout(Duration(seconds: timeOut),onTimeout: ()=>onTme());
      showLoader.value=false;
      if(response.statusCode==200){
        return [true,response.body];
      }
      else if(response.statusCode==500){
        var msg;
        msg=json.decode(response.body);
        if(needElegantNoti){
          //addNotifications(NotificationType.error,msg: msg['Message']);

          /*ElegantNotification.error(
            title:  Text("Error",style: ts18(AppTheme.bgColor),),
            description:  Text(msg['Message'],style: ts15(AppTheme.darkGrey1),),
          ).show(Get.context!);*/
        }
        else{
          //CustomAlert().commonErrorAlert( "Error",msg['Message']);
        }
        return [false,msg['Message']];
      }
      else{
        if(needElegantNoti){
          //addNotifications(NotificationType.error,msg: response.body);
          /*ElegantNotification.error(
              title:  Text("Error",style: ts18(AppTheme.bgColor),),
              description:  Text(response.body,style: ts15(AppTheme.darkGrey1),)
          ).show(Get.context!);*/
        }
        else{
          //CustomAlert().commonErrorAlert( "Error",response.body);
        }
        return [false,response.body];
      }
    }
    catch(e,t){
      print("ee $e $t");
      showLoader.value=false;
      //isServerReConnect.value=true;
      //CustomAlert().commonErrorAlert("Server Error", "$e");
      return [false,"Catch Api"];
    }
  }


  static onTme(){
    return [false,"Connection TimeOut"];
  }
}


