import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodecommerce/notifier/utils.dart';
import 'package:get/get.dart';
import 'package:scutiwidgets/alertDialog.dart';
import '../../../api/ApiManager.dart';
import '../../../api/sp.dart';
import '../../../models/parameterMode.dart';
import '../../../notifier/Billing/configuration.dart';
import '../../../notifier/utils/apiUtils.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/sizeLocal.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/pinWidget.dart';
import '../../HomePage/branchSelect.dart';
import '../login.dart';
import 'components/body.dart';
import 'components/otp_form.dart';

class PhoneScreen extends StatelessWidget {
  static String routeName = "/mail-otp";


  PinWidget pinWidget=PinWidget(pinLength: 6,onComplete: (){

  },);
  String phoneNumber;
  PhoneScreen(this.phoneNumber,{super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight!-250,
              decoration: BoxDecoration(
                  color: ColorUtil.themeColor,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(25.0),bottomLeft: Radius.circular(25.0))
              ),
              clipBehavior: Clip.antiAlias,
              padding:EdgeInsets.only(top:20,bottom:0 ) ,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset('assets/images/loginpages/Sankranthi-2.png', width:200,fit: BoxFit.contain,),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      Container(
                        padding:EdgeInsets.symmetric(horizontal: 20),
                        width: SizeConfig.screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Verification code",style: TextStyle(fontSize: 30,fontFamily: 'RB',color: ColorUtil.thWhite),),
                            SizedBox(
                              height: 10,
                            ),
                            Text("We have sent the code verification to your Mobile number",style: TextStyle(fontSize: 16,fontFamily: 'RR',color: ColorUtil.thWhite),textAlign: TextAlign.center,),
                            SizedBox(height: 40,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("$phoneNumber",style: TextStyle(fontSize: 20,fontFamily: 'RB',color: ColorUtil.thWhite),),
                                SizedBox(width: 10,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>loginPage()),);//
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorUtil.primaryColor
                                    ),
                                    child: Icon(Icons.edit,color: ColorUtil.themeColor,),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
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
                padding: EdgeInsets.only(top: 20,bottom: 0,left: 0,right: 0),
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
                    Image.asset('assets/images/loginpages/mobile-app.gif',fit: BoxFit.contain,),
                    pinWidget,
                    const SizedBox(height:30),
                    Obx(() =>showLoader.value?CircularBtn(): GestureDetector(
                      onTap: (){
                        onVerify(context);
                      },
                      child:Container(
                        height: 60,
                        width: SizeConfig.screenWidth,
                        margin: const EdgeInsets.only(left: 20,right: 20),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(10),
                          color: ColorUtil.themeColor,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "VERIFY",
                          style: TextStyle(
                              fontFamily: 'RM',
                              color: ColorUtil.primaryColor,
                              fontSize: 16),
                        ),
                      ),
                    ),)
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void onVerify(BuildContext context) async{
    if(pinWidget.validate()){
      params=[];
      params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.mobileLogin));
      params.add(ParameterModel(Key: "OTPNumber", Type: "String", Value: pinWidget.getValue()));
      params.add(ParameterModel(Key: "Customername", Type: "String", Value: phoneNumber));
      params.add(ParameterModel(Key: "DeviceId", Type: "String", Value: getDeviceId()));
      params.add(ParameterModel(Key: "MPINNumber", Type: "String", Value: ""));
      params.add(ParameterModel(Key: "Type", Type: "String", Value: "3"));
      params.add(ParameterModel(Key: "Password", Type: "String", Value: ""));
      params.add(ParameterModel(Key: "database", Type: "String", Value: await getDatabase()));
      ApiManager.GetInvoke(params).then((value){
        print("$value");
        if(value[0]){
          var parsed=jsonDecode(value[1]);
          setSharedPrefString(parsed["Table"][0]["CustomerId"], SP_USER_ID);
          customerId=parseInt(parsed["Table"][0]["CustomerId"]);
          createPin("");
          Navigator.pop(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BranchSelect()),);
        }
        else{
          CustomAlert().cupertinoAlertDialog(context, value[1]);
        }
      });
    }
  }

  void createPin(String pin) async{
    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.insertPin));
    params.add(ParameterModel(Key: "CustomerPINNumber", Type: "String", Value: pin));
    params.add(ParameterModel(Key: "CustomerId", Type: "String", Value: customerId));
    ApiManager.GetInvoke(params).then((response) async {
      debugPrint("$response");
      if(response[0]){
        var parsed=json.decode(response[1]);
        insertDeviceInfo(pin);
      }
    });
  }

  void insertDeviceInfo(pin) async{
    String ft=await getSharedPrefString(SP_FIREBASETOKEN);
    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.insertUserDevice));
    params.add(ParameterModel(Key: "MPINNumber", Type: "String", Value: pin));
    params.add(ParameterModel(Key: "DeviceInfo", Type: "String", Value: deviceData.toString()));
    params.add(ParameterModel(Key: "NotificationTokenNumber", Type: "String", Value: ft));
    params.add(ParameterModel(Key: "CustomerId", Type: "String", Value: customerId));
    //log("insertDeviceInfo ${jsonEncode(params)}");
    ApiManager.GetInvoke(params).then((response) async {
      debugPrint("$response");
      if(response[0]){
        var parsed=json.decode(response[1]);
        //log("insertDeviceInfo $parsed");
      }
    });
  }

}
