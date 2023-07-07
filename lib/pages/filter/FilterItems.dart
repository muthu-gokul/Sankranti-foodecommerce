
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodecommerce/utils/colorUtil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';


import '../../notifier/themeNotifier.dart';
import '../../styles/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/bottomPainter.dart';
import '../../widgets/companySettingsTextField.dart';
import '../navHomeScreen.dart';




class FilterItems extends StatefulWidget {
  const FilterItems({Key? key}) : super(key: key);

  @override
  _FilterItemsState createState() => _FilterItemsState();
}

class _FilterItemsState extends State<FilterItems> {
  RangeValues _currentRangeValues = const RangeValues(0, 60);
  @override
  late  double width,height,width2,height2;
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    height2=height-16;
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          backgroundColor: ColorUtil.themeColorBg,
          body: Stack(
            children: [
              Container(
                height: height,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Container(
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5,),
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 35,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                  ),
                                  child: IconButton(onPressed: (){
                                    Get.back();
                                  },
                                    icon: Icon(Icons.arrow_back,color:ColorUtil.themeColor,size: 30,),),
                                ),
                                SizedBox(width: 40,),
                                Text('Filter',style: TextStyle(fontFamily: 'RM',fontSize: 24,color: Colors.black,letterSpacing: 0.1),),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('SELECT CATEGORY',style: TextStyle(fontFamily: 'RB',fontSize: 16,color: Color(0xff000000)),),
                    SizedBox(height: 20,),
                    Wrap(
                      spacing: 25,
                      runSpacing: 25,
                      alignment: WrapAlignment.center,
                      // runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          width:90,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: ColorUtil.themeColor,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color:ColorUtil.themeColor)
                          ),
                          child: Text('Indian',style: TextStyle(fontFamily: 'RM',fontSize: 14,color: ColorUtil.primaryColor),),
                        ),
                        Container(
                          width:90,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0XFFFFFFFF),
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Color(0xffD9D9D9))
                          ),
                          child: Text('Tiffen',style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),),
                        ),
                        Container(
                          width:90,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0XFFFFFFFF),
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Color(0xffD9D9D9))
                          ),
                          child: Text('Ice Cream',style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),),
                        ),
                        Container(
                          width:90,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0XFFFFFFFF),
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Color(0xffD9D9D9))
                          ),
                          child: Text('Dessert',style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),),
                        ),
                        Container(
                          width:90,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0XFFFFFFFF),
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Color(0xffD9D9D9))
                          ),
                          child: Text('Cake',style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),),
                        ),Container(
                          width:90,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0XFFFFFFFF),
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Color(0xffD9D9D9))
                          ),
                          child: Text('Juice',style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),),
                        ),Container(
                          width:90,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0XFFFFFFFF),
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Color(0xffD9D9D9))
                          ),
                          child: Text('Thai',style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),),
                        ),Container(
                          width:90,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0XFFFFFFFF),
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Color(0xffD9D9D9))
                          ),
                          child: Text('Indian',style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),),
                        ),Container(
                          width:90,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0XFFFFFFFF),
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Color(0xffD9D9D9))
                          ),
                          child: Text('Chinese',style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xff000000)),),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.only(left: 20.0,right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Delivery Time',style: TextStyle(fontFamily:'RB',fontSize: 16,color: Color(0xff000000),fontWeight: FontWeight.bold),),
                          Spacer(),
                          GestureDetector(
                              onTap:(){
                                // testBtmSheet1();
                              },
                              child: Text('30 min',style: TextStyle(fontFamily: 'RM',fontSize: 14,color:Colors.black54),)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    RangeSlider(
                      activeColor: ColorUtil.themeColor,
                      values: _currentRangeValues,
                      max: 100,
                      divisions: 5,
                      labels: RangeLabels(
                        _currentRangeValues.start.round().toString(),
                        _currentRangeValues.end.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _currentRangeValues = values;
                        });
                      },
                    ),
                    SizedBox(height: 20,),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 20.0,),
                      child:Text('Rating',style: TextStyle(fontFamily:'RB',fontSize: 16,color: Color(0xff000000),fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width:SizeConfig.screenWidth!*0.9,
                      height: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xffF6FBFF),
                        borderRadius: BorderRadius.circular(5.0),
                        // border: Border.all(color:tn.primaryColor)
                      ),
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star,color: Colors.yellow,size: 35,),
                          Icon(Icons.star,color: Colors.yellow,size: 35,),
                          Icon(Icons.star,color: Colors.yellow,size: 35,),
                          Icon(Icons.star,color: Colors.yellow,size: 35,),
                          Icon(Icons.star,color: Colors.grey,size: 35,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -15,
                child: Container(
                  width:SizeConfig.screenWidth,
                  height: 65,
                  margin: EdgeInsets.only(bottom:16 ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorUtil.themeColor,
                    borderRadius: BorderRadius.circular(35.0),
                    // border: Border.all(color:tn.primaryColor)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Masterpage()),);
                          },
                          child: Text('Apply',style: TextStyle(fontFamily:'RM',fontSize: 16,color: ColorUtil.primaryColor,),)),
                      Container(width: 2,height: 40,color: Colors.white,),
                      Text('Reset',style: TextStyle(fontFamily:'RM',fontSize: 16,color: ColorUtil.primaryColor,),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
addRemoveBtn(Widget icon){
  return Container(
    height: 25,
    width: 25,
    // decoration: BoxDecoration(
    //     color:Color(0xffF5F4F2),
    //     borderRadius:BorderRadius.circular(5)
    // ),
    child: Center(
      child: icon,
    ),
  );
}