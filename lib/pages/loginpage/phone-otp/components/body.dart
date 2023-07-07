
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodecommerce/pages/HomePage/branchSelect.dart';


import '../../../../styles/constants.dart';
import '../../../../styles/style.dart';
import '../../../../utils/colorUtil.dart';
import '../../../../utils/sizeLocal.dart';
import '../../../HomePage/LandingPage.dart';
import '../../../navHomeScreen.dart';
import '../../login.dart';
import 'otp_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                              Text("+918601086010",style: TextStyle(fontSize: 30,fontFamily: 'RB',color: ColorUtil.thWhite),),
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
                    Image.asset('assets/images/loginpages/mobile-app.gif',fit: BoxFit.contain,),
                    OtpForm(),
                    SizedBox(height:30),
                    GestureDetector(
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>BranchSelect()),);//


                      },
                      child:Container(
                        height: 60,
                        width: SizeConfig.screenWidth,
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
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  // Row buildTimer() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       RichText(
  //         text: TextSpan(
  //           text: 'Please enter the ',
  //           style: TextStyle(fontSize: 14,fontFamily: 'RR',color: Color(0XFF000000)),
  //           children: const <TextSpan>[
  //             TextSpan(text: 'OTP', style: TextStyle(fontSize: 16,fontFamily: 'RB',color: Color(0XFF000000))),
  //             TextSpan(text: ' sent to  ', style: TextStyle(fontSize: 14,fontFamily: 'RR',color: Color(0XFF000000))),
  //           ],
  //         ),
  //
  //       ),
  //       TweenAnimationBuilder(
  //         tween: Tween(begin: 30.0, end: 0.0),
  //         duration: Duration(seconds: 30),
  //         builder: (_, dynamic value, child) => Text(
  //           "00:${value.toInt()}",
  //           style: TextStyle(color:Color(0XFF6A8528)),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
