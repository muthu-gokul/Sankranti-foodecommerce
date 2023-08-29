import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import '../../models/icons_model.dart';
import '../../notifier/appStateNotifier.dart';
import '../../notifier/utils.dart';
import '../../utils/sizeLocal.dart';


class FunctionPopUp extends StatefulWidget {
  Function(int)? ontap;
  VoidCallback? closeTap;
  FunctionPopUp({this.ontap,this.closeTap});
  @override
  _FunctionPopUpState createState() => _FunctionPopUpState();
}

class _FunctionPopUpState extends State<FunctionPopUp> {

  List<IconModel> checkpopuplist = [
    IconModel(name: "Menu",image: "assets/functionPopUp/menu.svg"),//0
/*    IconModel(name: "Bill Preview",image: "assets/functionPopUp/preview.svg",width: 35),//1
    IconModel(name: "Open Item",image: "assets/functionPopUp/open item.svg",width: 35),//2*/

  ];
  int? checkpopupselect;


  @override
  Widget build(BuildContext context) {
    return Obx(()=>AnimatedContainer(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth!*0.7,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
            // color: Color(0xFFAABAFE),
            color: Colors.white,
          ),
          clipBehavior: Clip.antiAlias,
          transform: Matrix4.translationValues(isFunctionPopUpOpen.value? SizeConfig.screenWidth!*0.3:SizeConfig.screenWidth!, 0, 0),
          child: Column(
            children: [
              Container(
                  height:50,
                  width:SizeConfig.screenWidth!*0.7,
               //  padding: plr15,
                  margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Provider.of<AppStateNotifier>(context,listen:false).CustomerDetailsListContent,
                  ),
                  child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[

                        Text("Functions",style: TextStyle(fontSize: 18,color:Provider.of<AppStateNotifier>(context,listen:false).billingTextColor,fontFamily: 'RR',letterSpacing: 0.3),),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: (){
                            TogglePopUp("c_Function");
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                           // margin: EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            alignment: Alignment.center,
                            child: Icon(Icons.clear,color: Colors.white,size: 20,),
                          ),
                        ),

                        // SizedBox(width:10),
                      ]
                  )
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: checkpopuplist.asMap().map((i,value) => MapEntry(i, GestureDetector(
                        onTap: (){
                          setState(()  {
                            checkpopupselect = i;
                            TogglePopUp("c_Function");
                            widget.ontap!(i);
                            Timer(Duration(milliseconds: 300), (){
                              setState(() {
                                checkpopupselect=-1;
                              });
                            });
                            if(i==0){
                              TogglePopUp("o_Menu");
                            }
                            else if(i==5){
                              //populateBillPreview();
                            }
                          });
                        },
                        child:Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            //   color: Colors.red
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color:checkpopupselect == i ? Provider.of<AppStateNotifier>(context,listen:false).appBarColor
                                        : Provider.of<AppStateNotifier>(context,listen:false).appBarColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                child: Center(
                                  //  child: SvgPicture.asset(value.image,width:i==4?35: 45,height:i==4?35: 45,
                                  child: SvgPicture.asset(value.image!,height:value.width,
                                    color:checkpopupselect == i ?Colors.white: Color(0xffff0123),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(value.name!,style: TextStyle(fontFamily: 'RR',fontSize: 15,color: Provider.of<AppStateNotifier>(context,listen:false).psNumPadText.withOpacity(0.65)),textAlign: TextAlign.center,)
                            ],
                          ),
                        )
                       )
                      )
                      ).values.toList()
                  ),
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        )
    );
  }
}
