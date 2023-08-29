import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../styles/app_theme.dart';
import '../utils/sizeLocal.dart';


class CustomAlert{
  RoundedRectangleBorder alertRadius=RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),);

  VoidCallback? callback;
  VoidCallback? cancelCallback;
  CustomAlert({this.callback,this.cancelCallback});



  void commonErrorAlert2(BuildContext context,String title,String? des){
    if(des==null){
      des="";
      //des=Provider.of<BillingNotifier>(context, listen: false).errorMsg;
    }
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
          child: Container(
             // height:des.length>200?450:280,
              height:280,
              width:400,
              decoration:BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),

              child:Column(
                  children:[
                    SizedBox(height:10),
                    SvgPicture.asset('assets/errors/error-icon.svg'),
                    SizedBox(height:30),
                    Text(title,
                      style:TextStyle(fontFamily:'RM',fontSize:18,color:AppTheme.red),textAlign: TextAlign.center,
                    ),
                    SizedBox(height:20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(des!,
                          style:TextStyle(fontFamily:'RL',fontSize:16,color:Color(0xFF787878)),textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ]
              )
          ),
        )
    );
  }

  void commonErrorAlert(String title,String des){
    showDialog(
        context: Get.context!,
        builder: (ctx) => AlertDialog(
          shape: alertRadius,
          clipBehavior: Clip.antiAlias,
          content: Container(
            // height:280,
              width:SizeConfig.screenWidth,
              decoration:const BoxDecoration(
                color:Colors.white,
              ),

              child:Column(
                  mainAxisSize: MainAxisSize.min,
                  children:[
                    const SizedBox(height:10),
                    SvgPicture.asset('assets/errors/error-icon.svg'),
                    const SizedBox(height:30),
                    Text(title,
                      style:TextStyle(fontFamily:'RM',fontSize:22,color:AppTheme.red),textAlign: TextAlign.center,
                    ),
                    const SizedBox(height:10),
                    Flexible(
                      child: SingleChildScrollView(
                        child:Html(data: des,shrinkWrap: true,),
                        // child: Text(des, style:TextStyle(fontFamily:'RL',fontSize:16,color:Color(0xFF787878)),textAlign: TextAlign.center,),
                      ),
                    ),
                    /* Text(des,
                      style:TextStyle(fontFamily:'RL',fontSize:18,color:Color(0xFF787878)),textAlign: TextAlign.center,
                    ),*/
                  ]
              )
          ),
        )

    );
  }

  void selectTableAlert(BuildContext context,String img,String title){
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
          child: Container(
              height:250,
              width:400,
              decoration:BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),

              child:Column(
                  children:[
                    SvgPicture.asset(img),
                    SizedBox(height:10),
                    Text(title,
                        style:TextStyle(fontFamily:'RR',fontSize:20,color:Color(0xFF787878)))
                  ]
              )
          ),
        )

    );
  }

  void settingsOff(BuildContext context,String title,){
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
          shape: alertRadius,
          clipBehavior: Clip.antiAlias,
          child: Container(
              height:250,
              width:350,
              decoration:BoxDecoration(
                color:Colors.white,
              ),

              child:Column(
                  children:[
                    SizedBox(height:10),
                    SvgPicture.asset('assets/errors/error-icon.svg'),
                    SizedBox(height:30),
                    Text("Disabled",
                      style:TextStyle(fontFamily:'RM',fontSize:22,color:AppTheme.red),textAlign: TextAlign.center,
                    ),
                    SizedBox(height:10),
                    /*Text(des,
                        style:TextStyle(fontFamily:'RL',fontSize:18,color:Color(0xFF787878)),textAlign: TextAlign.center,
                    ),*/
                  ]
              )
          ),
        )

    );
  }

  void dynamicTableErrorAlert(BuildContext context,String img,String title,String des){
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
          shape: alertRadius,
          clipBehavior: Clip.antiAlias,
          child: Container(
              height:280,
              width:400,
              decoration:BoxDecoration(
                color:Colors.white,
              ),

              child:Padding(
                padding: const EdgeInsets.only(left:10,right: 10),
                child: Column(
                    children:[
                      SizedBox(height:10),
                      SvgPicture.asset(img),
                      // SizedBox(height:10),
                      Text(title,
                        style:TextStyle(fontFamily:'RM',fontSize:22,color:AppTheme.red),textAlign: TextAlign.center,
                      ),
                      SizedBox(height:15),
                      Text(des,
                        style:TextStyle(fontFamily:'RL',fontSize:18,color:Color(0xFF787878)),textAlign: TextAlign.center,
                      ),
                      SizedBox(height:10),
                    ]
                ),
              )
          ),
        )

    );
  }

  void yesOrNoDialog2(String img,String title,bool isSvg,
      {double imgHeight=50.0,EdgeInsets pad=const EdgeInsets.all(20),double hei=360,double textWidth=200}){
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (ctx) => Dialog(
          shape: alertRadius,
          clipBehavior: Clip.antiAlias,
          child: Container(
              height:hei,
              width:330,
              decoration:BoxDecoration(
                color:Colors.white,
              ),
              padding: pad,
              child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    //SizedBox(height:20),
                    // SvgPicture.asset(img),
                    isSvg?SvgPicture.asset(img,height: imgHeight,):Image.asset(img,height: imgHeight,),
                    SizedBox(height:30),
                    Container(
                      width: textWidth,
                      child: Text(title,
                        style:TextStyle(fontFamily:'RR',fontSize:23,color:Color(0xFF787878),letterSpacing: 0.5,
                            height: 1.5),textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height:30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        GestureDetector(
                          onTap:(){
                            Get.back();
                            cancelCallback!();
                          },
                          child: Container(
                            height: 50.0,
                            width: 280*0.4,
                            //margin: EdgeInsets.only(bottom: 0,top:20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFE4E4E4),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color:Color(0xFF808080).withOpacity(0.6),
                              //     offset: const Offset(0, 8.0),
                              //     blurRadius: 15.0,
                              //     // spreadRadius: 2.0,
                              //   ),
                              // ]
                            ),
                            child: Center(
                              child: Text("No",
                                style: TextStyle(fontFamily:'RR',color: Color(0xFF808080),fontSize: 16),
                              ),
                            ),
                          ),
                        ),



                        GestureDetector(
                          onTap:(){
                            Get.back();
                            callback!();
                          },
                          child: Container(
                            height: 50.0,
                            width: 280*0.4,
                            // margin: EdgeInsets.only(bottom: 0,top:20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppTheme.red,
                              // boxShadow: [
                              //   BoxShadow(
                              //     color:AppTheme.red.withOpacity(0.6),
                              //     offset: const Offset(0, 8.0),
                              //     blurRadius: 15.0,
                              //     // spreadRadius: 2.0,
                              //   ),
                              // ]
                            ),
                            child: Center(
                              child: Text("Yes",
                                style: TextStyle(fontFamily:'RR',color: Colors.white,fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),



                  ]
              )
          ),
        )

    );
  }
}
