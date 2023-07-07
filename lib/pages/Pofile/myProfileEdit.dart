import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodecommerce/utils/colorUtil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../../../styles/constants.dart';
import '../../notifier/themeNotifier.dart';
import '../../styles/style.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/companySettingsTextField.dart';
import '../../widgets/customAppBar.dart';


class MyProfileEdit extends StatefulWidget {

  @override
  _MyProfileEditState createState() => _MyProfileEditState();
}

class _MyProfileEditState extends State<MyProfileEdit> {
  @override
  late  double width,height,width2,height2;
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    height2=height-16;
    return SafeArea(
      child:Scaffold(
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: SizeConfig.screenWidth,
                height:SizeConfig.screenHeight!-24 ,
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Container(
                      height:70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                          SizedBox(width: 10,),
                          Text('Edit Profile'
                            ,style: TextStyle(fontFamily: 'RB',fontSize: 16,color: Colors.black,letterSpacing: 0.1),),
                        ],
                      ),
                    ),

                    Positioned(
                      top: 80,
                      child: Container(
                      width: SizeConfig.screenWidth,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          children: [
                            CompanySettingsTextField(
                              hintText: "Balasubramaniyan",
                              img: "",
                              Sufimg: "",
                              borderRadius: textFieldBR,
                            ),
                            SizedBox(height: 15,),
                            CompanySettingsTextField(
                              hintText: "90923-22264",
                              img: "",
                              Sufimg: "",
                              borderRadius: textFieldBR,
                            ),
                            SizedBox(height: 15,),
                            CompanySettingsTextField(
                              hintText: "balasubramaniyan@gmail.com",
                              img: "",
                              Sufimg: "",
                              borderRadius: textFieldBR,
                            ),
                            SizedBox(height: 15,),
                            CompanySettingsTextField(
                              hintText: "17-08-1996",
                              img: "",
                              Sufimg: "",
                              borderRadius: textFieldBR,
                            ),
                            SizedBox(height: 15,),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text('Delivery Address',style:ts14(text1,fontfamily: 'RB',),)
                            ),
                            SizedBox(height: 15,),
                            CompanySettingsTextField(
                              hintText: "No:14, NP Developed Plots",
                              img: "",
                              Sufimg: "",
                              borderRadius: textFieldBR,
                            ),
                            SizedBox(height: 15,),
                            CompanySettingsTextField(
                              hintText: "1st Floor, MMDA 1st Main Rd, Maduravoyal,",
                              img: "",
                              Sufimg: "",
                              borderRadius: textFieldBR,
                            ),
                            SizedBox(height: 15,),
                            CompanySettingsTextField(
                              hintText: "Chennai",
                              img: "",
                              Sufimg: "",
                              borderRadius: textFieldBR,
                            ),
                            SizedBox(height: 15,),
                            CompanySettingsTextField(
                              hintText: "600095",
                              img: "",
                              Sufimg: "",
                              borderRadius: textFieldBR,
                            ),
                            SizedBox(height: 30,),
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
                                  'Save',
                                  style: TextStyle(
                                      fontFamily: 'RM',
                                      fontSize: 18,
                                      color: ColorUtil.primaryColor,
                                      letterSpacing: 0.1),
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
            ],
          ),
        ),
      ),
    );
  }
}
