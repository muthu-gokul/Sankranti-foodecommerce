import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scutiwidgets/innerShadowLRContainer.dart';
import '../../notifier/Billing/cartNotifier.dart';
import '../../notifier/Billing/itemTapNotifier.dart';
import '../../notifier/appStateNotifier.dart';
import '../../notifier/billingItemEditPopUpNotifier.dart';
import '../../notifier/billingNotifier.dart';
import '../../notifier/utils.dart';
import '../../styles/app_theme.dart';
import 'package:provider/provider.dart';

import '../../styles/constants.dart';
import '../../styles/style.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/circle.dart';
import '../../widgets/expandedWidget.dart';

class BillingItemEdit extends StatefulWidget {

  BuildContext? scaffoldContext;
  VoidCallback? blurOff;
  VoidCallback? indexNull;
  int? billingitemeditindex;
  bool isSevenInch;
  bool isKotSentItemClick;
  BillingItemEdit({this.scaffoldContext,this.blurOff,this.billingitemeditindex,this.indexNull,required this.isSevenInch,this.isKotSentItemClick=false});
  @override
  _BillingItemEditState createState() => _BillingItemEditState();
}

class _BillingItemEditState extends State<BillingItemEdit> {

  late double _width1;
  double wid=400;
  ScrollController _scrollControllerBillingItemEdit=ScrollController();


  List<String> _numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "C", "0", "X"];
  late bool exists;
  bool isAddOpen=false;
  int selectedIndex=-1;
  var currentPageValue = 0.0;
  var currentQty = 0;
  var currentPageValue2 = 0.0;
  double bkPQty = 0.0;
  bool isDisUpdate=true;

  String customQty="";

  late PageController pageController,pageController2;
  @override
  void initState() {

    pageController=new PageController(viewportFraction: 0.24,initialPage: 0);
    pageController2=new PageController(viewportFraction: 0.24,initialPage: 0);
    pageController.addListener(() {
      setState(() {
        currentPageValue=pageController.page!;
        //currentQty=currentPageValue.toInt()+1;
      });
    });
    pageController2.addListener(() {
      setState(() {
        currentPageValue2=pageController2.page!;
      });
    });
    setState(() {
      currentPageValue2 = 0.0;
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {


    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant BillingItemEdit oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print("did update");
      if(widget.billingitemeditindex!=null && c_orderDetail.value!=null){
        currentQty=c_orderDetail.value!.productList![widget.billingitemeditindex!].quantity!.round();
        bkPQty=c_orderDetail.value!.productList![widget.billingitemeditindex!].quantity!;
        if(c_orderDetail.value!.productList![widget.billingitemeditindex!].isProductWeightEnable){
          _numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "0", "X"];
        }
        else{
          _numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "C", "0", "X"];
        }
        if((c_orderDetail.value!.productList![widget.billingitemeditindex!].quantity!-1)==0){
          try{
            pageController.jumpToPage(0);
          }
          catch(e){}
          setState(() {
            //pageController.jumpTo(0.0);
            currentPageValue=0.0;
            //isDisUpdate=false;
          });
        }
        else{
          int qty=c_orderDetail.value!.productList![widget.billingitemeditindex!].quantity!.round();
          try{
            pageController.jumpToPage(qty-1);
          }
          catch(e){}

          setState(() {
            currentPageValue=c_orderDetail.value!.productList![widget.billingitemeditindex!].quantity!-1;
            // isDisUpdate=false;
          });
        }
      }
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _width1 = SizeConfig.screenWidth!;
    wid = SizeConfig.screenWidth!-20;
    var bn=Provider.of<BillingNotifier>(context,listen: false);
    node=FocusScope.of(context);
    return  Consumer<BillingItemEditPopUpNotifier>(
      builder: (context,billingitemedit,child)=> Align(
        alignment: Alignment.center,
        child: AnimatedContainer(
            //height:isAddOpen?600:580,
            width:_width1-20,
            duration: Duration(milliseconds:300),
            transform: Matrix4.translationValues(billingitemedit.billingitemisclick? 0:-500,0, 0),
            curve: Curves.easeIn,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:Colors.white,),
            child:c_orderDetail.value==null?Container():
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<BillingNotifier>(
                  builder: (context,bn,child)=> Container(
                    height: 50,
                    // color:Color(0xFF6D6D6D),
                    child: Stack(
                      // alignment: Alignment.topCenter,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Align(
                            alignment: Alignment.center,
                            child: widget.isKotSentItemClick?
                            Text("",
                                style:TextStyle(color: Provider.of<AppStateNotifier>(context,listen:false).billingTextColor,fontSize: 18,)):

                            Text(widget.billingitemeditindex!=null?"${c_orderDetail.value!.productList![widget.billingitemeditindex!].productName}":"ItemName\n",
                                style:TextStyle(color: Provider.of<AppStateNotifier>(context,listen:false).billingTextColor,fontSize: 18,letterSpacing: 0.2)),

                          ),
                        ),
                        /*Align(
                          alignment: Alignment.bottomCenter,
                          child: widget.isKotSentItemClick?
                          Text("₹ ",
                              style:TextStyle(color: Provider.of<AppStateNotifier>(context,listen:false).billingCalculatedPriceColor,fontSize: 18,letterSpacing: 0.2)):

                          Text(widget.billingitemeditindex!=null?"₹ ":"ItemName\n",
                              style:TextStyle(color: Provider.of<AppStateNotifier>(context,listen:false).billingCalculatedPriceColor,fontSize: 18,letterSpacing: 0.2)),

                        ),*/

                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollControllerBillingItemEdit,
                  physics: NeverScrollableScrollPhysics(),
                  child: Row(
                    children: [
                      Consumer<BillingNotifier>(
                        builder: (context,bn,child)=>
                        widget.isKotSentItemClick?
                        Container(
                          width:wid,
                          height:isAddOpen? 520:490,
                          child: Column(
                            children: [
                              Text("Quantity",style: TextStyle(fontFamily:'RR',color: Provider.of<AppStateNotifier>(context,listen:false).appBarColor,fontSize: 20),),
                              Container(
                                margin: EdgeInsets.only(left:20,right:20,top:10),
                                child: Row(
                                  mainAxisAlignment:MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    InnerShadowLRContainer(
                                      height: 70,
                                      width: 280,
                                      color: Colors.white.withOpacity(0.7),
                                      child: Container(
                                          height: 70,
                                          width: 280,
                                          //color: Colors.red,
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Circle(hei: 100, color: Colors.red),
                                              ),
                                              PageView.builder(
                                                controller:pageController2,
                                                itemCount: 1,
                                                ///itemCount:bn.tableOrders[bn.billingTableOrderListIndex!].Repeatorders![0].quantity!>30?bn.tableOrders[bn.billingTableOrderListIndex!].Repeatorders![0].quantity: 30,
                                                itemBuilder: (ctx,position){
                                                  if (position == currentPageValue2.floor()) {
                                                    //setState(() {

                                                    if(!billingitemedit.isCustomQuantityClick && !isDisUpdate){
                                                    }
                                                    return Transform.scale(
                                                        scale: 1,
                                                        child: GestureDetector(
                                                          onTap: (){
                                                            billingitemedit.changeisCustomQuantityClick(true);
                                                            _scrollControllerBillingItemEdit.animateTo(
                                                                _scrollControllerBillingItemEdit.offset +wid,
                                                                duration: Duration(milliseconds: 300),
                                                                curve: Curves.easeIn);
                                                          },
                                                          child: AnimatedContainer(
                                                            duration: animeDuration,
                                                            height: 50,
                                                            width: 50,
                                                            alignment: Alignment.center,
                                                            decoration: BoxDecoration(
                                                                color: Colors.transparent,
                                                                shape: BoxShape.circle
                                                            ),

                                                            child: Text("${position+1}",
                                                              style: ts18(Colors.white,fontsize: 32),
                                                            ),
                                                          ),
                                                        )
                                                    );
                                                  }
                                                  else if (position == currentPageValue2.floor() + 1){
                                                    return Transform.scale(
                                                        scale: 0.6,
                                                        // alignment: Alignment.center,
                                                        // transform: Matrix4.identity()..setEntry(3, 2, 0.001)
                                                        //   ..rotateX(currentPageValue - position)
                                                        //   ..rotateY(currentPageValue - position)
                                                        //   ..rotateZ(currentPageValue - position),
                                                        child:  AnimatedContainer(
                                                          duration: animeDuration,
                                                          height: 50,
                                                          width: 50,
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                            //    color:  Colors.blue,
                                                              shape: BoxShape.circle
                                                          ),

                                                          child: Text("${position+1}",
                                                            style: ts18(Provider.of<AppStateNotifier>(context,listen:false).billingCalculatedPriceColor,fontsize: 30),
                                                          ),
                                                        )
                                                    );
                                                  }
                                                  else {
                                                    return Transform.scale(
                                                      scale: 0.6,
                                                      child: AnimatedContainer(
                                                        duration: animeDuration,
                                                        height: 50,
                                                        width: 50,
                                                        alignment: Alignment.center,
                                                        decoration: BoxDecoration(
                                                          //color: Colors.green,
                                                            shape: BoxShape.circle
                                                        ),

                                                        child: Text("${position+1}",
                                                          style: ts18(Provider.of<AppStateNotifier>(context,listen:false).billingCalculatedPriceColor,fontsize: 30),
                                                        ),
                                                      ),
                                                    );
                                                  }

                                                },
                                                onPageChanged: (i){
                                                  // setState(() {
                                                  //   currentPageValue=i;
                                                  // });
                                                  // print(i);
                                                },
                                              ),
                                            ],
                                          )

                                      ),
                                    ),

                                  ],
                                ),
                              ),

                              SizedBox(height: 15,),

                              /* bn.iconSelected==0? container1(
                                  "Position",
                                      () {
                                    billingitemedit.changeTablePositionClickTrue();
                                  },
                                  bn.tableOrders[bn.billingTableOrderListIndex!].RepeattableSeats!.where((element) => element.ProductId==bn.tableOrders[bn.billingTableOrderListIndex!].Repeatorders![0].ProductId).toList().length==0,
                                  bn.tableOrders[bn.billingTableOrderListIndex!].RepeattableSeats!.where((element) => element.ProductId==bn.tableOrders[bn.billingTableOrderListIndex!].Repeatorders![0].ProductId).toList().length>0?
                                  bn.tableOrders[bn.billingTableOrderListIndex!].RepeattableSeats!.where((element) => element.ProductId==bn.tableOrders[bn.billingTableOrderListIndex!].Repeatorders![0].ProductId).toList()[0].SeatNumber:""
                              )
                                  :Container(),*/

                              SizedBox(height: 20,),
                              container1(
                                  "Addons",
                                      () {
                                    billingitemedit.changeisAddonsClickTrue();
                                  },
                                  true,
                                  ""
                              ),
                              SizedBox(height: 20,),
                              container1(
                                  "Kitchen Comments",
                                      () {
                                    billingitemedit.changeisKitchenCommentsClickTrue();
                                  },
                                  true,
                                  ""
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding:  EdgeInsets.only(right: 10),
                                  child: IconButton(onPressed: (){
                                    setState(() {
                                      isAddOpen=!isAddOpen;
                                    });
                                  },
                                      icon: Icon(Icons.notes,
                                        color: Provider.of<AppStateNotifier>(context,listen:false).appBarColor,
                                        size: 30,
                                      )
                                  ),
                                ),
                              ),
                              SizedBox(height: 5,),
                              /*ExpandedSection(
                                expand: isAddOpen,
                                child: Container(
                                  height: 80,
                                  width: double.infinity,
                                  margin: EdgeInsets.only(left:20,right:20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border:Border.all(color:Colors.grey[300]!),
                                    color:Provider.of<AppStateNotifier>(context,listen:false).CustomerDetailsListContent.withOpacity(0.6),
                                  ),
                                  child:  TextFormField(
                                      style:ts16(Provider.of<AppStateNotifier>(context,listen:false).billingTextColor),
                                      controller: bn.tableOrders[bn.billingTableOrderListIndex!].Repeatorders![0].notesController,

                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: "Add Notes",
                                        hintStyle:ts16(Provider.of<AppStateNotifier>(context,listen:false).billingTextColor.withOpacity(0.5)),
                                        contentPadding: EdgeInsets.only(left: 20,),
                                      ),
                                      onChanged:(v){

                                      }

                                  ),
                                ),
                              ),*/
                              Spacer(),
                              yesNo(
                                    (){
                                },
                                    () async {

                                  setState(() {
                                    currentPageValue2 = 0.0;
                                  });
                                },
                                noo: "Cancel",
                                yess: "Repeat",
                              ),
                            ],
                          ),
                        ):

                        ///////////////////// ---------------------------Before Kot  -------------------///////////////////
                        c_orderDetail.value!=null && widget.billingitemeditindex!=null?
                        Container(
                          width:wid,
                          // height: isAddOpen?490:430,
                       //   height:isAddOpen? 520:490,
                          //  height: 520,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Quantity",style: TextStyle(fontFamily:'RR',color: Provider.of<AppStateNotifier>(context,listen:false).appBarColor,fontSize: 18),),
                              Container(
                                margin: EdgeInsets.only(left:5,right:5,top:10),
                                child: Row(
                                  mainAxisAlignment:MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //  SizedBox(width: 10,),
                                    c_orderDetail.value!.productList![widget.billingitemeditindex!].isProductWeightEnable?GestureDetector(
                                      onTap:(){
                                        setState((){
                                          customQty=(bkPQty).toString();
                                        });
                                        billingitemedit.changeisCustomQuantityClick(true);
                                        _scrollControllerBillingItemEdit.animateTo(_scrollControllerBillingItemEdit.offset +wid, duration: Duration(milliseconds: 300),curve: Curves.easeIn);
                                      },
                                      child: Circle(hei: 80, color: Colors.red,widget: Center(
                                        child: Text("$bkPQty",style: ts18(Colors.white,fontsize: (bkPQty).toString().length>3?25: 32)),
                                      ),),
                                    ):
                                    InnerShadowLRContainer(
                                      height: 60,
                                      width: wid-20,
                                      color: Colors.white.withOpacity(0.7),
                                      child: Container(
                                          height: 60,
                                          width: wid-20,
                                          //color: Colors.red,
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Circle(hei: 80, color: Colors.red,),
                                              ),
                                              PageView.builder(
                                                controller:pageController,
                                                // controller:PageController(viewportFraction: 0.24),
                                                itemCount: currentQty>30?(currentQty):30,
                                                //itemCount: c_orderDetail.value!.productList![widget.billingitemeditindex!].quantity!>500?(c_orderDetail.value!.productList![widget.billingitemeditindex!].quantity!.round()):500,
                                                itemBuilder: (ctx,position){
                                                  if (position == currentPageValue.floor()) {
                                                    //setState(() {
                                                    if(!billingitemedit.isCustomQuantityClick && !isDisUpdate){
                                                      //print("ISDISUODATE $isDisUpdate");
                                                    }
                                                    // });
                                                    return Transform.scale(
                                                        scale: 1,

                                                        child: GestureDetector(
                                                          onTap: (){
                                                            setState((){
                                                              customQty=(position+1).toString();
                                                            });
                                                            billingitemedit.changeisCustomQuantityClick(true);
                                                            _scrollControllerBillingItemEdit.animateTo(
                                                                _scrollControllerBillingItemEdit.offset +wid,
                                                                duration: Duration(milliseconds: 300),
                                                                curve: Curves.easeIn);
                                                          },
                                                          child: AnimatedContainer(
                                                            duration: animeDuration,
                                                            height: 50,
                                                            width: 50,
                                                            alignment: Alignment.center,
                                                            decoration: BoxDecoration(
                                                                color: Colors.transparent,
                                                                shape: BoxShape.circle
                                                            ),

                                                            child: Text("${position+1}",
                                                              style: ts18(Colors.white,fontsize: (position+1).toString().length>3?25: 32),
                                                            ),
                                                          ),
                                                        )
                                                    );
                                                  }
                                                  else if (position == currentPageValue.floor() + 1){
                                                    return Transform.scale(
                                                        scale: 0.7,
                                                        child:  AnimatedContainer(
                                                          duration: animeDuration,
                                                          height: 50,
                                                          width: 50,
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                            //   color:  Colors.blue,
                                                              shape: BoxShape.circle
                                                          ),

                                                          child: Text("${position+1}",
                                                            style: ts18(Provider.of<AppStateNotifier>(context,listen:false).billingCalculatedPriceColor,fontsize:(position+1).toString().length>3?25: 30),
                                                          ),
                                                        )
                                                    );
                                                  }
                                                  else {
                                                    return Transform.scale(
                                                      scale: 0.7,
                                                      child: AnimatedContainer(
                                                        duration: animeDuration,
                                                        height: 50,
                                                        width: 50,
                                                        alignment: Alignment.center,
                                                        decoration: BoxDecoration(
                                                          //color: Colors.green,
                                                            shape: BoxShape.circle
                                                        ),

                                                        child: Text("${position+1}",
                                                          style: ts18(Provider.of<AppStateNotifier>(context,listen:false).billingCalculatedPriceColor,fontsize:(position+1).toString().length>3?25: 30),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                                onPageChanged: (i){},
                                              ),
                                            ],
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),


                              /*c_OrderTypeId.value==DINEIN_ID? container1(
                                  "Position",
                                      () {
                                    billingitemedit.changeTablePositionClickTrue();
                                  },
                                  true,""
                              )
                                  :Container(),
                              SizedBox(height: 20,),*/
                              container1(
                                  "Addons",
                                      () {
                                    billingitemedit.changeisAddonsClickTrue();
                                  },
                                  true,""
                              ),

                              SizedBox(height: 20,),
                              container1(
                                  "Kitchen Comments",
                                      () {
                                    billingitemedit.changeisKitchenCommentsClickTrue();
                                  },
                                  true,""
                              ),


                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding:  EdgeInsets.only(right: 10),
                                  child: IconButton(onPressed: (){
                                    setState(() {
                                      isAddOpen=!isAddOpen;
                                    });
                                  },
                                      icon: Icon(Icons.notes,
                                        color: Provider.of<AppStateNotifier>(context,listen:false).appBarColor,
                                        size: 30,
                                      )
                                  ),
                                ),
                              ),
                              ExpandedSection(
                                expand: isAddOpen,
                                child: AnimatedContainer(
                                  duration: animeDuration,
                                  height: 80,
                                  width: double.infinity,
                                  clipBehavior: Clip.antiAlias,
                                  margin: EdgeInsets.only(left:20,right:20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border:Border.all(color:Colors.grey[300]!),
                                    color:Provider.of<AppStateNotifier>(context,listen:false).CustomerDetailsListContent.withOpacity(0.6),
                                  ),
                                  child:  TextFormField(
                                      style:ts16(Provider.of<AppStateNotifier>(context,listen:false).billingTextColor),
                                      controller: productNotes,
                                      textInputAction:TextInputAction.done,
                                      maxLines: 4,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: "Add Notes",
                                        hintStyle:ts16(Provider.of<AppStateNotifier>(context,listen:false).billingTextColor.withOpacity(0.5)),
                                        contentPadding: EdgeInsets.only(left: 20,top: 10),

                                      ),
                                      onChanged:(v){

                                      }
                                  ),
                                ),
                              ),

                              SizedBox(height: 20,),
                              yesNo((){
                                billingitemedit.changePopUpStatus();
                                widget.blurOff!();
                                cancelChangesInOTP();
                              },
                              (){
                                    //bn.updatedoneCancelBtnClick(true);
                                    billingitemedit.changePopUpStatus();
                                    widget.blurOff!();
                                    acceptChangesInOTP();
                                    if(c_orderDetail.value!.productList![widget.billingitemeditindex!].isProductWeightEnable){
                                      c_orderDetail.value!.updateProductQty(c_orderDetail.value!.productList![widget.billingitemeditindex!].productId, bkPQty);
                                    }
                                    else{
                                      c_orderDetail.value!.updateProductQty(c_orderDetail.value!.productList![widget.billingitemeditindex!].productId, pageController.page!+1.0);
                                    }
                                    c_orderDetail.refresh();
                                    Timer(Duration(milliseconds: 300), (){
                                      Timer(Duration(milliseconds: 100), (){
                                        widget.billingitemeditindex=null;
                                        widget.indexNull!();
                                        //bn.clearIEPB();
                                        if(widget.isKotSentItemClick){
                                          ///bn.updateKotSentItemClick();
                                        }
                                      });
                                    });
                                  }
                              ),
                             // Spacer(),
                              SizedBox(height: 20,),
                            ],
                          ),
                        ) :Container(),
                      ),




                      billingitemedit.isCustomQuantityClick? Consumer<BillingNotifier>(
                        builder: (context,bn,child)=> Container(
                            width:wid,
                           // height:isAddOpen? 520:490,
                            //height:470,
                            child:Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  // margin: EdgeInsets.only(top: 10),
                                  height: 50,
                                  width: wid,

                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(customQty.isEmpty?"Enter Quantity":customQty,
                                          style: customQty.isEmpty?TextStyle(fontFamily: 'RL',fontSize: 25,color: Color(0xFF5F5F5F).withOpacity(0.7)):
                                          TextStyle(fontFamily: 'RM',fontSize: 35,color: Color(0xFF5F5F5F)),
                                        ),
                                      ),
                                    ],
                                  ),

                                ),

                                Container(
                                  // margin: EdgeInsets.only(top: 10),
                                    child: Wrap(
                                        spacing: 5,
                                        runSpacing: 5,
                                        direction: Axis.horizontal,
                                        children: _numbers
                                            .asMap().map((i, element) => MapEntry(i,
                                            GestureDetector(
                                              onTap: () {
                                                // Nocontroller.forward().whenComplete(() => Nocontroller.reverse());
                                                setState(() {
                                                  selectedIndex=i;
                                                  if (_numbers[i] == 'X') {
                                                    if(customQty.isNotEmpty){
                                                      setState(() {
                                                        customQty = customQty.substring(0, customQty.length - 1);
                                                      });
                                                    }
                                                  }
                                                  else if (_numbers[i] == 'C') {
                                                    setState((){
                                                      customQty="";
                                                    });
                                                  }
                                                  else if (_numbers[i] == '.') {
                                                    setState((){
                                                      String disVal = customQty;
                                                      if (!disVal.contains('.')) {
                                                        if (disVal.length < 6) {
                                                          disVal += _numbers[i];
                                                          customQty=(disVal);
                                                        }
                                                      }
                                                    });
                                                  }
                                                  else {

                                                    if(customQty.length<(c_orderDetail.value!.productList![widget.billingitemeditindex!].isProductWeightEnable?6:4)){
                                                      if(customQty.isEmpty && element=="0"){
                                                        return;
                                                      }
                                                      else{
                                                        customQty=customQty+element;
                                                      }
                                                    }
                                                  }
                                                });
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
                                yesNo(
                                        () {
                                      billingitemedit.changeisCustomQuantityClick(false);
                                      _scrollControllerBillingItemEdit.animateTo(
                                          _scrollControllerBillingItemEdit.offset -wid,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeIn);

                                    },
                                        () {
                                      billingitemedit.changeisCustomQuantityClick(false);
                                      _scrollControllerBillingItemEdit.animateTo(
                                          _scrollControllerBillingItemEdit.offset -wid,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeIn);
                                      if(c_orderDetail.value!.productList![widget.billingitemeditindex!].isProductWeightEnable){
                                        setState((){
                                          bkPQty=parseDouble(customQty);
                                        });
                                      }
                                      else{
                                        if(customQty.isNotEmpty){
                                          if(int.parse(customQty)>30){
                                            setState((){
                                              currentQty=int.parse(customQty);
                                            });
                                            pageController.jumpToPage(currentQty-1);
                                          }
                                          else{
                                            pageController.jumpToPage(int.parse(customQty)-1);
                                          }
                                          setState((){
                                            currentPageValue=parseDouble((int.parse(customQty)-1).toString());
                                          });

                                          print("currentPageValue $currentQty");
                                          /*Timer(Duration(milliseconds: 800), () {
                                              print("currentQty $currentQty");
                                              pageController.jumpTo(20.0);
                                            });*/
                                        }
                                        else{
                                          pageController.jumpToPage(0);
                                          setState((){
                                            currentPageValue=0.0;
                                          });
                                        }
                                      }


                                    }
                                ),
                                SizedBox(height: 20,),
                                //Spacer(),


                              ],
                            )


                        ),
                      ):Container(),

                      billingitemedit.isKitchenCommentsClick? Consumer<BillingNotifier>(
                        builder: (context,bn,child)=> Container(
                            width:wid,
                            child:Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(left:10,right:10,top:20),
                                    height: 340,
                                    constraints: BoxConstraints(
                                        maxHeight: SizeConfig.screenHeight!*0.5
                                    ),
                                    child: SingleChildScrollView(
                                      child: widget.isKotSentItemClick?Obx(()=>Wrap(
                                          spacing: 10,
                                          runSpacing: 10,
                                          children: addonsList
                                              .asMap().map((i, element) => MapEntry(i,
                                              GestureDetector(
                                                behavior: HitTestBehavior.translucent,
                                                onTap: () {
                                                  /*exists=bn.tableOrders[bn.billingTableOrderListIndex!].Repeataddons!.any((element) => element.ProductId==bn.tableOrders[bn.billingTableOrderListIndex!].Totalorders![bn.kotDeleteIndex!].Totalorder![bn.kotDeleteItemIndex!].ProductId && element.AddonId==bn.filterAddons![i].AddonId );

                                                    setState(() {


                                                      if(exists){
                                                        int index=bn.tableOrders[bn.billingTableOrderListIndex!].Repeataddons!.indexWhere((element) => element.ProductId == bn.tableOrders[bn.billingTableOrderListIndex!].Totalorders![bn.kotDeleteIndex!].Totalorder![bn.kotDeleteItemIndex!].ProductId && element.AddonId==bn.filterAddons![i].AddonId );

                                                        bn.tableOrders[bn.billingTableOrderListIndex!].Repeataddons!.removeAt(index);



                                                      }
                                                      else{
                                                        bn.tableOrders[bn.billingTableOrderListIndex!].Repeataddons!.add(AddOns(
                                                            AddonId: bn.filterAddons![i].AddonId,
                                                            AddOnName: bn.filterAddons![i].AddOnName,
                                                            ProductId: bn.tableOrders[bn.billingTableOrderListIndex!].Totalorders![bn.kotDeleteIndex!].Totalorder![bn.kotDeleteItemIndex!].ProductId
                                                        ));


                                                      }
                                                    });*/
                                                },
                                                child: Container(
                                                    height:60,
                                                    width:170,
                                                    decoration: BoxDecoration(
                                                      /* color:bn.tableOrders[bn.billingTableOrderListIndex!].Repeataddons!.isEmpty?Colors.grey[200]:
                                                        bn.tableOrders[bn.billingTableOrderListIndex!].Repeataddons!.any((element) => element.ProductId==bn.tableOrders[bn.billingTableOrderListIndex!].Totalorders![bn.kotDeleteIndex!].Totalorder![bn.kotDeleteItemIndex!].ProductId && element.AddonId==bn.filterAddons![i].AddonId )?
                                                        AppTheme.red:Colors.grey[200],*/
                                                      borderRadius: BorderRadius.circular(10),
                                                      //border:Border.all(color:bn.tableOrders[bn.billingTableOrderListIndex!].Repeataddons!.any((element) => element.ProductId==bn.tableOrders[bn.billingTableOrderListIndex!].Totalorders![bn.kotDeleteIndex!].Totalorder![bn.kotDeleteItemIndex!].ProductId && element.AddonId==bn.filterAddons![i].AddonId )?Colors.transparent: Color(0xFFcbcbcb)),
                                                    ),
                                                    child: Center(
                                                        child: Text("${element.AddOnName}",
                                                            style:TextStyle(fontFamily:'RR',fontSize:16,
                                                              //color:bn.tableOrders[bn.billingTableOrderListIndex!].Repeataddons!.any((element) => element.ProductId==bn.tableOrders[bn.billingTableOrderListIndex!].Totalorders![bn.kotDeleteIndex!].Totalorder![bn.kotDeleteItemIndex!].ProductId && element.AddonId==bn.filterAddons![i].AddonId )?Colors.white:Color(0xFF6D6D6D)
                                                            )

                                                        )
                                                    )
                                                ),
                                              )))
                                              .values
                                              .toList()
                                      ),
                                      ):
                                      Obx(()=>Wrap(
                                          spacing: 10,
                                          runSpacing: 10,
                                          children:kitchenCommentsList
                                              .asMap().map((i, element) => MapEntry(i,
                                              GestureDetector(
                                                behavior: HitTestBehavior.translucent,
                                                onTap: () {
                                                  exists=c_orderDetail.value!.addOnCommentsList!.any((f) => f.orderProductId==c_orderDetail.value!.productList![widget.billingitemeditindex!].productId && f.commentId==element.commentId && f.kOTId==null);
                                                  activeAddonById(element,element.commentId,!exists,hasPrice: false);
                                                },
                                                child: Container(
                                                    height:50,
                                                    width: (wid-20)*0.45,
                                                    decoration: BoxDecoration(
                                                      color:c_orderDetail.value!.addOnCommentsList!.isEmpty?Colors.grey[200]:
                                                      c_orderDetail.value!.addOnCommentsList!.any((f) => f.orderProductId==c_orderDetail.value!.productList![widget.billingitemeditindex!].productId && f.commentId==element.commentId && f.kOTId==null)?
                                                      AppTheme.red:Colors.grey[200],
                                                      borderRadius: BorderRadius.circular(10),
                                                      border:Border.all(color:c_orderDetail.value!.addOnCommentsList!.any((f) => f.orderProductId==c_orderDetail.value!.productList![widget.billingitemeditindex!].productId && f.commentId==element.commentId && f.kOTId==null)?Colors.transparent: Color(0xFFcbcbcb)),
                                                    ),
                                                    child: Center(
                                                        child: Text("${element.AddOnName}",
                                                            style:TextStyle(fontFamily:'RR',fontSize:16,
                                                                color:c_orderDetail.value!.addOnCommentsList!.any((f) => f.orderProductId==c_orderDetail.value!.productList![widget.billingitemeditindex!].productId && f.commentId==element.commentId && f.kOTId==null)?Colors.white:Color(0xFF6D6D6D)
                                                            )
                                                        )
                                                    )
                                                ),
                                              )))
                                              .values
                                              .toList()
                                      ),
                                      ),
                                    )

                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: (){

                                    _scrollControllerBillingItemEdit.animateTo(
                                        _scrollControllerBillingItemEdit.offset -wid,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeIn).then((value) {
                                      billingitemedit.changeisKitchenCommentsClick();
                                    });
                                  },
                                  child: Container(
                                    height: 50.0,
                                    width: 180.0,
                                    margin: EdgeInsets.only(top: 20,bottom: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppTheme.red,
                                        boxShadow: [
                                          BoxShadow(
                                            color:AppTheme.red.withOpacity(0.6),
                                            offset: const Offset(0, 8.0),
                                            blurRadius: 15.0,
                                            // spreadRadius: 2.0,
                                          ),
                                        ]
                                    ),
                                    child: Center(
                                      child: Text("Done",
                                        style: TextStyle(fontFamily:'RR',color: Colors.white,fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            )


                        ),
                      ):Container(),

                      billingitemedit.isAddonsClick? Consumer<BillingNotifier>(
                        builder: (context,bn,child)=> Container(
                            width:wid,
                            child:Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(left:10,right:10,top:20),
                                    height: 340,
                                    constraints: BoxConstraints(
                                      maxHeight: SizeConfig.screenHeight!*0.5
                                    ),
                                    child: SingleChildScrollView(
                                      child: widget.isKotSentItemClick?Obx(()=>Wrap(
                                          spacing: 10,
                                          runSpacing: 10,
                                          children: addonsList
                                              .asMap().map((i, element) => MapEntry(i,
                                              GestureDetector(
                                                behavior: HitTestBehavior.translucent,
                                                onTap: () {
                                                  /*exists=bn.tableOrders[bn.billingTableOrderListIndex!].Repeataddons!.any((element) => element.ProductId==bn.tableOrders[bn.billingTableOrderListIndex!].Totalorders![bn.kotDeleteIndex!].Totalorder![bn.kotDeleteItemIndex!].ProductId && element.AddonId==bn.filterAddons![i].AddonId );

                                                    setState(() {


                                                      if(exists){
                                                        int index=bn.tableOrders[bn.billingTableOrderListIndex!].Repeataddons!.indexWhere((element) => element.ProductId == bn.tableOrders[bn.billingTableOrderListIndex!].Totalorders![bn.kotDeleteIndex!].Totalorder![bn.kotDeleteItemIndex!].ProductId && element.AddonId==bn.filterAddons![i].AddonId );

                                                        bn.tableOrders[bn.billingTableOrderListIndex!].Repeataddons!.removeAt(index);



                                                      }
                                                      else{
                                                        bn.tableOrders[bn.billingTableOrderListIndex!].Repeataddons!.add(AddOns(
                                                            AddonId: bn.filterAddons![i].AddonId,
                                                            AddOnName: bn.filterAddons![i].AddOnName,
                                                            ProductId: bn.tableOrders[bn.billingTableOrderListIndex!].Totalorders![bn.kotDeleteIndex!].Totalorder![bn.kotDeleteItemIndex!].ProductId
                                                        ));


                                                      }
                                                    });*/
                                                },
                                                child: Container(
                                                    height:60,
                                                    width:170,
                                                    decoration: BoxDecoration(
                                                      /* color:bn.tableOrders[bn.billingTableOrderListIndex!].Repeataddons!.isEmpty?Colors.grey[200]:
                                                        bn.tableOrders[bn.billingTableOrderListIndex!].Repeataddons!.any((element) => element.ProductId==bn.tableOrders[bn.billingTableOrderListIndex!].Totalorders![bn.kotDeleteIndex!].Totalorder![bn.kotDeleteItemIndex!].ProductId && element.AddonId==bn.filterAddons![i].AddonId )?
                                                        AppTheme.red:Colors.grey[200],*/
                                                      borderRadius: BorderRadius.circular(10),
                                                      //border:Border.all(color:bn.tableOrders[bn.billingTableOrderListIndex!].Repeataddons!.any((element) => element.ProductId==bn.tableOrders[bn.billingTableOrderListIndex!].Totalorders![bn.kotDeleteIndex!].Totalorder![bn.kotDeleteItemIndex!].ProductId && element.AddonId==bn.filterAddons![i].AddonId )?Colors.transparent: Color(0xFFcbcbcb)),
                                                    ),
                                                    child: Center(
                                                        child: Text("${element.AddOnName}",
                                                            style:TextStyle(fontFamily:'RR',fontSize:16,
                                                              //color:bn.tableOrders[bn.billingTableOrderListIndex!].Repeataddons!.any((element) => element.ProductId==bn.tableOrders[bn.billingTableOrderListIndex!].Totalorders![bn.kotDeleteIndex!].Totalorder![bn.kotDeleteItemIndex!].ProductId && element.AddonId==bn.filterAddons![i].AddonId )?Colors.white:Color(0xFF6D6D6D)
                                                            )

                                                        )
                                                    )
                                                ),
                                              )))
                                              .values
                                              .toList()
                                      ),
                                      ):
                                      Obx(()=>Wrap(
                                          spacing: 10,
                                          runSpacing: 10,
                                          children:addonsList
                                              .asMap().map((i, element) => MapEntry(i,
                                              GestureDetector(
                                                behavior: HitTestBehavior.translucent,
                                                onTap: () {
                                                  exists=c_orderDetail.value!.addOnCommentsList!.any((f) => f.orderProductId==c_orderDetail.value!.productList![widget.billingitemeditindex!].productId && f.addonId==element.addonId && f.kOTId==null);
                                                  activeAddonById(element,element.addonId,!exists,hasPrice: true);
                                                },
                                                child: Container(
                                                    height:50,
                                                    width: (wid-20)*0.45,
                                                    decoration: BoxDecoration(
                                                      color:c_orderDetail.value!.addOnCommentsList!.isEmpty?Colors.grey[200]:
                                                      c_orderDetail.value!.addOnCommentsList!.any((f) => f.orderProductId==c_orderDetail.value!.productList![widget.billingitemeditindex!].productId && f.addonId==element.addonId && f.kOTId==null)?
                                                      AppTheme.red:Colors.grey[200],
                                                      borderRadius: BorderRadius.circular(10),
                                                      border:Border.all(color:c_orderDetail.value!.addOnCommentsList!.any((f) => f.orderProductId==c_orderDetail.value!.productList![widget.billingitemeditindex!].productId && f.addonId==element.addonId&& f.kOTId==null)?Colors.transparent: Color(0xFFcbcbcb)),
                                                    ),
                                                    child: Center(
                                                        child: Text("${element.AddOnName}",
                                                            style:TextStyle(fontFamily:'RR',fontSize:16,
                                                                color:c_orderDetail.value!.addOnCommentsList!.any((f) => f.orderProductId==c_orderDetail.value!.productList![widget.billingitemeditindex!].productId && f.addonId==element.addonId && f.kOTId==null)?Colors.white:Color(0xFF6D6D6D)
                                                            )
                                                        )
                                                    )
                                                ),
                                              )))
                                              .values
                                              .toList()
                                      ),
                                      ),
                                    )

                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: (){

                                    _scrollControllerBillingItemEdit.animateTo(
                                        _scrollControllerBillingItemEdit.offset -wid,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeIn).then((value) {

                                      billingitemedit.changeisAddonsClickFalse();
                                    });
                                  },
                                  child: Container(
                                    height: 50.0,
                                    width: 180.0,
                                    margin: EdgeInsets.only(top: 20,bottom: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppTheme.red,
                                        boxShadow: [
                                          BoxShadow(
                                            color:AppTheme.red.withOpacity(0.6),
                                            offset: const Offset(0, 8.0),
                                            blurRadius: 15.0,
                                            // spreadRadius: 2.0,
                                          ),
                                        ]
                                    ),
                                    child: Center(
                                      child: Text("Done",
                                        style: TextStyle(fontFamily:'RR',color: Colors.white,fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            )


                        ),
                      ):Container(),

                    ],
                  ),
                ),
              ],
            )

        ),
      ),
    );
  }

  container1(String title,VoidCallback ontap,bool isOptional,dynamic value,) {
    return Container(
      height: 50,
      width: 450,
      padding: EdgeInsets.only(left: 10, right: 10),
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.grey[300]!),
        color: Provider
            .of<AppStateNotifier>(context, listen: false)
            .CustomerDetailsListContent
            .withOpacity(0.6),
      ),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(title, style: ts16(Provider
                  .of<AppStateNotifier>(context, listen: false)
                  .billingTextColor
                  .withOpacity(0.95)))
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              ontap();
              _scrollControllerBillingItemEdit.animateTo(
                  _scrollControllerBillingItemEdit.offset + wid,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn);
            },
            child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                    width: 200,
                    child: Row(
                      children: [
                        Spacer(),
                        isOptional ?
                        Text("Optional", style: ts16(Provider
                            .of<AppStateNotifier>(context, listen: false)
                            .appBarColor)) :
                        Text("$value...", style: ts16(Provider
                            .of<AppStateNotifier>(context, listen: false)
                            .billingTextColor
                            .withOpacity(0.95))),
                        SizedBox(width: 15),

                        SvgPicture.asset("assets/icon/optionalicon.svg")
                      ],
                    )
                )
            ),
          ),
        ],
      ),
    );
  }
}
yesNo(VoidCallback? no,VoidCallback? yes,{String noo="No",String yess="Yes"}){
  return Row(
    children: [
      Spacer(),
      GestureDetector(
        onTap:no,
        child: Container(
          height: 50.0,
          width: SizeConfig.screenWidth!*0.4,
          //margin: EdgeInsets.only(bottom: 0,top:20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFE4E4E4),
          ),
          child: Center(
            child: Text("$noo",
              style: TextStyle(fontFamily:'RR',color: Color(0xFF808080),fontSize: 18),
            ),
          ),
        ),
      ),
      SizedBox(width: 20,),
      GestureDetector(
        onTap:yes,
        child: Container(
          height: 50.0,
          width: SizeConfig.screenWidth!*0.4,
          // margin: EdgeInsets.only(bottom: 0,top:20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppTheme.red,
          ),
          child: Center(
            child: Text("$yess",
              style: TextStyle(fontFamily:'RM',color: Colors.white,fontSize: 18),
            ),
          ),
        ),
      ),
      Spacer(),
    ],
  );
}