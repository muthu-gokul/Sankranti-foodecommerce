import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:foodecommerce/notifier/Billing/outletDetail.dart';
import '../../notifier/Billing/configuration.dart';
import '../../notifier/Billing/otherServices/takeAwayNotifier.dart';
import '/notifier/Billing/billingController.dart';
import '/pages/ItemViewAll/viewProductDetail.dart';
import '/utils/colorUtil.dart';
import '/utils/utils.dart';
import 'package:get/get.dart';
import '../../styles/constants.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/bottomPainter.dart';
import '../../widgets/calculation.dart';
import '../../widgets/companySettingsTextField.dart';
import '../../widgets/innerShadowTBContainer.dart';
import '../filter/FilterItems.dart';
import 'Cartpage.dart';
import 'package:basic_utils/basic_utils.dart' as utils;

class HomePage extends StatefulWidget {
  VoidCallback voidCallback;
  HomePage({required this.voidCallback});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  var animStart = false.obs;
  var showSplash = true.obs;
  var isItemAdd = false.obs;


  int getCatBgColor(int index){
    int color=0xffFF7D7D;
    int totalLen=5;
    if(index%totalLen==0){
      color=0xffFF7D7D;
    }
    else if(index%totalLen==1){
      color=0xffD1B63F;
    }
    else if(index%totalLen==2){
      color=0xffF99B7D;
    }
    else if(index%totalLen==3){
      color=0xffA67EC1;
    }
    else if(index%totalLen==4){
      color=0xff8BACAA;
    }
    return color;
  }

  @override
  void initState() {
    initAnim();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      TakeAwayAddNewHandler();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5];
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    gridWidth = width - 30;
    width2 = width - 16;
    height2 = height - 16;
    SizeConfig().init(context);
    return Align(
    alignment: Alignment.topLeft,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: ColorUtil.themeColorBg,
            body: SafeArea(
                left: true,
                top: true,
                right: true,
                bottom: true,
              child:NestedScrollView(
                // Setting floatHeaderSlivers to true is required in order to float
                // the outer slivers over the inner scrollable.
                  floatHeaderSlivers: true,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        backgroundColor: ColorUtil.branchClr,
                        toolbarHeight: 0,
                        //floating: false,
                       // snap: false,
                        pinned: true,
                        expandedHeight: 120.0,
                        automaticallyImplyLeading: false,
                        forceElevated: innerBoxIsScrolled,
                        centerTitle: false,
                        flexibleSpace: FlexibleSpaceBar(
                          expandedTitleScale: 1,
                          centerTitle: false,
                         // titlePadding: const EdgeInsets.fromLTRB(0,12,0,12),
                          titlePadding: const EdgeInsets.fromLTRB(0,0,0,0),

                          background:   Container(
                            width: width,
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 35,),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                      height: 70,
                                      width: SizeConfig.screenWidth,
                                      // color: Colors.red,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: SizeConfig.screenWidth!-45,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('Sankranti'.toUpperCase(),
                                                    style: TextStyle( fontSize: 20, color: ColorUtil.thWhite,fontFamily: 'RB')),
                                                Container(
                                                  child: Text(
                                                    'veg restaurants'.toUpperCase(),
                                                    style: TextStyle(fontSize: 20, color: ColorUtil.thWhite,  fontFamily: 'RB'),    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text(
                                                  'Everyday festival'.toUpperCase(),
                                                  style: TextStyle(fontSize: 14, color: ColorUtil.thWhite,  fontFamily: 'RR'),    overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                              onTap: () {
                                                widget.voidCallback();
                                                //  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AddressHomePage()));
                                              },
                                              child:Image.asset('assets/images/landingPage/menuBar.png',)
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                    top: -10,
                                    left: -10,
                                    child: Image.asset('assets/images/landingPage/banner-img-21.png',fit: BoxFit.contain,)
                                ),
                                Positioned(
                                    top: 0,
                                    left: 150,
                                    child: Image.asset('assets/images/landingPage/banner-img-22.png',fit: BoxFit.contain,)
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: InnerShadowTBContainer(
                    height: height ,
                    width: width,
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Text(
                            'Category',
                            style: TextStyle(
                              fontFamily: 'RM',
                              fontSize: 16,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(() => Visibility(visible: filtermainCategory.isEmpty,child: Text("No Category Added yet...."))),
                        Container(
                            width: SizeConfig.screenWidth,
                           // height: 130,
                            padding: EdgeInsets.only(left: 10,right: 10),
                            alignment: Alignment.centerLeft,
                            child: SingleChildScrollView(
                              child: Obx(() => Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: filtermainCategory.asMap().map((key, value)=>MapEntry(key,
                                  GestureDetector(
                                  onTap: () {
                                    //print("${filtermainCategory[i].toJson()}");
                                    updateMainCategory(key);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProductDetails()),);
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeIn,
                                    decoration:BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color:Color(getCatBgColor(key)) ,
                                    ),
                                    margin: EdgeInsets.only(right: 0, top: 0, bottom: 0, left: 0),
                                    padding: EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 5),
                                    width: (SizeConfig.screenWidth!-40) * 0.33,
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.network(GetImageUrl(1,value.imgPath),
                                          fit: BoxFit.cover,
                                          height: 50,
                                          errorBuilder: (context,er,s){
                                            return Image.network(GetImageUrl(1,"CategoryItems/DefaultCategory.png"),
                                              fit: BoxFit.fill,
                                              errorBuilder: (context,er,s){
                                                return Container();
                                              },
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 10,),
                                        Text("${utils.StringUtils.capitalize(value.MainCategoryName??"")}",
                                          style: TextStyle(color: ColorUtil.thWhite, fontSize: 14, fontFamily: 'RB'),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                )).values.toList(),
                              )
                              ),
                            )
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  addRemoveBtn(Widget icon,{VoidCallback? onTap}) {
    return GestureDetector(
    onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: icon,
        ),
      ),
    );
  }

  void initAnim() {
    Timer(const Duration(milliseconds: 1600), () {
      animStart.value = true;
      Timer(const Duration(milliseconds: 500), () {
        showSplash.value = false;
      });
    });
  }
}
Future Addons(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30)
        )
    ),
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all( 20.0),
        child: SizedBox(
          // height: 800,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                // mainAxisAlignment:
                // MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 158,
                    height: 158,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/foodimgs/chicken.jpg',
                      height: 158,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth!-198,
                    padding: const EdgeInsets.only(left: 20),
                    height: 158,
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: const Text(
                            'Pizza',
                            style: TextStyle(
                                fontFamily: 'MB',
                                color: Colors.black,
                                fontSize: 14),
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              '4.5',
                              style:
                              TextStyle(
                                fontFamily:
                                'RR',
                                fontSize:
                                12,
                                color: Colors
                                    .black,
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color:ColorUtil.themeColor,
                              size: 15,
                            ),
                            const Text(
                              '(233 ratings)',
                              style:
                              TextStyle(
                                fontFamily:
                                'RR',
                                fontSize:
                                12,
                                color: Colors
                                    .black,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          '15 mins',
                          style:
                          TextStyle(
                            fontFamily:
                            'MM',
                            fontSize:
                            12,
                            color: Colors
                                .black,
                          ),
                        ),
                        const Text(
                          'You save 5.00 for this order',
                          style:
                          TextStyle(
                            fontFamily:
                            'MM',
                            fontSize:
                            12,
                            color: Colors
                                .black,
                          ),
                        ),
                        Container(
                          child: const Text(
                            '250.00',
                            style: TextStyle(
                                fontFamily: 'RB',
                                color: Colors.black,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15,),
              Container(
                child: const Text(
                  'Product',
                  style:
                  TextStyle(
                    fontFamily:
                    'MM',
                    fontSize:
                    12,
                    color: Colors
                        .black,
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: SizeConfig.screenWidth!*0.31,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorUtil.primaryColor,
                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Add ons",
                    style: TSWhite166,
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              AddonsPopup("Chicken Quarter  (RS99) "),
              const SizedBox(height: 10,),
              AddonsPopup("Chicken Half  (RS199) "),
              const SizedBox(height: 10,),
              AddonsPopup("Chicken Full  (RS400) "),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: SizeConfig.screenWidth!*0.5,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorUtil.themeColor,
                        borderRadius:
                        BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Add Items", style: TextStyle(color: ColorUtil.primaryColor,fontWeight: FontWeight.w700,fontSize: 16,fontFamily: 'MR'),
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColorUtil.themeColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: ColorUtil.primaryColor.withOpacity(0.3),
                          blurRadius: 25.0, // soften the shadow
                          spreadRadius: 5.0, //extend the shadow
                          offset: const Offset(
                            0.0, // Move to right 10  horizontally
                            10.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                    ),
                    child: Stack(
                      children: [
                        Icon(Icons.shopping_cart_outlined,color: ColorUtil.primaryColor,size: 25,),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 15,
                            height: 15,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff9E203F),
                            ),
                            child: const Text(
                              '12',
                              style: TextStyle(
                                  fontFamily: 'RM',
                                  fontSize: 10,
                                  color: Colors.white),
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

}
Widget AddonsPopup(AddonName){
  return Container(
    width: SizeConfig.screenWidth,
    height: 50,
    padding: const EdgeInsets.only(left: 10, right: 10),
    decoration: BoxDecoration(
        color: const Color(0XFFF5F5F5),
        border: Border.all(color: const Color(0XFFE4E4E4))
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(AddonName,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 14,fontFamily: 'MR'),),
        Container(
          width: 25,
          height: 25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: ColorUtil.themeColor,
              shape: BoxShape.circle
          ),
          child: Icon(Icons.add,color: ColorUtil.primaryColor,size: 15,),
        ),
      ],
    ),
  );
}