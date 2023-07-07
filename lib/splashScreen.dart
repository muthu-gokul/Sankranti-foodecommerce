import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodecommerce/utils/colorUtil.dart';
import 'package:get/get.dart';
import '../api/ApiManager.dart';
import '../utils/constants.dart';
import '../utils/sizeLocal.dart';
import 'pages/loginpage/login.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final LocalAuthentication auth = LocalAuthentication();

  navigate() {
    //Get.off(KaylirWebView());
    Get.off(loginPage());
  }

  @override
  void initState() {
    // SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      navigate();
    });
     super.initState();

  }

  // Future<void> _checkBiometrics() async {
  //   late bool canCheckBiometrics;
  //   try {
  //     canCheckBiometrics = await auth.canCheckBiometrics;
  //   } on PlatformException catch (e) {
  //     canCheckBiometrics = false;
  //     print(e);
  //   }
  //   if (!mounted) {
  //     return;
  //   }
  //   setSharedPrefBool(canCheckBiometrics, SP_HASFINGERPRINT);
  // }
  //
  // void checkUserData() async {
  //   // await languageInit();
  //   navigate();
  //
  //   return;
  //   //await getFirebaseToken();
  //   String userId = await getSharedPrefString(SP_USER_ID);
  //   if (userId.isEmpty) {
  //     navigate();
  //   } else {
  //     getDeviceStatus(userId);
  //   }
  // }
  //
  // void getDeviceStatus(userId) async {
  //   String pin = await getSharedPrefString(SP_PIN);
  //   List<ParameterModel> params = [];
  //   params.add(ParameterModel(
  //       Key: "SpName", Type: "String", Value: Sp.getDeviceStatus));
  //   params
  //       .add(ParameterModel(Key: "LoginUserId", Type: "String", Value: userId));
  //   params.add(
  //       ParameterModel(Key: "DeviceId", Type: "String", Value: getDeviceId()));
  //   params.add(
  //       ParameterModel(Key: "database", Type: "String", Value: getDatabase()));
  //
  //   ApiManager().GetInvoke(params).then((response) {
  //     if (response[0]) {
  //       try {
  //         var parsed = json.decode(response[1]);
  //         console("$parsed");
  //         var t = parsed['Table'];
  //         if (t[0]['IsRegistered']) {
  //           if (pin.isNotEmpty) {
  //             setSharedPrefString(t[0]['TokenNumber'], SP_TOKEN);
  //             //Get.off(PinScreenLogin());
  //           } else {
  //             navigate();
  //           }
  //         } else {
  //           navigate();
  //         }
  //       } catch (e) {
  //         navigate();
  //       }
  //     }
  //   });
  // }
  //
  // Future languageInit() async {
  //   await Language.parseJson(selectedLanguage.value);
  //   //setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    topPadding = MediaQuery.of(context).padding.top;
    SizeConfig().init(context);

    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: [SystemUiOverlay.bottom]);
    return SafeArea(
      bottom: MyConstants.bottomSafeArea,
      child: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
            //  color: Color(0xFFFF7899),
            color: ColorUtil.themeColor,
              child: Image.asset('assets/splash.png')
            //Kaylir Image.asset('assets/Kaylir/logo.png')//Kaylir

            /*Image.asset("assets/logo.png"),*/ //AimTV
          ),
        ],
      ),
    );
  }
}
