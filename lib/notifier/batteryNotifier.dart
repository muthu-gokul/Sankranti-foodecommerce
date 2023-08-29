import 'package:battery_info/battery_info_plugin.dart';
import 'package:flutter/material.dart';

class BatteryNotifier extends ChangeNotifier{

  int? binfo;
  var _batteryInfo;

  batteryInfo() async {
    //_batteryInfo= await AndroidDeviceInfo().getBatteryInfo();
    BatteryInfoPlugin().androidBatteryInfo.then((value){
      _batteryInfo=value!.batteryLevel;
      binfo=value.batteryLevel;
      notifyListeners();
    });
    // binfo="100";

  }
  @override
  void notifyListeners() {
    batteryInfo();
    super.notifyListeners();
  }

  @override
  void addListener(void Function() listener) {
    batteryInfo();
    super.addListener(listener);
  }

}