import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:get/get.dart';



/*
// List<AlertModel> notifications=[];
RxList<AlertModel> notifications=RxList<AlertModel>();

void notificationRemoveAtIndex(int i){
  notifications[i].scaleController.reverse().whenComplete((){
    notifications.removeAt(i);
  });
}

void addNotifications(int i,{String msg=""}){
  if(i==1){
    notifications.add(AlertModel(img: "assets/reportIcons/print.svg",msg: msg.isEmpty?"Printer Not Connected":msg,isSuccess: false,
        scaleController: AnimationController(duration: Duration(milliseconds: 300,),vsync: AlertNotificationState())));

  }
  else if(i==2){
    notifications.add(AlertModel(img: "assets/reportIcons/print.svg",msg: msg.isEmpty?"KOT Sent Successfully":msg,isSuccess: true,
        scaleController: AnimationController(duration: Duration(milliseconds: 300,),vsync: AlertNotificationState())));
  }
  notifications[notifications.length-1].scaleController.forward().then((value) {
    notifications[notifications.length-1].isNew=false;
  });

  Timer(Duration(seconds: 3), (){
    //snotifyListeners();
    if(notifications.isNotEmpty){
      notificationRemoveAtIndex(0);
    }
  });
}*/
