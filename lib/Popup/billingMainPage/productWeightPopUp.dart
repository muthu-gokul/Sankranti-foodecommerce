import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:scutiwidgets/fittedText.dart';
import '../../notifier/appStateNotifier.dart';
import '../../styles/app_theme.dart';
import '../../styles/constants.dart';
import '../../utils/sizeLocal.dart';



class ProductWeightPopUp extends StatefulWidget {
  bool? isOpen;
  String? title;
  String? value;
  VoidCallback? onPercentageClick;
  VoidCallback? onAmountClick;
  VoidCallback? onClear;
  VoidCallback? onClearAll;
  Function(String)? numberTap;
  VoidCallback? onCancel;
  VoidCallback? onDone;
  bool isSevenInch;
  String unit;
  String subTotal;
  String price;
  ProductWeightPopUp({this.isOpen,this.title,this.value,this.onPercentageClick,this.onAmountClick,this.onClear,this.onClearAll,
    this.numberTap,this.onCancel,this.onDone,required this.isSevenInch,required this.unit,required this.subTotal,required this.price
  });
  @override
  _ProductWeightPopUpState createState() => _ProductWeightPopUpState();
}
class _ProductWeightPopUpState extends State<ProductWeightPopUp> {
  late double _width1;
  List<String> _numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "0", "X"];
  int selectedIndex=-1;

  @override
  void didUpdateWidget(covariant ProductWeightPopUp oldWidget) {
    if(!widget.isOpen!){
      setState(() {
        selectedIndex=-1;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _width1 = SizeConfig.screenWidth!;
    return Align(
      alignment: Alignment.center,
      child: AnimatedContainer(
        //height:500,
        width:_width1-20,
        duration: Duration(milliseconds:300),
        transform: Matrix4.translationValues(widget.isOpen!? 0:-550,0, 0),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:Colors.white,),
        clipBehavior: Clip.antiAlias,
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 50,
              margin: EdgeInsets.only(left: 5,right: 5,top: 15),
              decoration: BoxDecoration(
                color: Provider.of<AppStateNotifier>(context,listen:false).CustomerDetailsListContent,
                borderRadius: BorderRadius.circular(5),
              ),
              //  color:Color(0xFF6D6D6D),
              child: Stack(
                // alignment: Alignment.topCenter,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child:  Text("${widget.title}         ${widget.subTotal.isEmpty?"0.0":widget.subTotal}",
                          style: TextStyle(fontFamily:'RSB',color:Provider.of<AppStateNotifier>(context,listen:false).billingTextColor ,
                              fontSize: 16, letterSpacing: 0.5)
                      )
                  ),
                ],
              ),
            ),
            !widget.isOpen!?Container():
            Container(
                height:60,
                child:Stack(
                    children:[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(right: 70),
                          child: Text(widget.value!.isEmpty?"0.0":"${widget.value}",
                            style: TextStyle(fontFamily: 'RM',fontSize: 35,color:widget.value!.isEmpty? Color(0xFF5F5F5F).withOpacity(0.5):Color(0xFF5F5F5F)),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: !widget.isOpen!?Container(): AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                            height:35,
                            width:35,
                            margin: EdgeInsets.only(right:105),
                            decoration:BoxDecoration(
                                shape:BoxShape.circle,
                                // border:Border.all(color:widget.isPercentage!?Colors.transparent:Color(0xFF6D6D6D)),
                                color:AppTheme.red
                            ),
                            child:Center(child: FittedText(alignment: Alignment.center,text:widget.unit,textStyle:AppTheme.activeDisTS,height: 20,width: 40,))
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: !widget.isOpen!?Container(): Container(
                            margin: EdgeInsets.only(right:20),
                            child:Text("${widget.price}",style:TextStyle(fontFamily:'RSB',color:Provider.of<AppStateNotifier>(context,listen:false).billingTextColor ,
                                fontSize: 18, letterSpacing: 0.5))
                        ),
                      ),
                    ]
                )
            ),

            Container(
              // margin: EdgeInsets.only(top:10),
                //height: 310,
                child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    direction: Axis.horizontal,
                    children: _numbers
                        .asMap().map((i, element) => MapEntry(i,
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            if (_numbers[i] == 'X') {
                              selectedIndex=i;
                              widget.onClear!();
                            }
                            else if (_numbers[i] == 'C') {
                              selectedIndex=i;
                              widget.onClearAll!();
                            }
                            else {
                              selectedIndex=i;
                              widget.numberTap!(_numbers[i]);
                            }
                            setState((){});
                            Timer(animeDuration, (){
                              setState(() {
                                selectedIndex=-1;
                              });
                            });
                          },
                          child: AnimatedContainer(
                              duration: animeDuration,
                              curve: animeCurve,
                              height: 60,
                              width: SizeConfig.screenWidth!*0.28,
                              decoration: BoxDecoration(
                                  color: selectedIndex == i?Provider.of<AppStateNotifier>(context,listen:false).appBarColor:Colors.white,
                                  shape: BoxShape.circle
                              ),

                              child: Center(
                                  child: i==11?SvgPicture.asset("assets/icon/delete.svg",height: 30,
                                    color:selectedIndex == i?Colors.white: Provider.of<AppStateNotifier>(context,listen:false).tabTextColor,
                                  ):
                                  AnimatedCrossFade(
                                    crossFadeState: selectedIndex == i?CrossFadeState.showSecond:CrossFadeState.showFirst,
                                    duration: Duration(milliseconds: 300),
                                    reverseDuration: Duration(milliseconds: 600),
                                    firstChild: Text(_numbers[i],
                                      style: TextStyle(fontFamily: 'RR', color:Provider.of<AppStateNotifier>(context,listen:false).tabTextColor, fontSize: 28,),
                                      textAlign: TextAlign.center,
                                    ),
                                    secondChild: Text(_numbers[i],
                                      style: TextStyle(fontFamily: 'RR', color:Colors.white, fontSize: 28,),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                              )
                          ),

                        )
                    )
                    ).values.toList()
                )
            ),
            //Spacer(),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                GestureDetector(
                  onTap:(){
                    widget.onCancel!();
                  },
                  child: Container(
                    height: 50.0,
                    width: 140.0,
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
                    widget.onDone!();
                  },
                  child: Container(
                    height: 50.0,
                    width: 140.0,
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
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}