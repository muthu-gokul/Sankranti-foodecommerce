import 'package:flutter/material.dart';
import 'package:foodecommerce/pages/ItemViewAll/viewProductDetail.dart';
import 'package:foodecommerce/utils/colorUtil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../notifier/themeNotifier.dart';
import '../../styles/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/bottomPainter.dart';
import '../../widgets/companySettingsTextField.dart';
import '../../widgets/innerShadowTBContainer.dart';
import '../HomePage/Cartpage.dart';




class ViewAllItems extends StatefulWidget {
  const ViewAllItems({Key? key}) : super(key: key);

  @override
  _ViewAllItemsState createState() => _ViewAllItemsState();
}

class _ViewAllItemsState extends State<ViewAllItems> {
  late  double width,height,width2,height2, gridWidth;
  // List<int> topSaleList=List.generate(20, (index) => index);
  ScrollController? silverController;
  int selectTopSale=0;
  bool isGridView=true;
  int selectAddRemove=-1;
  bool isFav=true;
  List<dynamic> FavItems=[
    {"FavImg":"assets/images/foodimgs/seaFood.jpg","FavItemName":"SEA Food","Rate":"250.00","FavVegNon":"Non-Veg","FavColorCatg":0xffFF0022,"FavSubtitle":"Comments"},
    {"FavImg":"assets/images/foodimgs/Pizza.jpg","FavItemName":"Pizza Maina","Rate":"59.00","FavVegNon":"Non-veg","FavColorCatg":0xffFF0022,"FavSubtitle":"Comments"},
    {"FavImg":"assets/images/foodimgs/icecream.jpg","FavItemName":"Ice Cream","Rate":"299.00","FavVegNon":"Veg","FavColorCatg":0xff007F11,"FavSubtitle":"Comments"},
    {"FavImg":"assets/images/foodimgs/Fullmeals.png","FavItemName":"Fresh Juice","Rate":"150.00","FavVegNon":"Veg","FavColorCatg":0xff007F11,"FavSubtitle":"Comments"},
    {"FavImg":"assets/images/foodimgs/milkcatg.jpg","FavItemName":"Milk Shake","Rate":"99.00","FavVegNon":"Veg","FavColorCatg":0xff007F11,"FavSubtitle":"Comments"},
    {"FavImg":"assets/images/foodimgs/biriyani.webp","FavItemName":"Chicken Biriyani","Rate":"140.00","FavVegNon":"Non-Veg","FavColorCatg":0xffFF0022,"FavSubtitle":"Comments"},
    {"FavImg":"assets/images/foodimgs/tikka.jpg","FavItemName":"Panner Tikka","Rate":"170.00","FavVegNon":"Veg","FavColorCatg":0xff007F11,"FavSubtitle":"Comments"},
    {"FavImg":"assets/images/foodimgs/milkshake.jpg","FavItemName":"Choco Dessert","Rate":"80.00","FavVegNon":"Veg","FavColorCatg":0xff007F11,"FavSubtitle":"Comments"},
    {"FavImg":"assets/images/foodimgs/Fullmeals.png","FavItemName":"Lunch","Rate":"199.00","FavVegNon":"Non-veg","FavColorCatg":0xffFF0022,"FavSubtitle":"Meals"},
    {"FavImg":"assets/images/foodimgs/PannerMasala.png","FavItemName":"Panner Masala","Rate":"250.00","FavVegNon":"Veg","FavColorCatg":0xff007F11,"FavSubtitle":"Comments"},
    {"FavImg":"assets/images/foodimgs/Tiffen.png","FavItemName":"Mini Tiffen","Rate":"130.00","FavVegNon":"Veg","FavColorCatg":0xff007F11,"FavSubtitle":"Morning Special"},
    {"FavImg":"assets/images/foodimgs/dossa.png","FavItemName":"Dossa Special","Rate":"99.00","FavVegNon":"Veg","FavColorCatg":0xff007F11,"FavSubtitle":"Evening Special"},
    {"FavImg":"assets/images/foodimgs/Grill.jpg","FavItemName":"Grill Chicken","Rate":"399.00","FavVegNon":"Non-veg","FavColorCatg":0xffFF0022,"FavSubtitle":"InfuseGrill"},
  ];

  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    height2=height-16;
    gridWidth=width-30;
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          controller: silverController,
          // floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                elevation: 0,
                toolbarHeight: 60,
                backgroundColor: ColorUtil.primaryColor,
                leading: Container(),
                actions: [
                  Container(
                    width:SizeConfig.screenWidth ,
                    height: 120,
                    child: Stack(
                      children: [
                        Image.asset('assets/images/foodimgs/Fullmeals.png',fit: BoxFit.cover,width: SizeConfig.screenWidth,),
                        Container(
                          color: Colors.red.withOpacity(0.7),
                          height: 60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 25,),
                                decoration: BoxDecoration(
                                    color: Color(0xffEFF1F8),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Color(0xffD4D5D7))
                                ),
                                child: IconButton(onPressed: (){
                                  Get.back();
                                },
                                  icon: Icon(Icons.arrow_back_ios_sharp,color:ColorUtil.primaryColor,size: 20,),),
                              ),
                              Spacer(),
                              Text('INDIAN',style: TextStyle(color:Colors.white,fontSize: 18,fontFamily: 'RB'),),
                              Spacer(),
                              Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                // floating: true,
                pinned: true,
              ),
            ];
          },
          body: Stack(
            children: [
              Container(
                width: SizeConfig.screenWidth,
                color: Color(0xffF6F6F6),
                //  clipBehavior: Clip.antiAlias,
                padding: EdgeInsets.only(left: 15,right: 15,),
                child:InnerShadowTBContainer(
                    height: SizeConfig.screenHeight!-50,
                    width: SizeConfig.screenWidth!,
                    child:Container(
                      height: FavItems.length*120,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:FavItems.length ,
                          itemBuilder: (ctx,i){
                            return Container(
                              height: 275,
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffffffff),
                              ),
                              clipBehavior: Clip.antiAlias,
                              margin: EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewProductDetails()),);
                                    },
                                    child: Container(
                                      width: SizeConfig.screenWidth,
                                      height: 210,
                                      child: Stack(
                                        children: [
                                          Image.asset(FavItems[i]['FavImg'],fit: BoxFit.cover,width: SizeConfig.screenWidth,height: 210,),
                                          Positioned(
                                            top: 10,
                                            left: 10,
                                            child: Container(
                                              width: 60,
                                              height: 27,
                                              alignment: Alignment.center,
                                              decoration:BoxDecoration(
                                                borderRadius: BorderRadius.circular(2.0),
                                                color: Colors.white,
                                              ) ,
                                              child:  Text(FavItems[i]['FavVegNon'],style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(FavItems[i]['FavColorCatg']),),),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 10,
                                            right: 10,
                                            child: GestureDetector(
                                                onTap: (){
                                                  setState((){
                                                    isFav=!isFav;
                                                  });
                                                },
                                                child: Icon(Icons.favorite,size:37,color:isFav?Colors.white:Color(0xffFE0144),)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 65,
                                    width: SizeConfig.screenWidth!*0.9,
                                    // color: Colors.red,
                                    padding: EdgeInsets.only(left: 10,right: 10,),
                                    child: Row(
                                      crossAxisAlignment:CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          children: [
                                            Text(FavItems[i]['FavItemName'],style: TextStyle(fontFamily: 'RB',fontSize: 16,color: Colors.black,),),
                                            Text(FavItems[i]['FavSubtitle'],style: TextStyle(fontFamily: 'RR',fontSize: 14,color: Colors.black26,),),
                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment:CrossAxisAlignment.end,
                                          children: [
                                            Text(FavItems[i]['Rate'],style: TextStyle(fontFamily: 'RB',fontSize: 16,color:ColorUtil.primaryColor,),),
                                            Text('10 % Upto Offer',style: TextStyle(fontFamily: 'RR',fontSize: 14,color: Colors.black26,),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                      ),
                    )
                ),
              ),
              Positioned(
                  bottom: -15,
                  child: BottomNavi()
              ),
            ],
          ),
        ),
      ),
    );
  }
}
