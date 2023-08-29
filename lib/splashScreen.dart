
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodecommerce/pages/loginpage/login.dart';

import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import 'api/ApiManager.dart';
import 'api/sp.dart';
import 'models/parameterMode.dart';
import 'notifier/Billing/configuration.dart';
import 'notifier/utils.dart';
import 'notifier/utils/apiUtils.dart';
import 'pages/HomePage/branchSelect.dart';
import 'utils/sizeLocal.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final LocalAuthentication auth = LocalAuthentication();

  navigate(){
    Get.off(loginPage());
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /*navigate();
      return;*/
      initPlatformState().then((value){
        checkUserData();
      });
      if(Platform.isAndroid){
        _checkBiometrics();
      }
    });
    super.initState();
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }
    setSharedPrefBool(canCheckBiometrics, SP_HASFINGERPRINT);
  }


  void checkUserData() async{
    //await getFirebaseToken();
    String userId=await getSharedPrefString(SP_USER_ID);
    if(userId.isEmpty){
      navigate();
    }
    else{
      getDeviceStatus(userId);
    }
  }

  void getDeviceStatus(userId) async{

    String pin=await getSharedPrefString(SP_PIN);
    //log("pin $pin");
    List<ParameterModel> params=[];
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.getDeviceStatus));
    params.add(ParameterModel(Key: "LoginUserId", Type: "String", Value: 0));
    params.add(ParameterModel(Key: "CustomerId", Type: "String", Value: userId));
    params.add(ParameterModel(Key: "DeviceId", Type: "String", Value: getDeviceId()));
    params.add(ParameterModel(Key: "database", Type: "String", Value: await getDatabase()));

    ApiManager.GetInvoke(params).then((response){
      if(response[0]){
        try{
          var parsed=json.decode(response[1]);
          log("$parsed");
          var t=parsed['Table'];
          if(t[0]['IsRegistered']){
            customerId=parseInt(t[0]['UserId']);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>BranchSelect()),);
            /*if(pin.isNotEmpty){
              setSharedPrefString(t[0]['TokenNumber'], SP_TOKEN);
             // Get.off(PinScreenLogin());
            }
            else{
              navigate();
            }*/
          }
          else{
            navigate();
          }
        }catch(e){
          navigate();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    topPadding=MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            color: Colors.white,
            child: Image.asset("assets/splash.png"),
          ),
        ],
      ),
    );
  }
}