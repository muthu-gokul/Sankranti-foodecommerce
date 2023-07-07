import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodecommerce/pages/HomePage/hotelCategory.dart';
import 'package:foodecommerce/pages/ItemViewAll/viewProductDetail.dart';
import 'package:foodecommerce/utils/colorUtil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../notifier/themeNotifier.dart';
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
  List<dynamic> FavItems = [
    {
      "FavImg": "assets/images/foodimgs/Accompanied-with-Steamed-Rice-Dosa-or-Roti.jpg",
      "FavItemName": "Steamed-Rice & Roti",
      "Rate": "250.00",
      "FavVegNon": "Non-Veg",
      "FavColorCatg": 0xffFF0022,
      "FavSubtitle": "Comments"
    },
    {
      "FavImg": "assets/images/foodimgs/chicken.jpg",
      "FavItemName": "Chicken",
      "Rate": "59.00",
      "FavVegNon": "Non-veg",
      "FavColorCatg": 0xffFF0022,
      "FavSubtitle": "Comments"
    },
    {
      "FavImg": "assets/images/foodimgs/STRAWBERRY-LASSI.jpg",
      "FavItemName": "STRAWBERRY-LASSI",
      "Rate": "299.00",
      "FavVegNon": "Veg",
      "FavColorCatg": 0xff007F11,
      "FavSubtitle": "Comments"
    },
    {
      "FavImg": "assets/images/foodimgs/cold-press-juice-pineapple.jpg",
      "FavItemName": "Fresh Juice",
      "Rate": "150.00",
      "FavVegNon": "Veg",
      "FavColorCatg": 0xff007F11,
      "FavSubtitle": "Comments"
    },
    {
      "FavImg": "assets/images/foodimgs/sweet.jpg",
      "FavItemName": "Sweete",
      "Rate": "99.00",
      "FavVegNon": "Veg",
      "FavColorCatg": 0xff007F11,
      "FavSubtitle": "Comments"
    },
    {
      "FavImg": "assets/images/foodimgs/biriyani.webp",
      "FavItemName": "Chicken Biriyani",
      "Rate": "140.00",
      "FavVegNon": "Non-Veg",
      "FavColorCatg": 0xffFF0022,
      "FavSubtitle": "Comments"
    },
    {
      "FavImg": "assets/images/foodimgs/ice-cream-pistachio.jpg",
      "FavItemName": "Ice-cream Pistachio",
      "Rate": "170.00",
      "FavVegNon": "Veg",
      "FavColorCatg": 0xff007F11,
      "FavSubtitle": "Comments"
    },
    {
      "FavImg": "assets/images/foodimgs/dessert-gulab-jamoon-hot.jpg",
      "FavItemName": "Gulab Jamoon hot",
      "Rate": "80.00",
      "FavVegNon": "Veg",
      "FavColorCatg": 0xff007F11,
      "FavSubtitle": "Comments"
    },
    {
      "FavImg": "assets/images/foodimgs/sankranti-special-boneless-chicken-biriyani.jpg",
      "FavItemName": "Chicken Biriyani",
      "Rate": "199.00",
      "FavVegNon": "Non-veg",
      "FavColorCatg": 0xffFF0022,
      "FavSubtitle": "Meals"
    },
    {
      "FavImg": "assets/images/foodimgs/Paneer-Pepper-Fry.jpg",
      "FavItemName": "Panner Pepper",
      "Rate": "250.00",
      "FavVegNon": "Veg",
      "FavColorCatg": 0xff007F11,
      "FavSubtitle": "Comments"
    },
    {
      "FavImg": "assets/images/foodimgs/Tiffen.png",
      "FavItemName": "Mini Tiffen",
      "Rate": "130.00",
      "FavVegNon": "Veg",
      "FavColorCatg": 0xff007F11,
      "FavSubtitle": "Morning Special"
    },
    {
      "FavImg": "assets/images/foodimgs/CURRY-DOSA-GOAT.jpg",
      "FavItemName": "CURRY DOSA GOAT",
      "Rate": "99.00",
      "FavVegNon": "Veg",
      "FavColorCatg": 0xff007F11,
      "FavSubtitle": "Evening Special"
    },
  ];
  List<dynamic> TrendingFood = [
    {
      "Img": "assets/images/landingPage/Slide-Banner.png",
      "Rate": "Upto flat 50% Off",
      "btn": "Order now",
    },
    {
      "Img": "assets/images/landingPage/Slide-Banner.png",
      "Rate": "Upto flat 60% Off",
      "btn": "Order now",
    },
    {
      "Img": "assets/images/landingPage/Slide-Banner.png",
      "Rate": "Upto flat 70% Off",
      "btn": "Order now",
    },
  ];
  List<dynamic> Category = [
    {
      "CatgImg": "assets/images/landingPage/catg-1.png",
      "CatgName": "Non-Veg",
      "ColorCatg": 0xffFF7D7D
    },
    {
      "CatgImg": "assets/images/foodimgs/cat-5.png",
      "CatgName": "Veg",
      "ColorCatg": 0xffD1B63F
    },
    {
      "CatgImg": "assets/images/foodimgs/cat-2.png",
      "CatgName": "Dessert",
      "ColorCatg": 0xffF99B7D
    },
    {
      "CatgImg": "assets/images/foodimgs/cat-7.png",
      "CatgName": "Sweets",
      "ColorCatg": 0xffA67EC1
    },
    {
      "CatgImg": "assets/images/foodimgs/cat-3.png",
      "CatgName": "Juice",
      "ColorCatg": 0xff8BACAA
    },
  ];
  var animStart = false.obs;
  var showSplash = true.obs;

  @override
  void initState() {
    initAnim();
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
                        toolbarHeight: 70,
                        //floating: false,
                       // snap: false,
                        pinned: true,
                        expandedHeight: 180.0,
                        automaticallyImplyLeading: false,
                        forceElevated: innerBoxIsScrolled,
                        centerTitle: false,
                        flexibleSpace: FlexibleSpaceBar(
                          expandedTitleScale: 1,
                          centerTitle: false,
                          titlePadding: const EdgeInsets.fromLTRB(0,12,0,12),
                          title: Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                  width: SizeConfig.screenWidth!-50,
                                  height: 50,
                                  child: CompanySettingsTextField(
                                    enable: true,
                                    hintText: "Search Recipe",
                                    img: "",
                                    Sufimg: "assets/images/loginpages/search.png",width: 100,
                                  )),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const FilterItems()),
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
                                              child:Image.asset('assets/images/landingPage/menuBar.png',))
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
                                      decoration:BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(5.0),
                                        color:Color(Category[i]
                                        ['ColorCatg']) ,
                                      ),
                                      margin: EdgeInsets.only(
                                          right: 10,
                                          top: 5,
                                          bottom: 5,
                                          left: i == 0 ? 15 : 0),
                                      width: SizeConfig.screenWidth! * 0.33,
                                      clipBehavior: Clip.antiAlias,
                                      child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            Category[i]['CatgImg'],
                                            fit: BoxFit.cover,width: 70,
                                          ),
                                          SizedBox(height: 5,),
                                          Text(
                                            Category[i]['CatgName'],
                                            style: TextStyle(
                                                color: ColorUtil.thWhite,
                                                fontSize: 14,
                                                fontFamily: 'RB'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Text(
                            'Restaurants Menu',
                            style: TextStyle(
                              fontFamily: 'RM',
                              fontSize: 16,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: FavItems.length,
                            shrinkWrap: true,
                            itemBuilder: (ctx, i) {
                              return GestureDetector(
                                onTap: (){
                                  // Get.to(HotelViewPage());
                                },
                                child: Container(
                                  height: 120,
                                  width: width,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0XFFE4E4E4)),
                                    borderRadius:
                                    BorderRadius.circular(8),
                                    color: const Color(0xffffffff),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  margin: const EdgeInsets.fromLTRB(10,0,10,10),
                                  child: Stack(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        // mainAxisAlignment:
                                        // MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: width * 0.30,
                                            height: 100,
                                            clipBehavior: Clip.antiAlias,
                                            margin: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              color: Colors.white,
                                            ),
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              FavItems[i]['FavImg'],
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    FavItems[i]['FavItemName'],
                                                    style: const TextStyle(
                                                        fontFamily: 'RB',
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
                                                  '(15 mins)',
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
                                                Container(
                                                  child: Text(
                                                    FavItems[i]['Rate'],
                                                    style: const TextStyle(
                                                        fontFamily: 'RB',
                                                        color: Colors.black,
                                                        fontSize: 14),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Stack(
                                          children: [
                                            Visibility(
                                              visible:FavItems[i]['IsAdd']==null?true:!FavItems[i]['IsAdd'],
                                              child: GestureDetector(
                                                onTap: (){
                                                  if(i==1){
                                                    Addons(context);
                                                  }
                                                  else{
                                                    FavItems[i]['IsAdd']=true;
                                                    setState(() {});
                                                  }

                                                },
                                                child: Container(
                                                  width: gridWidth*0.20,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: ColorUtil.primaryColor,
                                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),)
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Add",
                                                      style: TSWhite166,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible:FavItems[i]['IsAdd'] ?? false,
                                              child: Container(
                                                height: 40,
                                                width: gridWidth*0.31,
                                                decoration: BoxDecoration(
                                                    color:ColorUtil.primaryColor,
                                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),)
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    addRemoveBtn(Icon(Icons.add,color: ColorUtil.primaryColor,size: 25,)),
                                                    Text("10",style: TSWhite166,),
                                                    addRemoveBtn(Icon(Icons.remove,color: ColorUtil.primaryColor,size: 25,),
                                                        onTap: (){
                                                          FavItems[i]['IsAdd']=false;
                                                          setState(() {});
                                                        }
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                        const SizedBox(
                          height: 80,
                        )
                      ],
                    ),
                  ),
              ),
            ),
            bottomNavigationBar:  Container(
              width: SizeConfig.screenWidth,
              // height:_keyboardVisible?0:  70,
              height: 65,
              decoration: BoxDecoration(
                  color: Colors.white12.withOpacity(0.1),
                  // color: Color(0xFF787878).withOpacity(0.1),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF787878).withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 25,
                      offset: Offset(0, 0), // changes position of shadow
                    )
                  ]
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                    ),
                    margin:EdgeInsets.only(top: 0),
                    child: CustomPaint(
                      size: Size( SizeConfig.screenWidth!, 65),
                      painter: RPSCustomPainter(),
                    ),
                  ),
                  Container(
                    width:  SizeConfig.screenWidth,
                    padding: EdgeInsets.only(left: 25,right: 25),
                    height: 65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('28 Items',style: TextStyle(fontFamily: 'RB',fontSize: 18,color: ColorUtil.themeColor),),
                        Text('Pay 2,199',style: TextStyle(fontFamily: 'RB',fontSize: 18,color:ColorUtil.themeColor,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  );
                },
                child: Container(
                    width: 80,
                    height: 80,
                    margin: const EdgeInsets.only(bottom: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorUtil.themeColor,
                      boxShadow: [
                        BoxShadow(
                          color: ColorUtil.themeColor.withOpacity(0.5),
                          blurRadius: 20.0, // soften the shadow
                          spreadRadius: 0.0, //extend the shadow
                          offset: const Offset(
                            0.0, // Move to right 10  horizontally
                            10.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                    ),
                    child: Stack(
                      children: [
                        Align(
                        alignment: Alignment.center,
                          child: const Icon(
                            Icons.shopping_bag_outlined,
                            color: Color(0xffffffff),
                            size: 40,
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 15,
                          child: Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff9E203F),
                            ),
                            child: const Text(
                              '12',
                              style: TextStyle(
                                  fontFamily: 'RM',
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ))),
          ),
          Obx(() => Visibility(
              visible: showSplash.value,
              child: AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                top: animStart.value ? -SizeConfig.screenHeight! : 0,
                child: AnimatedOpacity(
                  opacity: animStart.value ? 0 : 1,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    height: SizeConfig.screenHeight,
                    width: SizeConfig.screenWidth,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                            'assets/images/landingPage/icons8-location.gif'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              '26F5+J25, Thiru Vi Ka Industrial Estate, Saidapet, Chennai, Tamil Nadu 600032',
                              style: TextStyle(
                                  fontFamily: 'RR',
                                  color: ColorUtil.grey1,
                                  fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )))
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
    Timer(const Duration(seconds: 3), () {
      animStart.value = true;
      Timer(const Duration(seconds: 1), () {
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
                  'Lorem ipsum dolor sit amet consectetur. Gravida nunc volutpat sit lobortis pharetra augue. Sollicitudin condimen tum in tincidunt non molestie',
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