
import 'package:flutter/material.dart';

class MyConstants {
  MyConstants._();
  //Anandham
  //Sirpi
  //Sirpi Mentor
  static String appName = "Sankranti";
  //static String appName="RadiantECS_Dev";
  static String appVersion = "1.0.6";
  static String appId = "com.BridgetSolution.Sankranti";
  static bool isLive = false;
  static bool fromUrl = false;
  static bool hasAppVersionController = false;
  static bool bottomSafeArea = true;
  static bool defaultActionEnable = true;
  // static const DevelopmentMode developmentMode = DevelopmentMode.json;
  // static const PaymentGateway paymentGateway = PaymentGateway.razorpay;

  static Duration animeDuration = const Duration(milliseconds: 300);
  static Cubic animeCurve = Curves.easeIn;

  static String mapApiKey = "AIzaSyB9wKg5QXWHAoOd1i-mUKYhhaq6bBQuHeg";

  static int minimumDonationAmount = 1;

  static String dbDateFormat = "yyyy-MM-dd";
  static String decimalReg = r'^\d+\.?\d{0,3}';
  static int phoneNoLength = 10;
  static int zipcodeLength = 6;
  static String digitRegEx = '[0-9]';
  static String digitDecimalRegEx = r'^\d+\.?\d{0,30}';
  static String alphaSpaceRegEx = '[A-Za-z ]';
  static String alphaSpaceRegEx2 =
      "/[அ-ஔ]+|[க-னௌ]+|[ァ-ヴー]+|[a-zA-Z ]+|[々〆〤ヶ]+/u";
  static String addressRegEx = '[A-Za-z0-9-,_/*+()@. ]';
  static const String emailRegEx = '[A-Za-z0-9-,_/*+()@.]';
  static String dbDateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static String rupeeString = '\$';
  static String itemBlockPrefix="BL";
  static bool needUtilRefreshOnEachOrder=false;

  static String imgPath= "";
}
TextStyle textStyle=TextStyle(fontSize: 12,color: Colors.black,fontFamily: 'RR');
TextStyle textStyle1=TextStyle(fontSize: 12,color:Colors.black26,fontFamily: 'RR');
TextStyle textStyle2=TextStyle(fontSize: 12,color:Colors.black54,fontFamily: 'RR');
TextStyle textStyle3=TextStyle(fontSize: 12,color:Colors.white,fontFamily: 'RR');
TextStyle textStyle4=TextStyle(fontSize: 12,color: Colors.black,fontFamily: 'RR');