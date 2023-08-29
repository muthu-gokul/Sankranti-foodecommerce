import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../notifier/Billing/billingController.dart';
import '../../notifier/Billing/outletDetail.dart';
import '../../notifier/appStateNotifier.dart';
import '../../notifier/utils.dart';
import '../../styles/app_theme.dart';

import 'package:provider/provider.dart';

import '../../utils/sizeLocal.dart';


class MenuPopUp extends StatefulWidget {

  @override
  _MenuPopUpState createState() => _MenuPopUpState();
}

class _MenuPopUpState extends State<MenuPopUp> {
  @override
  Widget build(BuildContext context) {
    return Obx(()=> AnimatedContainer(duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          color:  Provider.of<AppStateNotifier>(context,listen:false).secondaryBgColor,
          transform: Matrix4.translationValues( 0, isMenuListClick.value? 0 : -1000, 0),
          child:Row(
            mainAxisAlignment:MainAxisAlignment.start,
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top:50),
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth!-50,//-100
                child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 25,
                    runSpacing: 10,
                    children: filtermenu.asMap()
                        .map((i, value) => MapEntry(i,  GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: (){
                          updateMenu(i);
                          TogglePopUp("c_Menu");
                        },
                        child: Container(
                            height:40,
                            width:120,
                            decoration:BoxDecoration(
                              borderRadius:BorderRadius.circular(40),
                              border: Border.all(color:AppTheme.red),
                              color: c_MenuId.value==value.MenuId?Provider.of<AppStateNotifier>(context,listen:false).appBarColor:
                              Provider.of<AppStateNotifier>(context,listen:false).tabBarColor,
                            ),
                            child:Center(
                                child:Text("${value.MenuName}",
                                    style:TextStyle( fontFamily: 'RR', color: Colors.white,fontSize:16)
                                )
                            )
                        )

                    ),

                    )
                    ).values.toList()
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10,right: 10),
                  height: 40,
                  width: 40,
                  child:Center(
                    child: GestureDetector(
                      onTap:(){
                        TogglePopUp("c_Menu");
                      },
                      child: Container(
                        height: 40,
                        width:40,
                        // margin: EdgeInsets.only(right: 15,top:20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.clear,color: Colors.white,size:25),
                      ),
                    ),
                  )
              )
            ],
          )

      ),
    );
  }
}
