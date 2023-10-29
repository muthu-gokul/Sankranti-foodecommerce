import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodecommerce/utils/colorUtil.dart';
import 'package:foodecommerce/utils/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../api/ApiManager.dart';
import '../../models/parameterMode.dart';
import '../../notifier/utils/apiUtils.dart';
import '../../styles/constants.dart';
import '../../styles/style.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/bottomPainter.dart';
import '../../widgets/innerShadowTBContainer.dart';
import '../../widgets/shimmer.dart';
import '../HomePage/Cartpage.dart';
import 'OrderDeliveryDetails.dart';

class MYOrderDetails extends StatefulWidget {
  VoidCallback voidCallback;
  MYOrderDetails({required this.voidCallback});

  @override
  _MYOrderDetailsState createState() => _MYOrderDetailsState();
}

class _MYOrderDetailsState extends State<MYOrderDetails> {

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

  @override
  void initState() {
    loadOrders();
    super.initState();
  }

  RxBool isLoading=RxBool(false);
  RxList onGoingOrders=RxList();
  RxList completedOrders=RxList();

  @override
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
                alignment: Alignment.topCenter,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Visibility(
                        visible: isLoading.value,
                        child: Container(
                          height: height,
                          width: width,
                          color: Colors.white,
                          child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              enabled: true,
                              child: ListView(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                //  mainAxisSize: MainAxisSize.min,
                                children: [
                                  const BannerPlaceholder(),
                                  TitlePlaceholder(width: width),
                                  const SizedBox(height: 16.0),
                                  const ContentPlaceholder(
                                    lineType: ContentLineType.threeLines,
                                  ),
                                  const SizedBox(height: 16.0),
                                  const TitlePlaceholder(width: 200.0),
                                  const SizedBox(height: 16.0),
                                  const ContentPlaceholder(
                                    lineType: ContentLineType.twoLines,
                                  ),
                                  const SizedBox(height: 16.0),
                                  const TitlePlaceholder(width: 200.0),
                                  const SizedBox(height: 16.0),
                                  const ContentPlaceholder(
                                    lineType: ContentLineType.twoLines,
                                  ),
                                ],
                              )
                          ),
                        ),

                      ),),
                      Container(
                        height: 60,
                        margin:
                        const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  //loadOrders();
                                  widget.voidCallback();
                                },
                                child: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.transparent,
                                    alignment: Alignment.centerLeft,
                                    child: const Icon(Icons.menu_rounded,color: Colors.grey,size: 32,)
                                )
                            ),
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
                        margin: const EdgeInsets.only(left: 10.0,right: 10.0,),
                        padding: const EdgeInsets.only(left: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(image: AssetImage('assets/images/landingPage/orderHistory.png'),fit: BoxFit.cover)
                        ),
                        child:  Text('My Orders',style: TextStyle(fontFamily: 'RB',fontSize: 18,color: ColorUtil.thWhite,letterSpacing: 0.1)),
                      ),
                      const SizedBox(height:20,),
                      Container(
                          margin: const EdgeInsets.only(left: 10.0,right: 10),
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: ColorUtil.primary,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text('Ongoing Orders',style:ts18(ColorUtil.themeBlack,fontfamily: 'RB',),)
                      ),
                      Obx(() =>  Visibility(
                        visible: onGoingOrders.isNotEmpty,
                        replacement: Container(
                            margin: const EdgeInsets.only(top: 20,bottom: 20),
                            alignment: Alignment.center,
                            child: Text("No Orders...",style: TextStyle(fontFamily: 'MM',fontSize: 20,color: ColorUtil.themeColor),)
                        ),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: onGoingOrders.length,
                          shrinkWrap: true,
                          itemBuilder: (ctx,i){
                            return Container(
                              width: width,
                              margin: const EdgeInsets.only(left: 10.0,right: 10.0,top: 15),
                              padding:const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                // borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.white,
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey)
                                  )
                              ),
                              child: Row(
                                crossAxisAlignment:CrossAxisAlignment.center,
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    mainAxisAlignment:MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RichText(
                                          text:  TextSpan(
                                              text: "Order#:  ",
                                              style: const TextStyle(fontFamily:'RR',fontSize: 15,color: Colors.black,letterSpacing:  0.1),
                                              children: [
                                                TextSpan(text: "${onGoingOrders[i]['OrderNumber']}", style: const TextStyle(fontFamily:'RB',fontSize: 16,color: Colors.black,letterSpacing:  0.1),),
                                              ]
                                          )
                                      ),
                                      const SizedBox(height: 5,),
                                      RichText(
                                          text:  TextSpan(
                                              text: "Total Items:  ",
                                              style: const TextStyle(fontFamily:'RR',fontSize: 15,color: Colors.black,letterSpacing:  0.1),
                                              children: [
                                                TextSpan(text: "${onGoingOrders[i]['TotalItems']}", style: const TextStyle(fontFamily:'RB',fontSize: 16,color: Colors.black,letterSpacing:  0.1),),
                                              ]
                                          )
                                      ),
                                      const SizedBox(height: 5,),
                                      RichText(
                                          text: TextSpan(
                                              text: "Grand Total: ",
                                              style: const TextStyle(fontFamily:'RR',fontSize: 15,color: Colors.black,letterSpacing:  0.1),
                                              children: [
                                                TextSpan(text: "${MyConstants.rupeeString} ${onGoingOrders[i]['GrandTotalAmount']}", style: const TextStyle(fontFamily:'RB',fontSize: 16,color: Colors.black,letterSpacing:  0.1),),
                                              ]
                                          )
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (ctx) =>OrderDeliveryDetails(
                                        orderId: onGoingOrders[i]['OrderId'],
                                      )));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(25,15,25,15),
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
                                  ),
                                  /*Column(
                                children: [
                                  Container(
                                    child: Text("1X",style: TextStyle( fontFamily: 'RB',fontSize: 16,color:ColorUtil.thBlack,letterSpacing: 0.1),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text('Cancel', style: TextStyle(fontFamily: 'RM',fontSize: 16,color: Colors.redAccent, letterSpacing: 0.1),
                                  ),
                                ],
                              )*/
                                ],
                              ),
                            );
                          },
                        ),
                      ),),

                      const SizedBox(height:20,),
                      Container(
                          margin: const EdgeInsets.only(left: 10.0,right: 10),
                          padding: const EdgeInsets.fromLTRB(10,5,10,5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorUtil.primary,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Row(
                            children: [
                              Text('Previous Orders',style:ts18(ColorUtil.themeBlack,fontfamily: 'RB',),),
                              const Spacer(),
                              GestureDetector(
                                onTap: () async{
                                  showDateRangePicker(
                                      context: context,
                                      firstDate: DateTime(2023),
                                      lastDate: DateTime(2050)
                                  ).then((value){
                                    if(value!=null){
                                      print("$value ${value.start} ${value.end}");
                                      loadOrders(
                                        fromDate: value.start,
                                        toDate: value.end
                                      );
                                    }
                                  });
                                },
                                child: Container(
                                    height: 35,
                                    width: 35,
                                    color: Colors.transparent,
                                    alignment: Alignment.center,
                                    child: Icon(Icons.date_range_rounded,color: ColorUtil.themeBlack,)
                                ),
                              )
                            ],
                          )
                      ),
                      Obx(() =>  Visibility(
                        visible: completedOrders.isNotEmpty,
                        replacement: Container(
                            margin: const EdgeInsets.only(top: 50),
                            alignment: Alignment.center,
                            child: Text("No Orders...",style: TextStyle(fontFamily: 'MM',fontSize: 20,color: ColorUtil.themeColor),)
                        ),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: completedOrders.length,
                          shrinkWrap: true,
                          itemBuilder: (ctx,i){
                            return GestureDetector(
                              onTap: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (ctx) =>const OrderDeliveryDetails()));
                              },
                              child: Container(
                                width: width,
                                margin: const EdgeInsets.only(left: 10.0,right: 10.0,top: 15),
                                padding:const EdgeInsets.all(10.0),
                                decoration: const BoxDecoration(
                                  // borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white,
                                    border: Border(
                                        bottom: BorderSide(color: Colors.grey)
                                    )
                                ),
                                child: Row(
                                  crossAxisAlignment:CrossAxisAlignment.center,
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("${completedOrders[i]['OrderDate']}",
                                          style: const TextStyle(fontFamily:'RB',fontSize: 16,color: Colors.black,letterSpacing:  0.1),
                                        ),
                                        const SizedBox(height: 5,),
                                        RichText(
                                            text:  TextSpan(
                                                text: "Order#:  ",
                                                style: const TextStyle(fontFamily:'RR',fontSize: 15,color: Colors.black,letterSpacing:  0.1),
                                                children: [
                                                  TextSpan(text: "${completedOrders[i]['OrderNumber']}", style: const TextStyle(fontFamily:'RB',fontSize: 16,color: Colors.black,letterSpacing:  0.1),),
                                                ]
                                            )
                                        ),
                                        const SizedBox(height: 5,),
                                        RichText(
                                            text:  TextSpan(
                                                text: "Total Items:  ",
                                                style: const TextStyle(fontFamily:'RR',fontSize: 15,color: Colors.black,letterSpacing:  0.1),
                                                children: [
                                                  TextSpan(text: "${completedOrders[i]['TotalItems']}", style: const TextStyle(fontFamily:'RB',fontSize: 16,color: Colors.black,letterSpacing:  0.1),),
                                                ]
                                            )
                                        ),
                                        const SizedBox(height: 5,),
                                        RichText(
                                            text: TextSpan(
                                                text: "Grand Total: ",
                                                style: const TextStyle(fontFamily:'RR',fontSize: 15,color: Colors.black,letterSpacing:  0.1),
                                                children: [
                                                  TextSpan(text: "${MyConstants.rupeeString} ${completedOrders[i]['GrandTotalAmount']}", style: const TextStyle(fontFamily:'RB',fontSize: 16,color: Colors.black,letterSpacing:  0.1),),
                                                ]
                                            )
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (ctx) =>OrderDeliveryDetails(
                                          orderId: completedOrders[i]['OrderId'],
                                        )));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(25,15,25,15),
                                        decoration: BoxDecoration(
                                            color: ColorUtil.themeColor,
                                            borderRadius: BorderRadius.circular(25)
                                          // shape: BoxShape.circle
                                        ),
                                        child: Text(
                                          'View',
                                          style: TextStyle(
                                              fontFamily: 'RM',
                                              fontSize: 16,
                                              color: ColorUtil.primaryColor,
                                              letterSpacing: 0.1),
                                        ),
                                      ),
                                    ),
                                    /*Column(
                                  children: [
                                    Container(
                                      child: Text("1X",style: TextStyle( fontFamily: 'RB',fontSize: 16,color:ColorUtil.thBlack,letterSpacing: 0.1),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text('Cancel', style: TextStyle(fontFamily: 'RM',fontSize: 16,color: Colors.redAccent, letterSpacing: 0.1),
                                    ),
                                  ],
                                )*/
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),),
                      const SizedBox(
                        height: 90,
                      ),
                    ],
                  ),
                ),


              ),
            ),
          ],
        ));
  }


  void loadOrders({DateTime? fromDate,DateTime? toDate}) async{
    isLoading.value=true;
    onGoingOrders.clear();
    completedOrders.clear();
    List<ParameterModel> params= await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: "RB_Billing_GetCustomerBillTrackOrderDetail"));
    params.add(ParameterModel(Key: "FromDate", Type: "String", Value: DateFormat(MyConstants.dbDateFormat).format(fromDate??DateTime.now())));
    params.add(ParameterModel(Key: "ToDate", Type: "String", Value: DateFormat(MyConstants.dbDateFormat).format(toDate??DateTime.now())));
    ApiManager.GetInvoke(params,needInputJson: true).then((value){
      debugPrint("$value");
      //isLoading.value=false;
      Timer(const Duration(seconds: 1), () {
        isLoading.value=false;
      });
      if(value[0]){
        var response=json.decode(value[1]);
        List table=response['Table'];
        onGoingOrders.value=table.where((element) => element['IsTrackOrder']).toList();
        completedOrders.value=table.where((element) => !element['IsTrackOrder']).toList();
      }
      else{
      }
    });
  }


}

addRemoveBtn(Widget icon) {
  return Container(
    height: 25,
    width: 25,
    decoration: BoxDecoration(
        color: const Color(0xffF5F4F2), borderRadius: BorderRadius.circular(5)),
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
        icon: const Icon(Icons.clear),
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
      icon: const Icon(Icons.arrow_back),
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



