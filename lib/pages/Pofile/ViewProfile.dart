import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../notifier/themeNotifier.dart';
import '../../utils/colorUtil.dart';
import '../../utils/sizeLocal.dart';
import 'myProfileEdit.dart';

class ViewProfile extends StatefulWidget {
  // VoidCallback voidCallback;
  // ViewProfile({required this.voidCallback});

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  @override
  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();
  late double width, height, width2, height2;
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    width2 = width - 16;
    height2 = height - 16;
    return SafeArea(
        child:Scaffold(
        backgroundColor: ColorUtil.themeColorBg,
          body: Container(
              height: height,
              width: width,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: ColorUtil.themeColor,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      children: [
                        Container(
                            height: 120,
                            width: 120,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: GestureDetector(
                              // onTap: (){
                              //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewProfile(),));
                              // },
                              child: Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.asset(
                                      "assets/images/landingPage/avatar-01.jpg")),
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Text(
                                'Mr. Balasubramaniyan v',
                                style: TextStyle(
                                    fontFamily: 'RB',
                                    fontSize: 18,
                                    color: ColorUtil.themeColor,
                                    letterSpacing: 0.1),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: SizeConfig.screenWidth! * 0.20,
                              height: 40,
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: ColorUtil.themeColor,
                                  borderRadius: BorderRadius.circular(25)
                                // shape: BoxShape.circle
                              ),
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                    fontFamily: 'RM',
                                    fontSize: 16,
                                    color: ColorUtil.primaryColor,
                                    letterSpacing: 0.1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox( height: 35, ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.fromLTRB(10,10,10,0),
                    padding: EdgeInsets.fromLTRB(15,20,15,20),
                    decoration: BoxDecoration(
                      color:ColorUtil.thWhite,
                      border: Border.all(color: Color(0XFFE4E4E4)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                                child: Image.asset('assets/images/landingPage/addressicon.png',fit:BoxFit.contain,width: 25,)),
                            SizedBox(width: 20,),
                            Text(
                              'Delivery Address',
                              style: TextStyle(
                                  fontFamily: 'RB',
                                  fontSize: 16,
                                  color: Colors.black,
                                  letterSpacing: 0.1),
                            ),
                            Spacer(),
                            GestureDetector(
                            onTap: (){
                              Get.to(MyProfileEdit());
                            },
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                    fontFamily: 'RB',
                                    fontSize: 16,
                                    color: ColorUtil.primaryColor,
                                    letterSpacing: 0.1),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'No:14, NP Developed Plots, TVK Industrial Estate, Ekkattuthangal Chennai-600032',
                          style: TextStyle(
                              fontFamily: 'RM',
                              fontSize: 16,
                              color: ColorUtil.thBlack),
                        )
                      ],
                    ),
                  ),
                  CustomerDetail('assets/images/landingPage/translate.png', 'Date of Birth', '17-08-1996', 'Change'),
                  CustomerDetail('assets/images/landingPage/call.png', 'Phone Number', '90923-22264', 'Change'),
                  CustomerDetail('assets/images/landingPage/mail.png', 'Email', 'balasubramaniyan@gmail.com', 'Change'),
                  SizedBox( height: 35, ),
                  Align(
                  alignment: Alignment.bottomCenter,
                    child: Container(
                      width: SizeConfig.screenWidth! * 0.5,
                      height: 60,
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: ColorUtil.themeColor,
                          borderRadius: BorderRadius.circular(25)
                        // shape: BoxShape.circle
                      ),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                            fontFamily: 'RM',
                            fontSize: 18,
                            color: ColorUtil.primaryColor,
                            letterSpacing: 0.1),
                      ),
                    ),
                  ),
                ]),
              )),
        ),);
  }
}
 Widget CustomerDetail(String Img,String Title, String Detials , String Edit){
 return Container(
   width: SizeConfig.screenWidth,
   margin: EdgeInsets.fromLTRB(10,10,10,0),
   padding: EdgeInsets.fromLTRB(15,20,15,20),
   decoration: BoxDecoration(
     color:ColorUtil.thWhite,
     border: Border.all(color: Color(0XFFE4E4E4)),
     borderRadius: BorderRadius.circular(4),
   ),
   child:  Row(
     children: [
       Container(
           child: Image.asset(Img,fit:BoxFit.contain,width: 25,)),
       SizedBox(width: 20,),
       Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(
             Title,
             style: TextStyle(
                 fontFamily: 'RB',
                 fontSize: 16,
                 color: Colors.black,
                 letterSpacing: 0.1),
           ),
           Text(
             Detials,
             style: TextStyle(
                 fontFamily: 'RM',
                 fontSize: 16,
                 color: Colors.black,
                 letterSpacing: 0.1),
           ),
         ],
       ),
       Spacer(),
       Text(
         Edit,
         style: TextStyle(
             fontFamily: 'RB',
             fontSize: 16,
             color: ColorUtil.primaryColor,
             letterSpacing: 0.1),
       ),
     ],
   ),
 );
 }