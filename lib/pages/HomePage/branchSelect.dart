import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodecommerce/notifier/Billing/configuration.dart';
import 'package:foodecommerce/notifier/utils.dart';
import 'package:foodecommerce/pages/HomePage/hotelCategory.dart';
import 'package:foodecommerce/pages/ItemViewAll/viewProductDetail.dart';
import 'package:foodecommerce/pages/navHomeScreen.dart';
import 'package:foodecommerce/utils/colorUtil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../notifier/themeNotifier.dart';
import '../../notifier/utils/apiUtils.dart';
import '../../styles/constants.dart';
import '../../styles/style.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/bottomPainter.dart';
import '../../widgets/companySettingsTextField.dart';
import '../../widgets/innerShadowTBContainer.dart';
import '../ItemViewAll/ViewAll.dart';
import '../filter/FilterItems.dart';
import 'Cartpage.dart';

class BranchSelect extends StatefulWidget {
  @override
  _BranchSelectState createState() => _BranchSelectState();
}

class _BranchSelectState extends State<BranchSelect> {
  late double width, height, width2, height2, gridWidth;
  List<int> topSaleList = List.generate(20, (index) => index);
  List<int> TimeSlot = List.generate(4, (index) => index);
  List<int> AvailaTime = List.generate(2, (index) => index);
  int selectTopSale = 0;
  int selectFav = 0;
  bool isGridView = true;
  bool isFav = true;
  int selectAddRemove = -1;
  var _current = 0.obs;
  final CarouselController _controller = CarouselController();

  List<dynamic> Branch = [
    {
      "FavImg": "assets/images/loginpages/branch-1.png",
      "FavItemName": "Sankranti",
      "RestuName":"veg restaurants",
      "FavSubtitle": "Everyday festival"
    },
    {
      "FavImg": "assets/images/loginpages/branch-2.png",
      "FavItemName": "Sankranti",
      "RestuName":"Pizza Maina",
      "FavSubtitle": "Restaurant"
    },
    {
      "FavImg": "assets/images/loginpages/branch-3.png",
      "FavItemName": "Sri Vakula",
      "RestuName":"veg restaurants",
      "FavSubtitle": "Restaurant"
    },
    {
      "FavImg": "assets/images/loginpages/branch-4.png",
      "FavItemName": "Sankranti",
      "RestuName":"Expresss",
      "FavSubtitle": "Everyday festival"
    },
    {
      "FavImg": "assets/images/loginpages/branch-5.png",
      "FavItemName": "Andhra Curry",
      "RestuName":"non-veg restaurants",
      "FavSubtitle": "Everyday festival"
    },

  ];
  var animStart = false.obs;
  var showSplash = true.obs;

  int getBgColor(int index){
    int color=0xffE8AF46;
    int totalLen=5;
    if(index%totalLen==0){
      color=0xffE8AF46;
    }
    else if(index%totalLen==1){
      color=0xffCCDB6F;
    }
    else if(index%totalLen==2){
      color=0xff963256;
    }
    else if(index%totalLen==3){
      color=0xff96462E;
    }
    else if(index%totalLen==4){
      color=0xffA1D9F0;
    }
    return color;
  }
  int getTextColorColor(int index){
    int color=0xffFFFFFF;
    int totalLen=5;
    if(index%totalLen==0){
      color=0xffFFFFFF;
    }
    else if(index%totalLen==1){
      color=0xff346D35;
    }
    else if(index%totalLen==2){
      color=0xffFFFFFF;
    }
    else if(index%totalLen==3){
      color=0xffFFFFFF;
    }
    else if(index%totalLen==4){
      color=0xff044A60;
    }
    return color;
  }

  @override
  void initState() {
    initAnim();
    getOutletList();
    super.initState();
  }

  void getOutletList(){
    getMasterDrp("", "OutletList", null, null).then((value){
      debugPrint("OutletList $value");
      Branch=value;
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5];
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    gridWidth = width - 30;
    width2 = width - 16;
    height2 = height - 16;
    return Container(
      color: ColorUtil.themeColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffF5F7FE),
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Container(
                height: height,
                width: width,
                color: ColorUtil.themeColorBg,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      height: 70,
                      width: SizeConfig.screenWidth,
                      color: ColorUtil.themeColor,
                      child: Row(
                        children: [
                          Text("Select Outlet",style: ts18(Colors.white,fontfamily: 'RM',fontsize: 22),)
                        ]
                      ),
                    ),
                    InnerShadowTBContainer(
                      height: SizeConfig.screenHeight!-75,
                      width: width,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount:Branch.length ,
                          itemBuilder: (ctx,i){
                            return GestureDetector(
                              onTap: (){
                                outletId=Branch[i]['Id'];
                                setSharedPrefString(outletId, SP_OUTLETID);
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Masterpage()),);
                              },
                              child: Container(
                                height: 170,
                                width: SizeConfig.screenWidth,
                                margin: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: i == 0 ? 10 : 0),
                                padding: EdgeInsets.only(left: 30,right: 10),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Color(getBgColor(i)),
                                  borderRadius: BorderRadius.circular(15)
                                    //image: DecorationImage(image: AssetImage(Branch[i]['FavImg']),fit: BoxFit.cover,)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("${Branch[i]['Text']!=null?Branch[i]['Text'].toUpperCase():""}",
                                      style: TextStyle(fontFamily: 'MB',fontSize:22,color: Color(getTextColorColor(i)),letterSpacing: 0.2),
                                    ),
                                  //  Text(Branch[i]['RestuName'].toUpperCase(),style: TextStyle(fontFamily: 'RB',fontSize:20,color: Colors.white),),
                                  //  Text(Branch[i]['FavSubtitle'],style: TextStyle(fontFamily: 'RM',fontSize: 18,color: Colors.white),),
                                  ],
                                ),
                              ),
                            );
                          }
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

  addRemoveBtn(Widget icon) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: icon,
      ),
    );
  }

  void initAnim() {
    Timer(Duration(seconds: 3), () {
      animStart.value = true;
      Timer(Duration(seconds: 1), () {
        showSplash.value = false;
      });
    });
  }
}
