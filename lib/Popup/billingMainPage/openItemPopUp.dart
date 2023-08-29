
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../notifier/billingItemEditPopUpNotifier.dart';
import '../../notifier/billingNotifier.dart';
import '../../styles/app_theme.dart';

import 'package:provider/provider.dart';

import '../../utils/sizeLocal.dart';


class OpenItemPopUp extends StatefulWidget {

  BuildContext? scaffoldContext;
  bool? isOpenItemOpen;
  VoidCallback? closeTap;
  VoidCallback? indexNull;
  List<dynamic>? categoryList;

  OpenItemPopUp({this.scaffoldContext,this.closeTap,this.isOpenItemOpen,this.indexNull,this.categoryList});
  @override
  _OpenItemPopUpState createState() => _OpenItemPopUpState();
}

class _OpenItemPopUpState extends State<OpenItemPopUp> with TickerProviderStateMixin{

  double? _width1,leftPadding=20,width2=400;
  ScrollController _scrollControllerBillingItemEdit=ScrollController();

  bool isScroll=false;


  List<String> _numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "C", "0", "X"];
  bool? exists;
  bool doneCancelBtnClick=false;
  String? selectedStation=null;
  String? selectedCategory=null;
  int? selectedStationId;
  int? selectedCategoryId;
  int? selectedTaxId;
  String? selectedTaxValue;


  bool itemName=false;
  bool itemPrice=false;
  bool station=false;
  bool category=false;
  bool overAllPrice=false;
  bool _keyboardVisible = false;

  bool? nameFocus,priceFocus=false;

  TextEditingController name=new TextEditingController();
  TextEditingController price=new TextEditingController();
  TextEditingController dineInPrice=new TextEditingController();
  TextEditingController takeAwayPrice=new TextEditingController();
  TextEditingController homeDeliveryPrice=new TextEditingController();
  TextEditingController quickServicePrice=new TextEditingController();
  TextEditingController gst=new TextEditingController();


  TabController? tabController ;
  List<String> orderType=["DineIn","TakeAway","H-Delivery","Q-Service"];
  List<String> iconsList=['tableservice','takeaway','delivery','quickservice'];
  int selectedOrderType=-1;

  bool? isMultiPrice=false;

  @override
  void didUpdateWidget(covariant OpenItemPopUp oldWidget) {

    if(!widget.isOpenItemOpen!){
      setState(() {
        doneCancelBtnClick=false;
        selectedStation=null;
        selectedCategory=null;
        selectedTaxId=null;
        selectedTaxValue=null;
        itemName=false;
        itemPrice=false;
        station=false;
        category=false;
        isMultiPrice=false;
        overAllPrice=false;
        nameFocus=false;
        priceFocus=false;
        selectedOrderType=-1;
      });
      name.clear();
      price.clear();
      dineInPrice.clear();
      takeAwayPrice.clear();
      homeDeliveryPrice.clear();
      quickServicePrice.clear();
      tabController =new TabController(length: 4, vsync: this);
    }
    super.didUpdateWidget(oldWidget);
  }

  BoxDecoration boxDecoration=BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
            color: AppTheme.openItemBoxShadowColor.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0,2)
        )
      ]
  );

  BoxDecoration selectBoxDec= BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    border:Border.all(color:Colors.transparent),
    color:Colors.red,
  );
  BoxDecoration unSelectBoxDec= BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    border:Border.all(color: Colors.grey),
    color:Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    _width1 = SizeConfig.screenWidth!-60;
    final node=FocusScope.of(context);
    FocusNode node1=FocusNode();
    FocusNode node99=FocusNode();
    FocusNode nodePrice=FocusNode();
    FocusNode node11=FocusNode();
    FocusNode node2=FocusNode();
    FocusNode node22=FocusNode();
    FocusNode node3=FocusNode();
    FocusNode node33=FocusNode();
    FocusNode node4=FocusNode();
    FocusNode node44=FocusNode();

    FocusNode nameKeyBoard=FocusNode();
    FocusNode priceKeyBoard=FocusNode();

    return  Consumer<BillingItemEditPopUpNotifier>(
      builder: (conte,billingitemedit,child)=> AnimatedContainer(
          height:overAllPrice?630:590,
          width:SizeConfig.screenWidth,
          duration: Duration(milliseconds:300),
          margin: EdgeInsets.only(left: 10,right: 10),
          transform: Matrix4.translationValues(widget.isOpenItemOpen!? 0:SizeConfig.screenWidth!, 0, 0),
          // width:500,
          // duration: Duration(milliseconds:300),
          // transform: Matrix4.translationValues(widget.isOpenItemOpen!? _width1!+100:SizeConfig.screenWidth!, 50, 0),
          curve: Curves.easeIn,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color:Colors.white,),
          child:SingleChildScrollView(
            physics: isScroll?AlwaysScrollableScrollPhysics():NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Consumer<BillingNotifier>(
                  builder: (context,bn,child)=> Container(
                    height: 60,
                    color:Color(0xFF6D6D6D),
                    child: Stack(
                      // alignment: Alignment.topCenter,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child:

                          Text("Open Item",
                              style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'RM')),

                        ),

                      ],
                    ),
                  ),
                ),



                SizedBox(height: _keyboardVisible?120:0,)
              ],
            ),
          )

      ),
    );
  }


  upDownArrow(Color color){
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color
      ),
      child: Center(
        child: Icon(Icons.keyboard_arrow_down,color: Colors.white,size: 25,),
      ),
    );
  }

}
