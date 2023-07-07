import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodecommerce/pages/ItemViewAll/viewProductDetail.dart';
import 'package:foodecommerce/utils/colorUtil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../notifier/themeNotifier.dart';
import '../../styles/constants.dart';
import '../../styles/style.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/bottomPainter.dart';
import '../../widgets/companySettingsTextField.dart';
import '../../widgets/innerShadowTBContainer.dart';
import '../ItemViewAll/ViewAll.dart';
import '../filter/FilterItems.dart';
import 'Cartpage.dart';

class HotelViewPage extends StatefulWidget {
  @override
  _HotelViewPageState createState() => _HotelViewPageState();
}

class _HotelViewPageState extends State<HotelViewPage> {
  @override
  late double width, height, width2, height2, gridWidth;
  List<int> topSaleList = List.generate(20, (index) => index);
  List<int> TimeSlot = List.generate(4, (index) => index);
  List<int> AvailaTime = List.generate(2, (index) => index);
  int selectTopSale = 0;
  int selectFav = 0;
  bool isGridView = true;
  bool isFav = true;
  int selectAddRemove = -1;

  List<dynamic> TrendingFood = [
    {
      "Img": "assets/images/foodimgs/Fullmeals.png",
      "ItemName": "South Indian Special",
      "Rate": "150.00",
      "VegNon": "Non-veg",
      "ColorCatg": 0xffFF0022,
      "Subtitle": "Full Meals"
    },
    {
      "Img": "assets/images/foodimgs/PannerMasala.png",
      "ItemName": "Panner Masala",
      "Rate": "250.00",
      "VegNon": "Veg",
      "ColorCatg": 0xff007F11,
      "Subtitle": "Panner Butter Masala"
    },
    {
      "Img": "assets/images/foodimgs/Tiffen.png",
      "ItemName": "Mini Tiffen",
      "Rate": "130.00",
      "VegNon": "Veg",
      "ColorCatg": 0xff007F11,
      "Subtitle": "Morning Special"
    },
    {
      "Img": "assets/images/foodimgs/dossa.png",
      "ItemName": "Dossa Special",
      "Rate": "99.00",
      "VegNon": "Veg",
      "ColorCatg": 0xff007F11,
      "Subtitle": "Evening Special"
    },
    {
      "Img": "assets/images/foodimgs/Grill.jpg",
      "ItemName": "Grill Chicken",
      "Rate": "399.00",
      "VegNon": "Non-veg",
      "ColorCatg": 0xffFF0022,
      "Subtitle": "Infuse Masala Grill"
    },
  ];
  List<dynamic> Category = [
    {
      "CatgImg": "assets/images/foodimgs/Fullmeals.png",
      "CatgName": "INDIAN",
      "ColorCatg": 0xffFE0144
    },
    {
      "CatgImg": "assets/images/foodimgs/seaFood.jpg",
      "CatgName": "CHINESE",
      "ColorCatg": 0xff0000FF
    },
    {
      "CatgImg": "assets/images/foodimgs/Pizza.jpg",
      "CatgName": "ITALIAN",
      "ColorCatg": 0xff03903C
    },
    {
      "CatgImg": "assets/images/foodimgs/BBQ.png",
      "CatgName": "BBQ",
      "ColorCatg": 0xff000000
    },
  ];
  List<dynamic> FavItems = [
    {
      "FavImg": "assets/images/foodimgs/tikka.jpg",
      "FavItemName": "Upto 20% off",
      "Rate": "Indian chinese",
      "FavVegNon": "View menu",
    },
    {
      "FavImg": "assets/images/foodimgs/Fullmeals.png",
      "FavItemName": "Upto 20% off",
      "Rate": "North Indian",
      "FavVegNon": "View menu",
    },
    {
      "FavImg": "assets/images/foodimgs/PannerMasala.png",
      "FavItemName": "Upto 20% off",
      "Rate": "South Indian",
      "FavVegNon": "View menu",
    },
    {
      "FavImg": "assets/images/foodimgs/Tiffen.png",
      "FavItemName": "Upto 20% off",
      "Rate": "Tiffen",
      "FavVegNon": "View menu",
    },

    {
      "FavImg": "assets/images/foodimgs/Grill.jpg",
      "FavItemName": "Upto 20% off",
      "Rate": "Tandoori",
      "FavVegNon": "View menu",
    },
  ];
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5];
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    gridWidth = width - 30;
    width2 = width - 16;
    height2 = height - 16;
    SizeConfig().init(context);
    return SafeArea(
      child:Stack(
        children: [
          Scaffold(
            backgroundColor: ColorUtil.themeColorBg,
            resizeToAvoidBottomInset: false,
            body: Container(
              height: height,
              width: width,
              color: Color(0xffF5F7FE),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          left: 25,
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xffEFF1F8),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Color(0xffD4D5D7))),
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_sharp,
                            color: ColorUtil.primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth! - 60,
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(
                          'Sankranti',
                          style: TextStyle(
                            fontFamily: 'RM',
                            fontSize: 16,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          width: SizeConfig.screenWidth!-50,
                          height: 50,
                          child: CompanySettingsTextField(
                            enable: true,
                            hintText: "Search Product",
                            img: "",
                            Sufimg: "assets/images/loginpages/search.png",width: 100,
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FilterItems()),
                          );
                        },
                        child: Container(
                            width: 50,
                            height: 50,
                            child: Image.asset('assets/images/landingPage/page_info.png')
                        ),
                      )
                    ],
                  ),
                  InnerShadowTBContainer(
                    height: height - 145,
                    width: width,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          padding:
                          const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Popular Items',
                                style: TextStyle(
                                  fontFamily: 'RM',
                                  fontSize: 16,
                                  color: Color(0xff000000),
                                ),
                              ),
                              Container(
                                margin:EdgeInsets.only(left: 10),
                                width: SizeConfig.screenWidth!-141,
                                height: 1,
                                color: Color(0XffE4E4E4),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Container(
                            width: SizeConfig.screenWidth,
                            height: 130,
                            //  padding: EdgeInsets.only(bottom: 10),
                            alignment: Alignment.centerLeft,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: Category.length,
                              shrinkWrap: true,
                              itemBuilder: (ctx, i) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectTopSale = i;
                                    });
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewProductDetails()),
                                      );
                                    },
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 400),
                                      curve: Curves.easeIn,
                                      decoration: i == selectTopSale
                                          ? BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(5.0),
                                        color: ColorUtil.primaryColor,
                                      )
                                          : BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(5.0),
                                        // border: Border.all(color: Color(0xffE2E2E2),style:BorderStyle.solid ),
                                        color: Color(0xffDCDDE2),
                                      ),
                                      margin: EdgeInsets.only(
                                          right: 10,
                                          top: 5,
                                          bottom: 5,
                                          left: i == 0 ? 15 : 0),
                                      width: SizeConfig.screenWidth! * 0.30,
                                      clipBehavior: Clip.antiAlias,
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            Category[i]['CatgImg'],
                                            fit: BoxFit.cover,
                                            width: SizeConfig.screenWidth,
                                            height: 130,
                                          ),
                                          Positioned(
                                            child: Container(
                                              width: SizeConfig.screenWidth,
                                              height: SizeConfig.screenHeight,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    2.0),
                                                color: Color(Category[i]
                                                ['ColorCatg'])
                                                    .withOpacity(0.4),
                                              ),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  Category[i]['CatgName'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontFamily: 'RB'),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Menus',
                                    style: TextStyle(
                                      fontFamily: 'RM',
                                      fontSize: 16,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    width: SizeConfig.screenWidth!-89,
                                    height: 1,
                                    color: Color(0XffE4E4E4),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                width: SizeConfig.screenWidth,
                                //height: SizeConfig.screenHeight,
                                //  padding: EdgeInsets.only(bottom: 10),
                                alignment: Alignment.centerLeft,
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: FavItems.length,
                                  shrinkWrap: true,
                                  itemBuilder: (ctx, i) {
                                    return GestureDetector(
                                      onTap:(){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewProductDetails()),
                                        );
                                      },
                                      child:Container(
                                        decoration:
                                        BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(
                                              8.0),
                                          //border: Border.all(color: Color(0XFFE4E4E4)),
                                          // color: Colors.white
                                        ),
                                        margin: EdgeInsets.only(
                                            right: 15,
                                            top: 10,
                                            bottom: 10,
                                            left:15 /*i == 0 ? 15 : 0*/),
                                        width: SizeConfig.screenWidth,
                                        height: 120,
                                        clipBehavior: Clip.antiAlias,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: SizeConfig.screenWidth!*0.50,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8.0),
                                                /*  border: Border.all(color: Color(0XFFE4E4E4)),
                                                    color: Colors.red*/),
                                              child: Image.asset(
                                                FavItems[i]['FavImg'],
                                                fit: BoxFit.cover,
                                                width: SizeConfig
                                                    .screenWidth,
                                              ),
                                            ),
                                            Container(
                                              width: SizeConfig.screenWidth! * 0.35,
                                              padding: EdgeInsets.only(
                                                left: 20,
                                                right: 5,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    FavItems[i]['Rate'],
                                                    style: TextStyle(
                                                      fontFamily: 'MB',
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    FavItems[i]
                                                    ['FavItemName'],
                                                    style: TextStyle(
                                                      fontFamily: 'MB',
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    width: 84,
                                                    height: 36,
                                                    alignment:
                                                    Alignment.center,
                                                    decoration:
                                                    BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          4.0),
                                                      color: ColorUtil.primaryColor,
                                                    ),
                                                    child: Text(
                                                      FavItems[i]
                                                      ['FavVegNon'],
                                                      style: TextStyle(
                                                        fontFamily: 'RR',
                                                        fontSize: 12,
                                                        color: ColorUtil.themeColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // bottomNavigationBar: BottomNavi(),
          ),
          Positioned(bottom: -15, child: BottomNavi()),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                },
                child: Container(
                    width: 60,
                    height: 60,
                    margin: EdgeInsets.only(bottom: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorUtil.themeColor,
                      boxShadow: [
                        BoxShadow(
                          color: ColorUtil.themeColor.withOpacity(0.5),
                          blurRadius: 25.0, // soften the shadow
                          spreadRadius: 5.0, //extend the shadow
                          offset: Offset(
                            0.0, // Move to right 10  horizontally
                            10.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                    ),
                    child: Stack(
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: Color(0xffffffff),
                          size: 30,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 15,
                            height: 15,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff9E203F),
                            ),
                            child: Text(
                              '12',
                              style: TextStyle(
                                  fontFamily: 'RM',
                                  fontSize: 10,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ))),
          ),
        ],
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
}
