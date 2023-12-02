import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../utils.dart';
import '../utils/apiUtils.dart';

final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
Map<String, dynamic> deviceData = <String, dynamic>{};

Future<void> initPlatformState() async {
  try {
    if (Platform.isAndroid) {
      deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } else if (Platform.isIOS) {
       deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
       print("deviceData $deviceData");
    }
  } on PlatformException {
    deviceData = <String, dynamic>{
      'Error:': 'Failed to get platform version.'
    };
  }
}

Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
  return <String, dynamic>{
    'version.securityPatch': build.version.securityPatch,
    'version.sdkInt': build.version.sdkInt,
    'version.release': build.version.release,
    'version.previewSdkInt': build.version.previewSdkInt,
    'version.incremental': build.version.incremental,
    'version.codename': build.version.codename,
    'version.baseOS': build.version.baseOS,
    'board': build.board,
    'bootloader': build.bootloader,
    'brand': build.brand,
    'device': build.device,
    'display': build.display,
    'fingerprint': build.fingerprint,
    'hardware': build.hardware,
    'host': build.host,
    'id': build.id,
    'manufacturer': build.manufacturer,
    'model': build.model,
    'product': build.product,
    'supported32BitAbis': build.supported32BitAbis,
    'supported64BitAbis': build.supported64BitAbis,
    'supportedAbis': build.supportedAbis,
    'tags': build.tags,
    'type': build.type,
    'isPhysicalDevice': build.isPhysicalDevice,
    'androidId': build.androidId,
    'systemFeatures': build.systemFeatures,
    'ver':build.version.toString()
  };
}
Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo build) {
  return <String, dynamic>{
    'id': build.identifierForVendor,
    'identifierForVendor': build.identifierForVendor,
  };
}

getDeviceId(){
  return deviceData['id'];
}

void setOutletDetail(key, value) async{
  var prefix =await getOutletId().toString() + "_" +await getLoginId().toString() + "_";
  var setKey = prefix + key;
  SharedPreferences sp=await SharedPreferences.getInstance();
  sp.setString(setKey, json.encode(value));

}

getOutletDetail(key) async{
  var prefix = await getOutletId().toString() + "_" + await getLoginId().toString() + "_";
  var getKey = prefix + key;
  SharedPreferences sp=await SharedPreferences.getInstance();
  return json.decode(sp.getString(getKey)??"");
}
Map<String,dynamic> featuresAccessId={
  'kot':1,
  'KOTPrint':2,
  'Bill':3,
  'BillPrint':4,
  'BillSettlement':5,
  'BillSettlementPrint':6,
  'BillCancel':7,
  'Discount':8,
  'Compliment':9,
  'Report':10,
  'DayClose':11,
  'Expenses':12,
  'OpenItem':13,
  'BillHistory':14,
  'Covers':15,
  'Waites':16,
  'Printer':17,
  'BillSMS':18,
  'WaiterCopy':19,
  'KOTNotification':20,
  'BillNotification':21,
  'BillSettlementNotification':22,
  'ECard':23,
  'ImageBillPrint':24,
  'TabSetting':25,
  'QuickServiceSingleShot':26,
  'AutoDayClose':29,
  'NeedAutoDayCloseAlert':30,
  'CaptainSelection':31,
  'OrderTypeParcelPriceOption':32,
  'OrderTypePriceTVP':33,
  'HasDirectPayOption':37,
  'HasWebSocketPrinting':38
};


const DINEIN_ID = 1;
const TAKEAWAY_ID = 2;
const HOMEDELIVERY_ID = 3;
const QUICLSERVICE_ID = 4;


const CASH_ID = 1;
const CARD_ID = 2;
const CASH_NAME = 'Cash';
const CARD_NAME = 'Card';

String GetImageUrl(type, path) {
  //2. Scuti Server 1. Amazon Server
  var baseUrl = type.toString() == "1" ? GetImageBaseUrl() : GetBaseUrl() +'/AppAttachments/';
  return baseUrl +path;
}
String GetImageBaseUrl() {
  return 'https://s3.ap-south-1.amazonaws.com/www.restacloudproductimages.com/';
}

bool HasExePrinting(){
  return isHasBillSettingsAccess(featuresAccessId['HasWebSocketPrinting']);
}


var uuid=Uuid();

setUUID(key) async{
  SharedPreferences sp=await SharedPreferences.getInstance();
  sp.setString(key, uuid.v1());
}
getUUID(key) async{
  SharedPreferences sp=await SharedPreferences.getInstance();
  return sp.getString(key)??uuid.v1();
}


setUUIDOnLoad() async{
  SharedPreferences sp=await SharedPreferences.getInstance();
  String kuid= sp.getString(kotUUID)??"";
  if(kuid.isEmpty){
    setUUID(kotUUID);
  }
  String buid= sp.getString(billUUID)??"";
  if(buid.isEmpty){
    setUUID(billUUID);
  }
}


const kotUUID = "KoTUUID";
const billUUID = "BillUUID";

void setLocalPrintIp(ip,{VoidCallback? scb}){
  setSharedPrefString(ip, SP_LOCAL_IP);
  softControls['printerActionIp']=ip;
  softControls['printerActionUrl']="http://${softControls['printerActionIp']}:9876/api/Printer/InvokePOSPrinter";
  if(scb!=null){
    scb();
  }
}

void assignLocalIpFromLocal() async{
  String ip=await getSharedPrefString(SP_LOCAL_IP);
  if(ip.isNotEmpty){
    setLocalPrintIp(ip);
  }
}

const String SP_USER_ID="userid";
const String SP_OUTLETID="outletid";
const String SP_PIN="pin";
const String SP_USERTYPEID="UserTypeId";
const String SP_TOKEN="tokennumber";
const String SP_USEREMAIL="c1";
const String SP_USERPASSWORD="c2";
const String SP_ISDEVICESUPPORT="devicesupport";
const String SP_HASFINGERPRINT="hasfingerprint";
const String SP_ALLOWFINGERPRINT="allowfingerprint";
const String SP_USERNAME="username";
const String SP_COMPANYID="companyid";
const String SP_CURRENTCALLAPPOINTMENTID="appointmentid";
const String SP_CURRENTCALLCLIENTOUTLETID="curroutletid";
const String SP_FIREBASETOKEN="ft";
const String SP_NOTIFICATIONBODY="nb";

Map<String,dynamic>  overAllSettingsId = {
  "billingLayout": 1,
  "digitalMenuLayout": 2,
  "paymentGateway":3,
  "isHasRoundOff":4,
  "listenForPendingKot":5,
  "listenTimerForPendingKot":6
};

