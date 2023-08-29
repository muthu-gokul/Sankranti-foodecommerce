import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import '../../../Popup/alertDialog.dart';
import '../../../api/ApiManager.dart';
import '../../../api/sp.dart';
import '../../../models/parameterMode.dart';
import '../../../styles/app_theme.dart';
import '../../../styles/style.dart';
import '../../../utils/constants.dart';
import '../../utils.dart';
import '../../utils/apiUtils.dart';
import 'package:http/http.dart' as http;
import '../configuration.dart';
import '../outletDetail.dart';



// Map<String,dynamic> tabCustomSettingsInfo={
//   "bluetoothPrinterBrand":"dmin"
// };

String bluetoothBrand="dmin";


void getAppVersionDetail() async{
  List<ParameterModel> params= await getParameterEssential();
  params.add(ParameterModel(Key: "SpName", Type: "String", Value: "RB_GetAppVersionDetail"));
  params.add(ParameterModel(Key: "AppName", Type: "String", Value:MyConstants.appName));
  ApiManager.GetInvoke(params,hideLoaders: true).then((value){
    if(value[0]){
      var response=json.decode(value[1]);

      if(response['Table']!=null){
        if(response['Table'].length>0 && MyConstants.hasAppVersionController){
          if(response['Table'][0]['AppVersionNumber']!=MyConstants.appVersion){
            Get.defaultDialog(title: "",titleStyle: TextStyle(height: 0),radius: 10,middleText: "New Update Available",middleTextStyle: TextStyle(fontFamily: "RR",fontSize: 20,),
                barrierDismissible: false,
                contentPadding: EdgeInsets.all(20),
                confirm: GestureDetector(
                  onTap: (){
                    launchUrl(Uri.parse(response['Table'][0]['AppVersionURL']),mode: LaunchMode.externalApplication);
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppTheme.red,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text("Update",style: ts18(Colors.white),),
                  ),
                )
            );
          }
        }
      }
      if(response['Table1'].length>0){
        tabCustomSettingsInfo['bluetoothPrinterBrand']=response['Table1'][0]['BrandName']??"dmin";
        bluetoothBrand=response['Table1'][0]['BrandName'];
        log("getAppVersionDetail ${tabCustomSettingsInfo['bluetoothPrinterBrand']} $response");
         /* if(response['Table1'][0]['BrandName']=="imin"){
            Provider.of<ReportNotifier>(Get.context!,listen:false).tempPrinter="BluetoothPrinter";
          }
          else{
            Provider.of<ReportNotifier>(Get.context!,listen:false).tempPrinter="InnerPrinter";
          }*/
      }
      else{
        tabCustomSettingsInfo['bluetoothPrinterBrand']="dmin";
      }
      if(response['Table2']!=null && response['Table2'].length>0){
        //localHubUrl='http://${response['Table2'][0]['HubIpAddress']}:3098';
      }
    }
  });
}


var imageLoader=false.obs;
void getImages({bool sync=false}) async{
  bool downloaded=await getSharedPrefBool(SP_IMAGEDOWNLOADED);
  if(downloaded){
    if(!sync){
      return;
    }
  }
  imageLoader.value=true;
  Directory? directory=await getApplicationPath();
  MyConstants.imgPath=directory!.path+"/";
  print("MyConstants.imgPath ${MyConstants.imgPath}");
  //await getExternalStorageDirectory();
  await getApplicationDocumentsDirectory();
  List<ParameterModel> params= await getParameterEssential();
  params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.getImages));
  ApiManager.GetInvoke(params,hideLoaders: true).then((value){
    if(value[0]){
      try{
        var response=json.decode(value[1]);
        response['Table'].forEach((e){
          String url=GetImageUrl(e['ImageUrlType'],e['ProductImageFolderName']+"/"+e['ProductImageFileName']);
          //log("$url");
          _download(url,e['ProductImageFolderName'],e['ProductImageFileName']);
        });
        log("downloaded");
        Timer(Duration(seconds: 5), () {
          imageLoader.value=false;
          if(sync){
            populateProducts(null, c_OrderTypeId.value);
            CustomAlert().commonErrorAlert("Images Synced...", "");
          }

        });

        setSharedPrefBool(true, SP_IMAGEDOWNLOADED);
       // log("getImages $response");
        /*_download(url,"ProductItems","Meals.png");*/
      }catch(e){
        imageLoader.value=false;
      }
    }
  });
}

Future<void> _download(String url,String imgFolder,String imgName) async {
  try{
    final response = await http.get(Uri.parse(url));
    final localPath = MyConstants.imgPath+imgFolder+'/'+imgName;
    final imageFile = await File(localPath).create(recursive: true);
    await imageFile.writeAsBytes(response.bodyBytes);
  }catch(e){
    log("_download $e");
  }
}



