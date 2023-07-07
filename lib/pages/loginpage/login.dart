import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodecommerce/pages/loginpage/mail-otp/components/otp_form.dart';
import 'package:foodecommerce/styles/style.dart';
import 'package:foodecommerce/utils/colorUtil.dart';

import '../../utils/sizeLocal.dart';
import '../navHomeScreen.dart';
import 'phone-otp/otp_screen.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  late bool passwordvisible;
  late bool loginvalidation;
  late AnimationController shakecontroller;
  late Animation<double> offsetAnimation;
  bool isLoading = false;
  bool isVisible = false;
  bool? rememberMe = false;

  String? prefEmail;
  String? prefPassword;
  bool? prefRememberMe;
  // late SharedPreferences _Loginprefs;
  static const String useremail = 'email';
  static const String passwordd = 'password';
  static const String rememberMee = 'rememberMe';
  late var node;
  Color fillColor = Color(0xFFFFFFFF);
  Color borderColor = Color(0xFFECECEC);
  Color inputTextColor = Color(0xFF9b9b9b);
  int _current = 0;
  final _text = TextEditingController();
  final _text1 = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    passwordvisible = true;
    loginvalidation = false;
    shakecontroller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    username.clear();
    password.clear();
    // SharedPreferences.getInstance()
    //   ..then((prefs) {
    //     setState(() => this._Loginprefs = prefs);
    //
    //     _loadCredentials();
    //   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    node = FocusScope.of(context);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);

    offsetAnimation = Tween(begin: 0.0, end: 28.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(shakecontroller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          shakecontroller.reverse().whenComplete(() {
            setState(() {
              loginvalidation = false;
            });
          });
        }
      });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFF7F8FA),
        body: Container(
          child: Stack(
            children: [
              Container(
                height: SizeConfig.screenHeight!-250,
                decoration: BoxDecoration(
                    color: ColorUtil.themeColor,
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(25.0),bottomLeft: Radius.circular(25.0))
                ),
                clipBehavior: Clip.antiAlias,
                padding:EdgeInsets.only(top:20,bottom:0 ) ,
                child: Column(
                  children: [
                    Image.asset('assets/images/loginpages/Login.png', width:SizeConfig.screenWidth,fit: BoxFit.contain,),
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset('assets/images/loginpages/Sankranthi-2.png', width:250,fit: BoxFit.contain,),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Fill The Below information to login',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'RM',
                            color: Color(0XFFffffff),
                          ),
                          textAlign: TextAlign.start,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.center,
                  width: SizeConfig.screenWidth,
                  height: 367,
                  margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
                  padding: EdgeInsets.only(top: 20,bottom: 0,left: 20,right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 8,
                      ),
                    ],
                    color: ColorUtil.thWhite,
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Form(
                            key: _loginFormKey,
                            child: AnimatedBuilder(
                                animation: offsetAnimation,
                                builder: (context, child) {
                                  return Container(
                                    //  margin: EdgeInsets.symmetric(horizontal: 24.0),
                                    padding: EdgeInsets.only(
                                        left: offsetAnimation.value + 15.0,
                                        right: 15.0 - offsetAnimation.value),
                                    child: Container(
                                      // margin: EdgeInsets.only(top: _height * 0.28),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/images/loginpages/mobile-app.gif',fit: BoxFit.contain,),
                                          loginvalidation
                                              ? Text(
                                            "Invalid Email Or Password",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 18,
                                                fontFamily: 'RR',
                                                letterSpacing: 0.2),
                                          )
                                              : Container(
                                            height: 20,
                                            width: 0,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 60,
                                            width: SizeConfig.screenWidth,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                border: loginvalidation
                                                    ? Border.all(
                                                    color: Colors.red, width: 2)
                                                    : Border.all(
                                                    color: borderColor, width: 2),
                                                color: loginvalidation
                                                    ? Color(0xFFCECECE)
                                                    : fillColor),
                                            child: TextFormField(
                                              scrollPadding: EdgeInsets.only(
                                                  bottom: SizeConfig.height250!),
                                              style: TextStyle(
                                                  color: loginvalidation
                                                      ? Colors.red
                                                      : inputTextColor,
                                                  fontSize: 16,
                                                  fontFamily: 'RR'),
                                              controller: username,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                hintText: "Enter Phone Number",
                                                hintStyle: TextStyle(
                                                    color: loginvalidation
                                                        ? Colors.red
                                                        : inputTextColor
                                                        .withOpacity(0.7),
                                                    fontSize: 16,
                                                    fontFamily: 'RR'),
                                                contentPadding: EdgeInsets.only(
                                                    left: 20, top: 10),
                                                //   fillColor: loginvalidation?HexColor("1C1F32"):Colors.white,
                                              ),
                                              keyboardType:
                                              TextInputType.emailAddress,
                                              validator: (value) {
                                                Pattern pattern =
                                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                                RegExp regex =
                                                new RegExp(pattern as String);
                                                if (!regex.hasMatch(value!)) {
                                                  return 'Email format is invalid';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onEditingComplete: () async {
                                                node.unfocus();
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // if(_loginFormKey.currentState!.validate()){
                                              //
                                              // }
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PhoneScreen()),
                                              );
                                            },
                                            child: Container(
                                              height: 60,
                                              width: SizeConfig.screenWidth,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                color: ColorUtil.themeColor,
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "SEND OTP",
                                                style: TextStyle(
                                                    fontFamily: 'MB',
                                                    color: ColorUtil.primaryColor,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
