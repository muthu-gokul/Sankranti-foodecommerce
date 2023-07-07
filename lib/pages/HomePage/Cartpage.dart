import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../notifier/themeNotifier.dart';
import '../../styles/constants.dart';
import '../../styles/style.dart';
import '../../utils/colorUtil.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/bottomPainter.dart';
import '../../widgets/companySettingsTextField.dart';
import '../navHomeScreen.dart';
import 'OrderSuccess.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  late double width, height, width2, height2;
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    width2 = width - 16;
    height2 = height - 16;
    SizeConfig().init(context);
    return SafeArea(
        child:Scaffold(
            backgroundColor: Color(0xffF6F6F6),
            body: Stack(
              children: [
                Container(
                  height: height,
                  width: width,
                  child: ListView(
                   physics: BouncingScrollPhysics(),
                    children: [
                      Container(
                        height: 60,
                        child: Container(
                          margin: EdgeInsets.only(left:10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                              SizedBox(width: 30,),
                              Container(
                                alignment: Alignment.center,
                                child: Text('Cart',style: TextStyle(fontFamily: 'RB',fontSize: 20,color: Colors.black,letterSpacing: 0.1),),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height:10,),
                      Container(
                          margin: EdgeInsets.only(left: 10.0,),
                          alignment: Alignment.centerLeft,
                          child: Text('3 Items in the cart',style:ts18(text1,fontfamily: 'RB',),)
                      ),
                      Container(
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
                                Container(
                                  child: Row(
                                    children: [
                                      addRemoveBtn(Icon(
                                        Icons.remove,
                                        color: ColorUtil.thBlack,
                                        size: 20,
                                      )),
                                      Container(
                                      width: 40,
                                        child: Center(
                                          child: Text(
                                            "1",
                                             style: ts18(ColorUtil.themeColor,fontfamily: 'RB'),
                                          ),
                                        ),
                                      ),
                                      addRemoveBtn(Icon(
                                        Icons.add,
                                        color: ColorUtil.thBlack,
                                        size: 20,
                                      )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
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
                                  child: Image.asset('assets/images/foodimgs/Grill.jpg',height: 70, fit: BoxFit.cover,  ),
                                ),
                                SizedBox(width: 20,),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    mainAxisAlignment:MainAxisAlignment.center,
                                    children: [
                                      Text( 'Grill Chicken', style: TextStyle(fontFamily:'RB',fontSize: 16,color: Colors.black,letterSpacing:  0.1),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('Sankranti, Syed Alvi Rd ', style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Colors.black, letterSpacing: 0.1),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('599.00 ', style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Colors.black, letterSpacing: 0.1),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  child: Row(
                                    children: [
                                      addRemoveBtn(Icon(
                                        Icons.remove,
                                        color: ColorUtil.thBlack,
                                        size: 20,
                                      )),
                                      Container(
                                        width: 40,
                                        child: Center(
                                          child: Text(
                                            "1",
                                            style: ts18(ColorUtil.themeColor,fontfamily: 'RB'),
                                          ),
                                        ),
                                      ),
                                      addRemoveBtn(Icon(
                                        Icons.add,
                                        color: ColorUtil.thBlack,
                                        size: 20,
                                      )),
                                    ],
                                  ),
                                ),
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
                            AdonsDtls('Chicken-Quater','(149.00)'),
                            SizedBox(height: 10,),
                            AdonsDtls('Chicken-Half', '(199.00)'),
                            SizedBox(height: 10,),
                            AdonsDtls('Chicken-Full','(599.00)'),
                          ],
                        ),
                      ),
                      Container(
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
                                  child: Image.asset('assets/images/foodimgs/fish.jpg',height: 70, fit: BoxFit.cover,  ),
                                ),
                                SizedBox(width: 20,),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    mainAxisAlignment:MainAxisAlignment.center,
                                    children: [
                                      Text( 'Fish Fry', style: TextStyle(fontFamily:'RB',fontSize: 16,color: Colors.black,letterSpacing:  0.1),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('Sankranti, Syed Alvi Rd ', style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Colors.black, letterSpacing: 0.1),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('299.00 ', style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Colors.black, letterSpacing: 0.1),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  child: Row(
                                    children: [
                                      addRemoveBtn(Icon(
                                        Icons.remove,
                                        color: ColorUtil.thBlack,
                                        size: 20,
                                      )),
                                      Container(
                                        width: 40,
                                        child: Center(
                                          child: Text(
                                            "1",
                                            style: ts18(ColorUtil.themeColor,fontfamily: 'RB'),
                                          ),
                                        ),
                                      ),
                                      addRemoveBtn(Icon(
                                        Icons.add,
                                        color: ColorUtil.thBlack,
                                        size: 20,
                                      )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:20,),
                      Container(
                        padding:
                        const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Bill Summary',style:ts18(text1,fontfamily: 'RB',fontsize: 24),),
                            Container(
                              margin:EdgeInsets.only(left: 10),
                              width: SizeConfig.screenWidth!-180,
                              height: 1,
                              color: Color(0XffE4E4E4),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:10,),
                     BillSummery('Subtotal', '997.00'),
                     BillSummery('Tax', '18.00'),
                     BillSummery('Savings', '10.00'),
                     BillSummery('Discount', '5.00'),
                     BillSummery('Delivery Charge', 'Free'),
                      Container(
                        margin: EdgeInsets.only(left: 10,right: 10,bottom: 15),
                        //   color: Colors.red,
                        width: SizeConfig.screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total payable',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'RB',
                                      color: ColorUtil.thBlack,
                                    ),
                                  ),
                                  Text(
                                    '1000.00',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'RB',
                                      color: ColorUtil.thBlack,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:60,),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 60,
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorUtil.themeColor,
                    ),
                    alignment: Alignment.center,
                    child: Text("Confirm Order",style: TextStyle(fontFamily: 'RB',fontSize:18,color: ColorUtil.primaryColor,letterSpacing: 0.1),),
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: GestureDetector(
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => Masterpage()),
                //       );
                //     },
                //     child: Container(
                //         width: 60,
                //         height: 60,
                //         alignment: Alignment.center,
                //         margin: EdgeInsets.only(bottom: 25),
                //         decoration: BoxDecoration(
                //           shape: BoxShape.circle,
                //           color: ColorUtil.themeColor,
                //           boxShadow: [
                //             BoxShadow(
                //               color: ColorUtil.themeColor.withOpacity(0.3),
                //               blurRadius: 25.0, // soften the shadow
                //               spreadRadius: 5.0, //extend the shadow
                //               offset: Offset(
                //                 0.0, // Move to right 10  horizontally
                //                 10.0, // Move to bottom 10 Vertically
                //               ),
                //             )
                //           ],
                //         ),
                //         child: Text(
                //           '+',
                //           style: TextStyle(
                //               fontFamily: 'RB',
                //               fontSize: 18,
                //               color: Color(0xffffffff),
                //               fontWeight: FontWeight.bold),
                //         )),
                //   ),
                // ),
              ],
            )));
  }
}

addRemoveBtn(Widget icon) {
  return Container(
    height: 25,
    width: 25,
    decoration: BoxDecoration(
        color:Color(0xffF5F4F2),
        shape: BoxShape.circle
    ),
    child: Center(
      child: icon,
    ),
  );
}

Widget AdonsDtls(String Items,String ItemsRate){
return Row(
  crossAxisAlignment:CrossAxisAlignment.center,
  mainAxisAlignment:MainAxisAlignment.spaceBetween,
  children: [
    Container(
      child: Row(
        children: [
          Container(
          width:120,
          child: Text( Items, style: TextStyle(fontFamily:'RB',fontSize: 16,color: Colors.black,letterSpacing:  0.1),)),
          SizedBox(width: 30,),
          Text( ItemsRate, style: TextStyle(fontFamily:'RB',fontSize: 16,color: Colors.black,letterSpacing:  0.1),)
        ],
      ),
    ),
    Spacer(),
    Container(
      padding: EdgeInsets.fromLTRB(1,1,1,1),
      decoration: BoxDecoration(
          color: ColorUtil.themeColor,
          borderRadius: BorderRadius.circular(5)
        // shape: BoxShape.circle
      ),
      child: Icon(Icons.done,color: ColorUtil.primaryColor,
      ),
    ),
  ],
);
}
Widget BillSummery(String SubDtls , String Rate){
  return Container(
    margin: EdgeInsets.only(left: 10,right: 10,bottom: 15),
    //   color: Colors.red,
    width: SizeConfig.screenWidth,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Row(
            crossAxisAlignment:
            CrossAxisAlignment.center,
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                SubDtls,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'RM',
                  color: ColorUtil.thBlack,
                ),
              ),
              Text(
                Rate,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'RM',
                  color: ColorUtil.thBlack,
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}