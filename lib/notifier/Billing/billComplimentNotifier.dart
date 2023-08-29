import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../Popup/alertDialog.dart';
import '../../api/ApiManager.dart';

import '../../api/sp.dart';
import '../../models/parameterMode.dart';
import '../utils.dart';
import '../utils/apiUtils.dart';
import 'alertNotificationNotifier.dart';
import 'cartNotifier.dart';
import 'configuration.dart';
import 'discountNotifier.dart';
import 'orderSettlementNotifier.dart';
import 'otherServices/homeDeliveryNotifier.dart';
import 'otherServices/quickServiceHandler.dart';
import 'otherServices/takeAwayNotifier.dart';
import 'outletDetail.dart';
import 'servicePageNotifier.dart';

List<String> BillCompReasons=["CEO","Manager","Police","Relative"];
List<String> BillCancelReasons=["Wrong Entry","Customer Cancel"];
List<String> AuthorisedByList=["CEO","Manager"];
String selectedAuthorisedBy="";
int BillCompReasonSelected=-1;
TextEditingController reasonController=new TextEditingController();



void onBillCompDone() {
  if (BillCompReasonSelected==-1) {
    CustomAlert().commonErrorAlert("Select Reason", "");
    return;
  }
  InsertBillCompliment(0, BillCompReasons[BillCompReasonSelected]);
 // Compliclose();
}

void SettleBillCompAlert() {
  CustomAlert(
    cancelCallback: (){

    },
    callback: (){
      if(HasDirectPayOption() && HasCurrentItems()){
        InsertKotWithCallback((response){
          SetOrderDetailFromKot(response);
          InsertBillCompliment(1,"");
        });
      }
      else{
        InsertBillCompliment(1,"");
      }
    }
  ).yesOrNoDialog2("assets/functionPopUp/compliment.svg", "Are you sure want to Settle Compliment Bill ?", true);
}

Future<void> InsertBillCompliment(type,reason) async {
  if (type == 0) {
    //sysClearDisCartModel();
  }
  List<ParameterModel> params= await getParameterEssential();
  params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.insertBillCompliment));
  params.addAll(c_orderDetail.value!.insertBillComplimentParameters());
  params.add(ParameterModel(Key: "IsClear", Type: "String", Value: type));
  params.add(ParameterModel(Key: "AuthorisedBy", Type: "String", Value: ""));
  params.add(ParameterModel(Key: "Reason", Type: "String", Value: reason));
  params.add(ParameterModel(Key: "InputJson", Type: "String", Value: json.encode(params)));

  ApiManager.GetInvoke(params).then((value){
    if(value[0]){
      //addNotifications(2);
      var response=json.decode(value[1]);
      if (type == 0) {
        CustomAlert().commonErrorAlert("Bill Complimented Successfully","");
        c_orderDetail.value!.isBillCompliment = true;
      }
      else if (type == 1) {
        DestroyOrder();
        Get.back();
        getTableStatus(null, null);
        CustomAlert().commonErrorAlert("Compliment Bill Settled Successfully","");
        //log("$response");
        if (response['Table']!=null) {
          if(response['Table'].length > 0){
            try{
              var printerDetail = response['Table'][0]['OutPutJson'];
              //getPrinterTemplate(printerDetail);
            }
            catch(e){
              CustomAlert().commonErrorAlert("Bill Compliment Print Response", e.toString());
            }
          }
        }
        //successToast("Compliment Bill Settled Successfully...");
        /*if (response && response.Table && response.Table.length > 0) {
          var printerDetail = response.Table[0].OutPutJson;
          if (printerDetail)
            InvokePrinter(printerDetail);
        }*/

      }
      else if (type == 2) {
        CustomAlert().commonErrorAlert("Bill Compliment Cancelled Successfully","");
        //addNotifications(2,msg: "Bill Compliment Cancelled Successfully",img: "assets/functionPopUp/compliment.svg");
        //successToast("Bill Compliment Cancelled Successfully");
        c_orderDetail.value!.isBillCompliment = false;
      }
    }
  });
}