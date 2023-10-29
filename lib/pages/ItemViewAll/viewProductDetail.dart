import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:foodecommerce/notifier/Billing/outletDetail.dart';
import 'package:foodecommerce/utils/colorUtil.dart';
import 'package:foodecommerce/utils/constants.dart';
import 'package:foodecommerce/widgets/customCheckBox.dart';
import 'package:get/get.dart';
import 'package:basic_utils/basic_utils.dart' as utils;
import 'package:scutiwidgets/authenticationPages/constants.dart';
import '../../notifier/Billing/billingController.dart';
import '../../notifier/Billing/cartNotifier.dart';
import '../../styles/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/bottomPainter.dart';
import '../../widgets/companySettingsTextField.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/customNetworkImg.dart';
import '../../widgets/innerShadowTBContainer.dart';
import '../HomePage/Cartpage.dart';

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

  RxBool imageReload=RxBool(false);
  @override
  void initState() {
    print("filterproduct ${filterproduct.length}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height-topPadding;
    width2 = width - 16;
    height2 = height - 16;
    gridWidth = width - 30;
    return SafeArea(
      child: Scaffold(
      backgroundColor: ColorUtil.themeWhite,
          body: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      const SizedBox(width: 10,),
                      ArrowBack(
                        onTap: (){
                          Get.back();
                        },
                      ),
                      Container(
                        width: SizeConfig.screenWidth! - 60,
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Obx(() => RichText(
                          text: TextSpan(
                            text: getCategoryName(),
                            style: const TextStyle(fontFamily: 'MB', fontSize:16, color: Color(0xff000000),),
                            children: <TextSpan>[
                              TextSpan(text: '${c_CategoryId.value}', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 0)),
                            ],
                          ),
                        )
                       )
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  /*Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(left: 10.0,),
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
                  ),*/
                  Obx(() => InnerShadowTBContainer(
                    height: height - 125,
                    width: width,
                    //  clipBehavior: Clip.antiAlias,
                    child: isGridView
                        ? ListView.builder(
                      //   physics: NeverScrollableScrollPhysics(),
                        itemCount: filterproduct.length,
                        shrinkWrap: true,
                        itemBuilder: (ctx, i) {
                          return Container(
                            //height: 120,
                            width: width,
                            decoration: BoxDecoration(
                              //border: Border.all(color: const Color(0XFFE4E4E4)),
                              borderRadius: BorderRadius.circular(8),
                              color:  ColorUtil.themeColorBg,
                            ),
                            clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.fromLTRB(10,10,10,i==filterproduct.length-1?100:0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  //   crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Obx(() => Container(
                                      // width: width * 0.30,
                                      height: 80,
                                      width: 100,
                                      clipBehavior: Clip.antiAlias,
                                      margin: const EdgeInsets.only(left: 0, right: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.transparent,
                                      ),
                                      alignment: Alignment.center,
                                      child:Stack(
                                        children: [

                                          Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                // width: width * 0.30,
                                                height: 60,
                                                width: 60,
                                                clipBehavior: Clip.antiAlias,
                                                margin: const EdgeInsets.only(left: 0, right: 0),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: ColorUtil.themeColorBg2,
                                                ),
                                                alignment: Alignment.center,
                                              )
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: imageReload.value?Container(): CustomNetworkImg(
                                              dbFilePath: filterproduct[i]['ProductLogo'],
                                              directoryPath: MyConstants.imgPath,
                                              height: 80,
                                              width: 80,
                                              loaderHeight: 80,
                                              loaderWidth: 80,
                                            ),
                                          )
                                        ],
                                      )
                                    )),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(utils.StringUtils.capitalize(filterproduct[i]['ProductName']??""),
                                            style: TextStyle(fontFamily: 'MB', color: ColorUtil.themeBlack, fontSize: 15),
                                          ),
                                          const SizedBox(height: 8,),
                                          Row(
                                            mainAxisSize:MainAxisSize.min,
                                            children: [
                                              ProductTypeCircle(type:filterproduct[i]['ProductType']??"",),
                                              const SizedBox(width: 10,),
                                              Visibility(
                                                visible: !filterproduct[i]['IsSeveralProduct'],
                                                child: Text('${MyConstants.rupeeString} ${filterproduct[i]['Price']}',
                                                  style: TextStyle(fontFamily: 'MB', color: ColorUtil.themeBlack, fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 5,),
                                    Obx(() => Stack(
                                      alignment: addBtnRefresh.value? Alignment.center:Alignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            if(filterproduct[i]['IsSeveralProduct']){
                                              Addons(context);
                                            }
                                            else{
                                              onProductClick(filterproduct[i]);
                                            }

                                          },
                                          child: Container(
                                            width: 80,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: ColorUtil.themeColor,
                                                borderRadius:  BorderRadius.circular(10)
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Add",
                                                style: ts16(ColorUtil.primary,fontfamily: 'MB'),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: checkCurrentProduct(filterproduct[i]['ProductId']),
                                          child: Container(
                                            height: 42,
                                            width: 120,
                                            decoration: BoxDecoration(
                                                color:ColorUtil.themeColorBg,
                                                borderRadius:  BorderRadius.circular(5)
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                addRemoveBtn(Icon(Icons.remove,color: ColorUtil.themeColor,size: 25,),
                                                    onTap: (){
                                                      addBtnHandler(filterproduct[i]['ProductId'],isAdd: false);
                                                    },
                                                  isAdd: false
                                                ),
                                                Text("${getCurrentProductQty(filterproduct[i]['ProductId'])}",
                                                  style: ts16(ColorUtil.primaryTextColor4,fontfamily: 'MB'),
                                                ),
                                                addRemoveBtn(Icon(Icons.add,color: ColorUtil.primaryColor,size: 25,),
                                                    onTap: (){
                                                      addBtnHandler(filterproduct[i]['ProductId'],isAdd: true);
                                                    }
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ))
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

                               /* Obx(() => Positioned(
                                  bottom: 0,
                                  right: addBtnRefresh.value? 0:0,
                                  child: Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          if(filterproduct[i]['IsSeveralProduct']){
                                            Addons(context);
                                          }
                                          else{
                                            onProductClick(filterproduct[i]);
                                          }

                                        },
                                        child: Container(
                                          width: gridWidth*0.31,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: ColorUtil.primaryColor,
                                              borderRadius:
                                              const BorderRadius.only(
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
                                      Visibility(
                                        visible: checkCurrentProduct(filterproduct[i]['ProductId']),
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
                                              addRemoveBtn(Icon(Icons.remove,color: ColorUtil.primaryColor,size: 25,),
                                                  onTap: (){
                                                    addBtnHandler(filterproduct[i]['ProductId'],isAdd: false);
                                                  }
                                              ),
                                              Text("${getCurrentProductQty(filterproduct[i]['ProductId'])}",style: TSWhite166,),
                                              addRemoveBtn(Icon(Icons.add,color: ColorUtil.primaryColor,size: 25,),
                                                  onTap: (){
                                                    addBtnHandler(filterproduct[i]['ProductId'],isAdd: true);
                                                  }
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))*/
                              ],
                            ),
                          );
                        })
                        :Padding(padding: const EdgeInsets.only(left: 10, right: 10,bottom: 0),
                        child: SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10,),
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 20,
                              children: filterproduct.asMap()
                                  .map((key, value) => MapEntry(
                                  key,
                                  Container(
                                    height: 200,
                                    width: gridWidth * 0.5,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                    margin: EdgeInsets.only(bottom: key==filterproduct.length-1?20:0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: SizeConfig.screenWidth,
                                          height: 120,
                                          child: Stack(
                                            children: [
                                              Obx(() => Container(
                                                // width: width * 0.30,
                                                height: 100,
                                                width:  gridWidth * 0.5,
                                                clipBehavior: Clip.antiAlias,
                                                margin: const EdgeInsets.only(left: 10, right: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  color: Colors.white,
                                                ),
                                                alignment: Alignment.center,
                                                child:imageReload.value?Container(): CustomNetworkImg(
                                                  dbFilePath: value['ProductLogo'],
                                                  directoryPath: MyConstants.imgPath,
                                                  height: 100,
                                                  loaderHeight: 100,
                                                  loaderWidth: 100,
                                                ),
                                              )),
                                            /*  Positioned(
                                                top: 10,
                                                left: 10,
                                                child: Container(
                                                  width: 50,
                                                  height: 20,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(2.0),
                                                    color: Colors.white,
                                                  ),
                                                  child: Text(value['FavVegNon'],
                                                    style: TextStyle(fontFamily: 'RR', fontSize: 12, color: Color(value['FavColorCatg'])),
                                                  ),
                                                ),
                                              ),*/
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10,right: 10),
                                          child: Text(utils.StringUtils.capitalize(value['ProductName']??""),
                                            style: TextStyle(fontFamily: 'RR', color: ColorUtil.themeBlack, fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                                          child: Visibility(
                                            visible: !value['IsSeveralProduct'],
                                            child: Text('${value['Price']}',
                                              style: TextStyle(fontFamily: 'RB', color: ColorUtil.themeBlack, fontSize: 16),
                                            ),
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
                  ),)
                ],),
              Positioned(
                bottom: 60,
                right: 20,
                child: DialogExample(imageReload: imageReload,),
              ),
              Positioned(bottom: -15, child: BottomNavi()),
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
                        width: 60,
                        height: 60,
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorUtil.themeColor,
                          boxShadow: [
                            BoxShadow(
                              color: ColorUtil.themeColor.withOpacity(0.3),
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
                          alignment: Alignment.center,
                          children: [
                             Icon(
                              Icons.shopping_cart,
                              color: Color(0xffffffff),
                              size: 30,
                            ),
                            Positioned(
                                right: 10,
                                top: 5,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Obx(() => Text("${c_orderDetail.value!.productList!.length}",style: TextStyle(fontFamily: 'RB'),))
                                ),
                            ),
                          ],
                        ))
                ),
              ),
            ],
          )
      ),
    );
  }
}



class DialogExample extends StatelessWidget {
  RxBool imageReload;
  DialogExample({super.key,required this.imageReload});

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
          content: SizedBox(
            height: 250,
            width: SizeConfig.screenWidth!*0.7,
            child:ListView.builder(
              itemCount: filtermainCategory.length,
              itemBuilder: (ctx,i){
                return GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                    updateMainCategory(i);
                    imageReload.value=true;
                    Timer(Duration(milliseconds: 100), () {
                      imageReload.value=false;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            utils.StringUtils.capitalize(filtermainCategory[i].MainCategoryName??""),
                            style:filtermainCategory[i].MainCategory==c_CategoryId.value?
                            const TextStyle(fontFamily: 'RB', fontSize: 18, color: Colors.white,):
                            const TextStyle(fontFamily: 'RR', fontSize: 16, color: Colors.white,),
                          ),
                        ),
                        const SizedBox(width: 5,),
                        Text(
                          '${filtermainCategory[i].totalProducts}',
                          style:filtermainCategory[i].MainCategory==c_CategoryId.value?
                          const TextStyle(fontFamily: 'RB', fontSize: 20, color: Colors.white,):
                          const TextStyle(fontFamily: 'RR', fontSize: 16, color: Colors.white,),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
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
        decoration:  BoxDecoration(shape: BoxShape.circle, color: ColorUtil.primary),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.message_outlined,
              color: ColorUtil.themeColor,
              size: 20,
            ),
            Text(
              'Menu',
              style: TextStyle(
                fontFamily: 'MB',
                fontSize: 14,
                color: ColorUtil.themeColor,
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
                    'assets/images/foodimgs/Dessert.jpg',
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
                            'Chicken Biriyani',
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
              AddonsPopup("Chilli Chicken  (RS10) "),
              const SizedBox(height: 10,),
              AddonsPopup("Prawn Chilli  (RS10) "),
              const SizedBox(height: 10,),
              AddonsPopup("Fish Fry  (RS10) "),
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

class ProductTypeCircle extends StatelessWidget {
  final String type;
  const ProductTypeCircle({super.key,required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 21,
      width: 21,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey)
      ),
      child: Center(
        child: Container(
          height: 13,
          width: 13,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: type=="Veg"?Colors.green:type=="Non Veg"?Colors.red:Colors.orange
          ),
        ),
      ),
    );
  }
}
