import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import '../HomePage/Cartpage.dart';
import 'OrderDeliveryDetails.dart';

class MYOrderDetails extends StatefulWidget {
  VoidCallback voidCallback;
  MYOrderDetails({required this.voidCallback});

  @override
  _MYOrderDetailsState createState() => _MYOrderDetailsState();
}

class _MYOrderDetailsState extends State<MYOrderDetails> {
  @override
  late double width, height, width2, height2;
  bool openText = false;
  close() {
    Timer(animeDuration, () {
      setState(() {
        openText = false;
      });
    });
  }

  List<dynamic> FavItems = [
    {
      "FavImg": "assets/images/foodimgs/Tandoori-Prawns.jpg",
      "FavItemName": "Tandoori Prawns",
      "Rate": "250.00",
      "Reorder": "Reorder",
      "FavSubtitle": "01-07-2023 / 9:30 AM"
    },
    {
      "FavImg": "assets/images/foodimgs/Tandoori-Chicken-Full.jpg",
      "FavItemName": "Tandoori Chicken-Full",
      "Rate": "59.00",
      "Reorder": "Reorder",
      "FavSubtitle": "01-07-2023 / 9:30 AM"
    },
    {
      "FavImg": "assets/images/foodimgs/ice-cream-pistachio.jpg",
      "FavItemName": "Ice-cream pistachio",
      "Rate": "299.00",
      "Reorder": "Reorder",
      "FavSubtitle": "01-07-2023 / 9:30 AM"
    },
    {
      "FavImg": "assets/images/foodimgs/cold-press-juice-pomegranate.jpg",
      "FavItemName": "Pomegranate Juice",
      "Rate": "150.00",
      "Reorder": "Reorder",
      "FavSubtitle": "01-07-2023 / 9:30 AM"
    },
    {
      "FavImg": "assets/images/foodimgs/STRAWBERRY-LASSI.jpg",
      "FavItemName": "STRAWBERRY-LASSI",
      "Rate": "99.00",
      "Reorder": "Reorder",
      "FavSubtitle": "01-07-2023 / 9:30 AM"
    },
    {
      "FavImg": "assets/images/foodimgs/biriyani.webp",
      "FavItemName": "Chicken Biriyani",
      "Rate": "140.00",
      "Reorder": "Reorder",
      "FavSubtitle": "01-07-2023 / 9:30 AM"
    },
    {
      "FavImg": "assets/images/foodimgs/goat.jpg",
      "FavItemName": "Goat",
      "Rate": "999.00",
      "Reorder": "Reorder",
      "FavSubtitle": "01-07-2023 / 9:30 AM"
    },
  ];
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    width2 = width - 16;
    height2 = height - 16;

    SizeConfig().init(context);
    return SafeArea(
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: ColorUtil.themeColorBg,
              body: Container(
                height: height,
                width: width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        margin:
                        EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                 Get.back();
                                },
                                child: Container(
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: ColorUtil.themeColor,
                                      size: 30,
                                    ))),
                            // SizedBox(
                            //   width: 5,
                            // ),
                            //
                            // Spacer(),
                            // GestureDetector(
                            //     onTap: () {
                            //       // method to show the search bar
                            //       showSearch(
                            //           context: context,
                            //           // delegate to customize the search bar
                            //           delegate: CustomSearchDelegate());
                            //     },
                            //     child: Icon(
                            //       Icons.search_sharp,
                            //       color: Colors.black,
                            //       size: 30,
                            //     )),
                          ],
                        ),
                      ),
                      Container(
                      width: SizeConfig.screenWidth,
                      height: 80,
                      alignment: Alignment.centerLeft,
                      clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.only(left: 10.0,right: 10.0,),
                          padding: EdgeInsets.only(left: 30),
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(image: AssetImage('assets/images/landingPage/orderHistory.png'),fit: BoxFit.cover)
                          ),
                          child:  Text('My Orders',style: TextStyle(fontFamily: 'RB',fontSize: 18,color: ColorUtil.thWhite,letterSpacing: 0.1)),
                      ),
                      SizedBox(height:20,),
                      Container(
                          margin: EdgeInsets.only(left: 10.0,),
                          alignment: Alignment.centerLeft,
                          child: Text('Ongoing Orders',style:ts18(text1,fontfamily: 'RB',),)
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (ctx) =>OrderDeliveryDetails()));
                        },
                        child: Container(
                          width: width,
                          margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 15),
                          padding:const EdgeInsets.all(10.0),
                           decoration: BoxDecoration( borderRadius:
                            BorderRadius.circular(5.0),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment:CrossAxisAlignment.center,
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    clipBehavior:Clip.antiAlias,
                                    alignment:Alignment.center,
                                    decoration: BoxDecoration(
                                        color:Color(0XFFFED2DF),
                                        borderRadius:BorderRadius.circular(5)),
                                    child: Image.asset('assets/images/foodimgs/CURRY-DOSA-GOAT.jpg',height: 70, fit: BoxFit.cover,  ),
                                  ),
                                  SizedBox(width: 20,),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      children: [
                                        Text( 'Dossa Special', style: TextStyle(fontFamily:'RB',fontSize: 16,color: Colors.black,letterSpacing:  0.1),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text('Sankranti, Syed Alvi Rd ', style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Colors.black, letterSpacing: 0.1),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text('99.00 ', style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Colors.black, letterSpacing: 0.1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Container(
                                        child: Text("1X",style: TextStyle( fontFamily: 'RB',fontSize: 16,color:ColorUtil.thBlack,letterSpacing: 0.1),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text('Cancel', style: TextStyle(fontFamily: 'RM',fontSize: 16,color: Colors.redAccent, letterSpacing: 0.1),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 15,),
                              Container(
                              width: SizeConfig.screenWidth,
                              height: 1,
                              decoration: BoxDecoration(
                              border: Border.all(color: ColorUtil.grey1,style: BorderStyle.solid),
                              ),
                              ),
                              SizedBox(height: 10,),
                              Row(
                                crossAxisAlignment:CrossAxisAlignment.center,
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 70,
                                  child: Image.asset('assets/images/landingPage/Take-Away.png',width: 49, fit: BoxFit.cover,  )),
                                  SizedBox(width: 20,),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      children: [
                                        Text( 'Your order is on the way', style: TextStyle(fontFamily:'RB',fontSize: 16,color: Colors.black,letterSpacing:  0.1),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text('Will arrive in 20 mins ', style: TextStyle(fontFamily: 'RR',fontSize: 14,color:ColorUtil.grey2, letterSpacing: 0.1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(25,15,25,15),
                                    decoration: BoxDecoration(
                                        color: ColorUtil.themeColor,
                                        borderRadius: BorderRadius.circular(25)
                                      // shape: BoxShape.circle
                                    ),
                                    child: Text(
                                      'Track',
                                      style: TextStyle(
                                          fontFamily: 'RM',
                                          fontSize: 14,
                                          color: ColorUtil.primaryColor,
                                          letterSpacing: 0.1),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height:20,),
                      Container(
                          margin: EdgeInsets.only(left: 10.0,),
                          alignment: Alignment.centerLeft,
                          child: Text('Previous Orders',style:ts18(text1,fontfamily: 'RB',),)
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InnerShadowTBContainer(
                          height: SizeConfig.screenHeight! - 124,
                          width: width ,
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: FavItems.length,
                              itemBuilder: (ctx, i) {
                                return Column(
                                  children: [
                                    // SizedBox(height: 20,),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    OrderDeliveryDetails()));
                                      },
                                      child: Container(
                                        width: width,
                                        margin: EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 15),
                                        padding:
                                        const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(
                                              5.0),
                                          color: Colors.white,
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color: Color(0xFFE1E7F3)
                                          //         .withOpacity(0.9),
                                          //     blurRadius:
                                          //         20.0, // soften the shadow
                                          //     spreadRadius:
                                          //         0.0, //extend the shadow
                                          //     offset: Offset(
                                          //       0.0, // Move to right 10  horizontally
                                          //       10.0, // Move to bottom 10 Vertically
                                          //     ),
                                          //   )
                                          // ],
                                          // border: Border.all(color:text1.withOpacity(0.2),),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:CrossAxisAlignment.center,
                                          // mainAxisAlignment:MainAxisAlignment .spaceBetween,
                                          children: [
                                            Container(
                                              height: 70,
                                              width: 70,
                                              clipBehavior:
                                              Clip.antiAlias,
                                              alignment:
                                              Alignment.center,
                                              decoration: BoxDecoration(
                                                  color:
                                                  Color(0XFFFED2DF),
                                                  borderRadius:
                                                  BorderRadius.circular(5)),
                                              child: Image.asset(FavItems[i]['FavImg'],height: 70, fit: BoxFit.cover,  ),
                                            ),
                                            SizedBox(width: 30,),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:CrossAxisAlignment.start,
                                                mainAxisAlignment:MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    FavItems[i]['FavItemName'], style: TextStyle(fontFamily:'RB',fontSize: 16,color: Colors.black,letterSpacing:  0.1),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    FavItems[i]['FavSubtitle'], style: TextStyle(fontFamily: 'RR',fontSize: 14,color:ColorUtil.grey2, letterSpacing: 0.1),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            Column(
                                              children: [
                                                Container(
                                                  child: Text(FavItems[i]['Rate'],style: TextStyle( fontFamily: 'RB',fontSize: 16,color:ColorUtil.thBlack,letterSpacing: 0.1),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  FavItems[i]['Reorder'], style: TextStyle(fontFamily:'RM',fontSize: 16,color: ColorUtil.primaryColor,letterSpacing:  0.1),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 90,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(bottom: -15, child: BottomNavi()),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartPage()),
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
                            color:
                            ColorUtil.themeColor.withOpacity(0.3),
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
        ));
  }
}

addRemoveBtn(Widget icon) {
  return Container(
    height: 25,
    width: 25,
    decoration: BoxDecoration(
        color: Color(0xffF5F4F2), borderRadius: BorderRadius.circular(5)),
    child: Center(
      child: icon,
    ),
  );
}

class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying
  List<String> searchTerms = [
    "Panner Masala",
    "Indians",
    "Biriyani",
    "Chicken Roll",
    "Ice Cream",
  ];

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
