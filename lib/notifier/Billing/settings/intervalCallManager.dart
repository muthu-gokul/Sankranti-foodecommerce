import 'dart:async';
import 'dart:developer';
import 'daycloseNotifier.dart';
Timer? sysTimer,secondaryTimer;
void intervalCallInit({bool needTimer=false}){
  secondaryTimer=null;
  checkDayClose();
  if(sysTimer==null){
    sysTimer=Timer.periodic(Duration(seconds: 300), (timer) {
      checkDayClose();
    });
  }
  else{
    if(!needTimer)
      cancelIntervalTimer();
  }
}

void cancelIntervalTimer(){
  if(sysTimer!=null){
    sysTimer!.cancel();
    sysTimer=null;
  }
}

void onLogout(){
  cancelIntervalTimer();
  if(secondaryTimer!=null){
    secondaryTimer!.cancel();
    secondaryTimer=null;
  }
  //closeSignalRConn();
  //signalRHelper=null;
}

void dayCloseSecondaryTimer(){
  cancelIntervalTimer();
  if(secondaryTimer==null)
    secondaryTimer=Timer.periodic(Duration(seconds: 15), (timer) {
      checkDayClose();
    });
}
void destroySecTimer(){
  if(secondaryTimer!=null){
    secondaryTimer!.cancel();
    secondaryTimer=null;
  }
}