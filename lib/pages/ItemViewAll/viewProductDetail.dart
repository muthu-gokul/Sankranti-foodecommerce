import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodecommerce/utils/colorUtil.dart';
import 'package:foodecommerce/widgets/customPopUp.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../notifier/themeNotifier.dart';
import '../../styles/constants.dart';
import '../../styles/style.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/bottomPainter.dart';
import '../../widgets/bottomShowmadol/bottomShowDailog.dart';
import '../../widgets/companySettingsTextField.dart';
import '../../widgets/innerShadowTBContainer.dart';
import '../HomePage/Cartpage.dart';
import '../filter/FilterItems.dart';

class ViewProductDetails extends StatefulWidget {
  const ViewProductDetails({Key? key}) : super(key: key);
  @override
  _ViewProductDetailsState createState() => _ViewProductDetailsState();
}

class _ViewProductDetailsState extends State<ViewProductDetails> {
  late double width, height, width2, height2, gridWidth;
  // List<int> topSaleList=List.generate(20, (index) => index);

  int selectTopSale = 0;
  bool isGridView = true;
  int selectAddRemove = -1;
  List<dynamic> FavItems = [
    {
      "FavImg": "assets/images/foodimgs/seaFood.jpg",
      "FavItemName": "SEA Food",
      "Rate": "250.00",
      "FavVegNon": "Non-Veg",
      "FavColorCatg": 0xffFF0022,
      "FavSubtitle": "Comments"
    },
    {
      "FavImg": "assets/images/foodimgs/Pizza.jpg",
      "FavItemName": "Pizza Maina",
      "Rate": "59.00",
      "FavVegNon": "Non-veg",
      "FavColorCatg": 0xffFF0022,
      "FavSubtitle": "Comments"
    },
    {
      "FavImg": "assets/images/foodimgs/icecream.jpg",
      "FavItemName": "Ice Cream",
      "Rate": "299.00",
      "FavVegNon": "Veg",
      "FavColorCatg": 0xff007F11,
      "FavSubtitle": "Comments"
    },
    {
      "FavImg": "assets/images/foodimgs/Fullmeals.png",
      "FavItemName": "Fresh Juice",
      "Rate": "150.00",
      "FavVegNon": "Veg",
      "FavColorCatg": 0xff007F11,
      "FavSubtitle": "Comments"
    },
    {
      "FavImg": "assets/images/foodimgs/milkcatg.jpg",
      "FavItemName": "Milk Shake",
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
      "FavImg": "assets/images/foodimgs/tikka.jpg",
      "FavItemName": "Panner Tikka",
      "Rate": "170.00",
      "FavVegNon": "Veg",
      "FavColorCatg": 0xff007F11,
      "FavSubtitle": "Comments"
    },
    {
      "FavImg": "assets/images/foodimgs/milkshake.jpg",
      "FavItemName": "Choco Dessert",
      "Rate": "80.00",
      "FavVegNon": "Veg",
      "FavColorCatg": 0xff007F11,
      "FavSubtitle": "Comments"
    },
    {
      "FavImg": "assets/images/foodimgs/Fullmeals.png",
      "FavItemName": "Lunch",
      "Rate": "199.00",
      "FavVegNon": "Non-veg",
      "FavColorCatg": 0xffFF0022,
      "FavSubtitle": "Meals"
    },
    {
      "FavImg": "assets/images/foodimgs/PannerMasala.png",
      "FavItemName": "Panner Masala",
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
      "FavImg": "assets/images/foodimgs/dossa.png",
      "FavItemName": "Dossa Special",
      "Rate": "99.00",
      "FavVegNon": "Veg",
      "FavColorCatg": 0xff007F11,
      "FavSubtitle": "Evening Special"
    },
  ];

  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    width2 = width - 16;
    height2 = height - 16;
    gridWidth = width - 30;
    return SafeArea(
      child: Scaffold(
      backgroundColor: ColorUtil.themeColorBg,
          body: Stack(
            children: [
              Column(
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
                          left: 15,
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
                            color: ColorUtil.themeColor,
                            size: 20,
                          ),
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth! - 60,
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(
                          'South Indian',
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
                          padding: EdgeInsets.only(left: 10.0,),
                          width: SizeConfig.screenWidth!-50,
                          height: 50,
                          child: CompanySettingsTextField(
                            enable: true,
                            hintText: "Search Product",
                            img: "",
                            Sufimg: "assets/images/loginpages/search.png",width: 100,
                          )),
                      Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                        child: IconButton(onPressed: (){
                          setState(() {
                            isGridView=!isGridView;
                          });
                        },
                          icon: Icon(isGridView?Icons.grid_view:Icons.list,color: ColorUtil.themeColor,size:30),
                          //   icon: Icon(Icons.menu,color: Colors.white,size: 30,),
                        ),
                      ),
                    ],
                  ),
                  InnerShadowTBContainer(
                    height: height - 145,
                    width: width,
                    //  clipBehavior: Clip.antiAlias,
                    child: isGridView
                        ? ListView.builder(
                         //   physics: NeverScrollableScrollPhysics(),
                            itemCount: FavItems.length,
                            shrinkWrap: true,
                            itemBuilder: (ctx, i) {
                              return Container(
                                height: 120,
                                width: width,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0XFFE4E4E4)),
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  color: Color(0xffffffff),
                                ),
                                clipBehavior: Clip.antiAlias,
                                margin: EdgeInsets.all(10),
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
                                          margin: EdgeInsets.only(
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
                                        padding: EdgeInsets.only(left: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                child: Text(
                                                  FavItems[i]['FavItemName'],
                                                  style: TextStyle(
                                                      fontFamily: 'RB',
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
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
                                                  Text(
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
                                              Text(
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
                                                  style: TextStyle(
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
                                    /*Positioned(child:Align(
                                      alignment: Alignment.center,
                                      child:  Container(
                                        height: 40,
                                        width: gridWidth*0.31,
                                        decoration: BoxDecoration(
                                            color:ColorUtil.primaryColor,
                                            borderRadius:BorderRadius.circular(10)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            addRemoveBtn(Icon(Icons.add,color: ColorUtil.primaryColor,size: 25,)),
                                            Text("10",style: TSWhite166,),
                                            addRemoveBtn(Icon(Icons.remove,color: ColorUtil.primaryColor,size: 25,)),
                                          ],
                                        ),
                                      ),
                                    )),*/
                                    Positioned(
                                    bottom: 0,
                                    right: 0,
                                      child: GestureDetector(
                                      onTap: (){
                                        Addons(context);
                                      },
                                        child: Container(
                                          width: gridWidth*0.31,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: ColorUtil.primaryColor,
                                              borderRadius:
                                              BorderRadius.only(
                                                topLeft:
                                                Radius.circular(20),
                                              )),
                                          child: Center(
                                            child: Text(
                                              "Add",
                                              style: TSWhite166,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            })
                    :Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 10,
                          ),
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 20,
                            children: FavItems.asMap()
                                .map((key, value) => MapEntry(
                                key,
                                Container(
                                  height: 200,

                                  ///  width: width*0.48,
                                  //   margin: EdgeInsets.fromLTRB(width*0.01, 5, width*0.01, 5),
                                  width: gridWidth * 0.5,
                                  //margin: EdgeInsets.fromLTRB(10, 5, width*0.01, 5),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(5),
                                      color: Colors.white),
                                  child: Column(
                                    children: [
                                      Container(
                                        width:
                                        SizeConfig.screenWidth,
                                        height: 150,
                                        child: Stack(
                                          children: [
                                            Image.asset(
                                              value['FavImg'],
                                              fit: BoxFit.cover,
                                              height: 150,
                                              width: SizeConfig
                                                  .screenWidth,
                                            ),
                                            Positioned(
                                              top: 10,
                                              left: 10,
                                              child: Container(
                                                width: 50,
                                                height: 20,
                                                alignment: Alignment
                                                    .center,
                                                decoration:
                                                BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      2.0),
                                                  color:
                                                  Colors.white,
                                                ),
                                                child: Text(
                                                  value[
                                                  'FavVegNon'],
                                                  style: TextStyle(
                                                      fontFamily:
                                                      'RR',
                                                      fontSize: 12,
                                                      color: Color(
                                                          value[
                                                          'FavColorCatg'])),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: SizeConfig
                                            .screenWidth! *
                                            0.9,
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  value['Rate'],
                                                  style: TextStyle(
                                                    fontFamily:
                                                    'RB',
                                                    fontSize: 14,
                                                    color: Colors
                                                        .black,
                                                  ),
                                                ),
                                                Text(
                                                  value[
                                                  'FavItemName'],
                                                  style: TextStyle(
                                                    fontFamily:
                                                    'RR',
                                                    fontSize: 10,
                                                    color: Colors
                                                        .black26,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors
                                                          .yellow,
                                                      size: 15,
                                                    ),
                                                    Text(
                                                      '4.5(233)',
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
                                                Text(
                                                  value[
                                                  'FavSubtitle'],
                                                  style: TextStyle(
                                                    fontFamily:
                                                    'RM',
                                                    fontSize: 10,
                                                    color: Colors
                                                        .black26,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )))
                                .values
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],),
              Positioned(
                bottom: 60,
                right: 20,
                child: DialogExample(),
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
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorUtil.themeColor,
                          boxShadow: [
                            BoxShadow(
                              color: ColorUtil.themeColor.withOpacity(0.3),
                              blurRadius: 25.0, // soften the shadow
                              spreadRadius: 5.0, //extend the shadow
                              offset: Offset(
                                0.0, // Move to right 10  horizontally
                                10.0, // Move to bottom 10 Vertically
                              ),
                            )
                          ],
                        ),
                        child: Icon(
                          Icons.shopping_cart,
                          color: Color(0xffffffff),
                          size: 30,
                        ))),
              ),
            ],
          )
      ),
    );
  }
}

addRemoveBtn(Widget icon) {
  return Container(
    height: 25,
    width: 25,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(5)),
    child: Center(
      child: icon,
    ),
  );
}

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          actionsAlignment: MainAxisAlignment.end,
          alignment: Alignment.bottomRight,
          // title: Row(
          //   children: [
          //     Text('Recommended',style: TextStyle(fontFamily: 'RB',fontSize: 18,color: Colors.white,),),
          //     Spacer(),
          //     Text('19',style: TextStyle(fontFamily: 'RB',fontSize: 18,color: Colors.white,),),
          //   ],
          // ),
          content: SingleChildScrollView(
            child: Container(
              height: 250,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Recommended',
                          style: TextStyle(
                            fontFamily: 'RB',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '19',
                          style: TextStyle(
                            fontFamily: 'RB',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Soups',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '12',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Starters/Appeetizers',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '10',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Curries & Gravies',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '25',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Curries & Gravies',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '25',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Curries & Gravies',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '25',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Curries & Gravies',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '25',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Curries & Gravies',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '25',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Curries & Gravies',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '25',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Curries & Gravies',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '25',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Curries & Gravies',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '25',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Curries & Gravies',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '25',
                          style: TextStyle(
                            fontFamily: 'RR',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: CupertinoColors.black,
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'RR',
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            // TextButton(
            //   onPressed: () => Navigator.pop(context, 'OK'),
            //   child: const Text('OK',style: TextStyle(fontFamily: 'RR',fontSize: 16,color: Colors.white,),),
            // ),
          ],
        ),
      ),
      child: Container(
        height: 60,
        width: 60,
        alignment: Alignment.center,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: CupertinoColors.black),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message_outlined,
              color: Colors.white,
              size: 25,
            ),
            Text(
              'Menu',
              style: TextStyle(
                fontFamily: 'RR',
                fontSize: 14,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}


Future Addons(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
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
                    'assets/images/foodimgs/Dessert.jpg',
                      height: 158,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth!-198,
                    padding: EdgeInsets.only(left: 20),
                    height: 158,
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Text(
                            'Chicken Biriyani',
                            style: TextStyle(
                                fontFamily: 'MB',
                                color: Colors.black,
                                fontSize: 14),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
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
                            Text(
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
                        Text(
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
                        Text(
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
                          child: Text(
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
              SizedBox(height: 15,),
              Container(
                child: Text(
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
              SizedBox(height: 15,),
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
              SizedBox(height: 10,),
              AddonsPopup("Chilli Chicken  (RS10) "),
              SizedBox(height: 10,),
              AddonsPopup("Prawn Chilli  (RS10) "),
              SizedBox(height: 10,),
              AddonsPopup("Fish Fry  (RS10) "),
              SizedBox(height: 20,),
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
                          offset: Offset(
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
    padding: EdgeInsets.only(left: 10, right: 10),
    decoration: BoxDecoration(
        color: Color(0XFFF5F5F5),
        border: Border.all(color: Color(0XFFE4E4E4))
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(AddonName,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 14,fontFamily: 'MR'),),
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