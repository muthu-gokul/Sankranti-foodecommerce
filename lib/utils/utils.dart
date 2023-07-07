import 'dart:developer';
import 'dart:io';

import 'package:intl/intl.dart';

import '../utils/colorUtil.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

Map<String,dynamic> accessId={
  "ManageUsersView":3,
  "ManageUsersAdd":4,
  "ManageUsersEdit":5,
  "ManageUsersDelete":6,
  "UserAccessView":7,
  "UserAccessEdit":8,
  "SettingsMainView":9,
  "SettingsZoneView":9,
  "SettingsCompanyView":9,
  "SettingsCoordinatorView":9,
  "SettingsZoneAdd":10,
  "SettingsCoordinatorAdd":10,
  "SettingsZoneEdit":11,
  "SettingsCoordinatorEdit":11,
  "SettingsZoneDelete":12,
  "SettingsCoordinatorDelete":12,
  "VolunteerView":13,
  "VolunteerDelete":14,
  "VolunteerApproval":15,
  "LandParcelView":16,
  "LandParcelAdd":17,
  "LandParcelEdit":18,
  "LandParcelDelete":19,
  "LandParcelApproval":20,
  "DashBoardView":21,
  "HomeView":22,
  "SeedCollectionView":23,
  "SeedCollectionAdd":24,
  "SeedCollectionEdit":25,
  "SeedCollectionDelete":26,
  "SeedCollectionApproval":27,
  "NurseryView":28,
  "NurseryAdd":29,
  "NurseryEdit":30,
  "NurseryDelete":31,
  "NurseryApproval":36,
  "PlantationView":32,
  "PlantationAdd":33,
  "PlantationEdit":34,
  "PlantationDelete":35,
  "PlantationApproved":37,
  "CSRDashboardView":38,
  "EventsView":39,
  "EventsAdd":40,
  "EventsEdit":41,
  "EventsDelete":42,
  "EventsApproved":43,
  "EventsInterestedView":44,
  "NewsFeedView":45,
  "NewsFeedAdd":46,
  "NewsFeedEdit":47,
  "NewsFeedDelete":48,
  "DonorView":49,
  "DonorAdd":50,
  "EGFZoneApproval":51,
  "DonorDetailsView":52,
  "CSRAdd":53,
  "CSRView":54,
  "CSREdit":55,
  "CSRDelete":56,
  "CSRAddAmount":57,
};
List<dynamic> accessData=[];
bool isHasAccess(int uniqueId){
  try{
    int IsHasAccess=accessData.where((element) => element['UniqueId']==uniqueId).toList()[0]['IsHasAccess'];
    return IsHasAccess==1;
  }catch(e){
    return false;
  }
}


parseDouble(var value){
  try{
    return double.parse(value.toString());
  }catch(e){}
  return 0.0;
}

parseInt(var value){
  console("wwwww ${value.toString()}");
  try{
    return int.parse(value.toString());
  }catch(e){}
  return 0;
}

String getRupeeString(value){
  //return "${MyConstants.rupeeString} ${formatCurrency.format(parseDouble(value))}";
  double a=parseDouble(value);
  return "${MyConstants.rupeeString} ${ NumberFormat.currency(locale: 'HI',name: "",decimalDigits: getDecimalDigitLen(a)).format(a)}";
}

String getRupeeFormat(value){
  double a=parseDouble(value);
  return NumberFormat.currency(locale: 'HI',name: "",decimalDigits: getDecimalDigitLen(a)).format(a);
}

int getDecimalDigitLen(double a){
  int decimalDigit=2;
  String parsedDoubleStr=a.toString();
  List b=parsedDoubleStr.split(".");
  if(b.length==2){
    if(b[1].length>2){
      decimalDigit=b[1].length;
    }
  }
  return decimalDigit;
}



void console(var content){
  log(content.toString());
}
enum PayStatus{
  payStatus,
  pay,
  paid,
  partiallyPaid,
  approved,
  rejected,
  completed,
  partialApproved,
  pending
}



String getTitleCase(value){
  return value;
  //return value.toString().titleCase;
}

//Nested ScrollView
double flexibleSpaceBarHeight=160.0;
double toolBarHeight=50.0;
double triggerOffset=60.0;
double triggerEndOffset=80.0;



Widget formGridContainer(List<Widget> children){
  return Container(
      margin: const EdgeInsets.only(top: 10,bottom: 20,left: 15,right: 15),
      padding: const EdgeInsets.only(bottom: 20,top: 15),
      decoration: BoxDecoration(
      //color: ColorUtil.primary.withOpacity(0.3),
      color: ColorUtil.themeWhite,
      borderRadius: BorderRadius.circular(5)
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    ),
  );
}

Widget formTableHeader(String title,{bool needFittedBox=false}){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child:needFittedBox? Container(
        height: 15,
        child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Text(title,style: ColorUtil.formTableHeaderTS,)
        )
    ):Text(title,style: ColorUtil.formTableHeaderTS,),
  );
}





const String egfCompanyId="1";

enum PaymentGateway{
  razorpay,
  cashFree
}

Map getParamsFromUrl(url) {
  var params = {};
  try{
    url.split('?')[1].split('&').forEach((i) {
      params[i.split('=')[0]] = i.split('=')[1];
    });
  }catch(e){}
  return params;
}

/*
Future<Directory?> getApplicationPath() async{
  if(Platform.isAndroid){
    return await getExternalStorageDirectory();
  }
  return await getApplicationDocumentsDirectory();
}
Future<String?> getInternalDownloadPath() async{
  bool dirDownloadExists = true;
  var directory;
  if (Platform.isIOS) {
    Directory? a = await getDownloadsDirectory();
    return a!.path;
  }
  else {

    directory = "/storage/emulated/0/Download/";

    dirDownloadExists = await Directory(directory).exists();
    if(dirDownloadExists){
      directory = "/storage/emulated/0/Download/";
    }else{
      directory = "/storage/emulated/0/Downloads/";
    }
    return directory;
  }
}
*/

String getFileNameFromFolderPath(String dbPath){
  try{
    return dbPath.split("/")[1];
  }catch(e){}
  return '';
}


String getFolderNameFromFolderPath(String dbPath){
  try{
    return dbPath.split("/")[0];
  }catch(e){}
  return '';
}

String timeAgo(DateTime fatchedDate) {
  DateTime currentDate = DateTime.now();

  var different = currentDate.difference(fatchedDate);
  //print(different.inHours);

  if (different.inDays > 365)
    return "${(different.inDays / 365).floor()} ${(different.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  if (different.inDays > 30)
    return "${(different.inDays / 30).floor()} ${(different.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  if (different.inDays > 7)
    return "${(different.inDays / 7).floor()} ${(different.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  if (different.inDays > 0)
    return "${different.inDays} ${different.inDays == 1 ? "day" : "days"} ago";
  if (different.inHours > 0)
    return "${different.inHours} ${different.inHours == 1 ? "hour" : "hours"} ago";
  if (different.inMinutes > 0)
    return "${different.inMinutes} ${different.inMinutes == 1 ? "min" : "mins"} ago";
  if (different.inMinutes == 0) return 'Just Now';

  return fatchedDate.toString();
}

Stream<String> timeAgoStream(DateTime createdTime,) async* {
  while (true) {
    await Future.delayed(Duration(minutes: 1));
    yield timeAgo(createdTime);
  }
}

String getOrdinal(n) {
  String ord = 'th';
  if (n % 10 == 1 && n % 100 != 11)
  {
    ord = 'st';
  }
  else if (n % 10 == 2 && n % 100 != 12)
  {
    ord = 'nd';
  }
  else if (n % 10 == 3 && n % 100 != 13)
  {
    ord = 'rd';
  }
  return "$n${ord}";
}