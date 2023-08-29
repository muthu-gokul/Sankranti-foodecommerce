import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Popup/alertDialog.dart';
import '../../../api/sp.dart';
import '../../../api/ApiManager.dart';
import '../../../models/parameterMode.dart';
import '../../utils.dart';
import '../../utils/apiUtils.dart';
import '../billingController.dart';
import '../cartNotifier.dart';
import '../configuration.dart';
import '../outletDetail.dart';
import 'intervalCallManager.dart';
var isDayCloseAlertOpen=false.obs;
void onDayClose(){
  if(isDayCloseAlertOpen.value){
    return;
  }
  isDayCloseAlertOpen.value=true;
  CustomAlert(
      callback: (){
        isDayCloseAlertOpen.value=false;
        DestroyOrder();
        if(Get.currentRoute.contains("BillingPage")){
          Get.back();
        }
        dayClose();
        //bn.dayCloseDbHit(context);
      },
      cancelCallback: (){
        isDayCloseAlertOpen.value=false;
      }
  ).yesOrNoDialog2(
      "assets/errors/day-closed.png",
      "Are you sure want to close the Day ?",
      false,
      imgHeight: 200,
      hei: 480,
      textWidth: 250
  );
}

void dayClose() async{
  String currentTime=DateFormat("HH:mm:ss").format(DateTime.now());
 // String cDate =DateFormat("yyyy-MM-dd").format(DateTime.now());
  DateTime currentBillDate=DateTime.parse("$dbCurrentDate $currentTime");
/*  if (cDate == dbCurrentDate.value)
    currentBillDate = DateTime.parse("$dbCurrentDate $currentTime");
  else
    currentBillDate = DateTime.parse("$cDate $currentTime");*/


  List<ParameterModel> params= await getParameterEssential();
  params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.dayClose));
  params.add(ParameterModel(Key: "UIDayCloseDate", Type: "String", Value: "$currentBillDate"));
  //log(json.encode(params));
  ApiManager.GetInvoke(params,needElegantNoti: true).then((value){
    //log("dayClose() $value");
    if(value[0]){
      CustomAlert().commonErrorAlert("Day Closed Successfully", "");
      getBillingOutlet();
    }
  });
}

void checkDayClose(){
  //DateTime currentBillDate=DateTime.parse(dbCurrentDate.value);
  String currentTime=DateFormat("HH:mm:ss").format(DateTime.now());
  String cDate =DateFormat("yyyy-MM-dd").format(DateTime.now());
  DateTime currentBillDate=DateTime.parse("$dbCurrentDate $currentTime");
  if (cDate == dbCurrentDate.value)
     currentBillDate = DateTime.parse("$dbCurrentDate $currentTime");
  else
     currentBillDate = DateTime.parse("$cDate $currentTime");

  int diffSeconds=currentBillDate.difference(dayCloseTime.value).inSeconds;
  log("currentTime $currentBillDate ${dayCloseTime.value} $diffSeconds");
  if(diffSeconds>=0){
    //need dayclose
    destroySecTimer();
    if(isHasBillSettingsAccess(featuresAccessId['NeedAutoDayCloseAlert'])){
      onDayClose();
    }
    else{
      if(HasCurrentItems() || HasTotalProducts()){
        onDayClose();
        Timer(Duration(minutes: 1), () {
          checkDayClose();
        });
      }
      else{
        DestroyOrder();
        dayClose();
      }
    }
  }
  else if(((-1)*diffSeconds)<=600){
    dayCloseSecondaryTimer();
  }
}