import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:foodecommerce/notifier/utils.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../notifier/Billing/cartNotifier.dart';
import '../../notifier/Billing/orderSettlementNotifier.dart';
import '../../styles/constants.dart';
import '../../styles/style.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/customNetworkImg.dart';
import '../navHomeScreen.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  late double width, height, width2, height2;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    width2 = width - 16;
    height2 = height - 16;
    SizeConfig().init(context);
    return SafeArea(
        child:Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                SizedBox(
                  height: height,
                  width: width,
                  child: Column(
                   //physics: const BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 60,
                        child: Container(
                          margin: const EdgeInsets.only(left:10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ArrowBack(
                                onTap: (){
                                  Get.back();
                                },
                              ),
                              const SizedBox(width: 10,),
                              Container(
                                alignment: Alignment.center,
                                child:  Text('Cart',
                                  style: TextStyle(fontFamily: 'MB',fontSize: 20,color: ColorUtil.themeBlack,letterSpacing: 0.1),),
                              ),
                              Container(
                                  margin: const EdgeInsets.only(left: 10.0,),
                                  alignment: Alignment.centerLeft,
                                  child: Obx(() => Text('${c_orderDetail.value!.productList!.length} Items in the cart',
                                    style:ts18(text1,fontfamily: 'MB',),))
                              ),
                            ],
                          ),
                        ),
                      ),

                      Expanded(child: Obx(() => ListView.builder(
                        shrinkWrap: true,
                        //physics: const NeverScrollableScrollPhysics(),
                        itemCount: c_orderDetail.value!.productList!.length,
                        itemBuilder: (ctx,i){
                          return Container(
                            width: width,
                            margin: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10),
                            //padding:const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: ColorUtil.themeColorBg,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment:CrossAxisAlignment.center,
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
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
                                              child:  CustomNetworkImg(
                                                dbFilePath: c_orderDetail.value!.productList![i].productImage,
                                                directoryPath: MyConstants.imgPath,
                                                height: 80,
                                                width: 80,
                                                loaderHeight: 80,
                                                loaderWidth: 80,
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                    const SizedBox(width: 10,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        mainAxisAlignment:MainAxisAlignment.center,
                                        children: [
                                          Text(StringUtils.capitalize(c_orderDetail.value!.productList![i].productName??""),
                                            style: const TextStyle(fontFamily:'MB',fontSize: 15,color: Colors.black,letterSpacing:  0.1),),
                                          const SizedBox(height: 5,),
                                          Text('${MyConstants.rupeeString} ${c_orderDetail.value!.productList![i].subTotal}', style: const TextStyle(fontFamily: 'MB',fontSize: 18,color: Colors.black, letterSpacing: 0.1),
                                          ),
                                        ],
                                      ),
                                    ),
                                    addRemoveBtn(Icon(Icons.remove, color: ColorUtil.themeColor, size: 20,),onTap: (){
                                      if(c_orderDetail.value!.productList![i].quantity!>1){
                                        c_orderDetail.value!.updateProductQty(c_orderDetail.value!.productList![i].productId, c_orderDetail.value!.productList![i].quantity!-1);
                                        c_orderDetail.refresh();
                                      }
                                      else{
                                        onProductDelete(c_orderDetail.value!.productList![i].productId);
                                      }
                                    },isAdd: false),
                                    SizedBox(
                                      width: 40,
                                      child: Center(
                                        child: Text(
                                          "${c_orderDetail.value!.productList![i].quantity!.toInt()}",
                                          style: ts18(ColorUtil.themeColor,fontfamily: 'MB'),
                                        ),
                                      ),
                                    ),
                                    addRemoveBtn(Icon(Icons.add, color: ColorUtil.primary, size: 20,),onTap: (){
                                      c_orderDetail.value!.updateProductQty(c_orderDetail.value!.productList![i].productId, c_orderDetail.value!.productList![i].quantity!+1);
                                      c_orderDetail.refresh();
                                    }),

                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      )),),

                      const SizedBox(height:20,),
                     /* Container(
                        padding:
                        const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Bill Summary',style:ts18(text1,fontfamily: 'RB',fontsize: 24),),
                            Container(
                              margin:const EdgeInsets.only(left: 10),
                              width: SizeConfig.screenWidth!-180,
                              height: 1,
                              color: const Color(0XffE4E4E4),
                            ),
                          ],
                        ),
                      ),*/
                     Container(
                       padding: EdgeInsets.only(top: 10,bottom: 0),
                       margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(15),
                         color: Color(0xfff6f9fb)
                       ),
                       child: Column(
                         children: [
                           Obx(() => BillSummery('SubTotal', '${c_orderDetail.value!.subTotal}')),
                           Obx(() => Visibility(
                               visible: parseDouble(c_orderDetail.value!.discountAmount)>0,
                               child: BillSummery('Discount', '${c_orderDetail.value!.discountAmount}'))),
                           Obx(()=>
                               ListView.builder(
                                 itemCount: c_orderDetail.value!.taxList!.length,
                                 shrinkWrap: true,
                                 physics: const NeverScrollableScrollPhysics(),
                                 itemBuilder: (ctx,t){
                                   return BillSummery('${c_orderDetail.value!.taxList![t].OtherChargesName} (${c_orderDetail.value!.taxList![t].OtherChargesValue}%)', '${c_orderDetail.value!.taxList![t].OtherChargesAmount}');
                                 },
                               )),
                           Obx(()=>
                               ListView.builder(
                                 itemCount: c_orderDetail.value!.consolidateOtherCharges!.length,
                                 shrinkWrap: true,
                                 physics: const NeverScrollableScrollPhysics(),
                                 itemBuilder: (ctx,t){
                                   return Visibility(
                                       visible: c_orderDetail.value!.consolidateOtherCharges![t].OtherChargesAmount!>0,
                                       child: BillSummery('${c_orderDetail.value!.consolidateOtherCharges![t].OtherChargesCategoryName}', '${c_orderDetail.value!.consolidateOtherCharges![t].OtherChargesAmount}'));
                                 },
                               )),
                           Obx(() => Visibility(
                               visible: parseDouble(c_orderDetail.value!.roundOffAmount)!=0,
                               child: BillSummery('Round Off', '${c_orderDetail.value!.roundOffAmount}'))),
                         ],
                       ),
                     ),

                     /* Container(
                        margin: const EdgeInsets.only(left: 10,right: 10,bottom: 15),
                        //   color: Colors.red,
                        width: SizeConfig.screenWidth,
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Payable',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'MB',
                                color: ColorUtil.thBlack,
                              ),
                            ),
                            Obx(() => Text(
                              '${HasOutletRoundOff()?c_orderDetail.value!.grandTotalAmount!.round():c_orderDetail.value!.grandTotalAmount}',
                              style: TextStyle(fontSize: 25, fontFamily: 'RB', color: ColorUtil.thBlack,),
                            ))
                          ],
                        ),
                      ),*/
                      GestureDetector(
                        onTap: (){
                          PlaceOrder(
                              (){
                                Get.close(2);
                                menuSel.value=4;
                              }
                          );
                        },
                        child: Container(
                          height: 60,
                          width: SizeConfig.screenWidth!-50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: ColorUtil.themeColor,
                          ),
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
                          child: Text("Place Your Order   ${MyConstants.rupeeString} ${HasOutletRoundOff()?c_orderDetail.value!.grandTotalAmount!.round():c_orderDetail.value!.grandTotalAmount}",style: TextStyle(fontFamily: 'RB',fontSize:18,color: ColorUtil.primaryColor,letterSpacing: 0.1),),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}

addRemoveBtn(Widget icon,{VoidCallback? onTap,bool isAdd=true}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
          color:isAdd?ColorUtil.themeColor: ColorUtil.themeColorBg2,
          borderRadius: BorderRadius.circular(10)
          //shape: BoxShape.circle
      ),
      child: Center(
        child: icon,
      ),
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
          SizedBox(
          width:120,
          child: Text( Items, style: const TextStyle(fontFamily:'RB',fontSize: 16,color: Colors.black,letterSpacing:  0.1),)),
          const SizedBox(width: 30,),
          Text( ItemsRate, style: const TextStyle(fontFamily:'RB',fontSize: 16,color: Colors.black,letterSpacing:  0.1),)
        ],
      ),
    ),
    const Spacer(),
    Container(
      padding: const EdgeInsets.fromLTRB(1,1,1,1),
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
    margin: const EdgeInsets.only(left: 10,right: 10,bottom: 15),
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
                "${MyConstants.rupeeString} $Rate",
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