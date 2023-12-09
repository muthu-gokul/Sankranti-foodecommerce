
import 'dart:convert';
import 'dart:developer';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodecommerce/pages/navHomeScreen.dart';
import 'package:foodecommerce/utils/colorUtil.dart';
import 'package:foodecommerce/widgets/customAppBar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../../api/ApiManager.dart';
import '../../api/sp.dart';
import '../../models/BillingModel/cartModel.dart';
import '../../models/parameterMode.dart';
import '../../notifier/themeNotifier.dart';
import '../../notifier/utils.dart';
import '../../notifier/utils/apiUtils.dart';
import '../../styles/constants.dart';
import '../../styles/style.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/bottomPainter.dart';
import '../../widgets/companySettingsTextField.dart';
import '../../widgets/customNetworkImg.dart';
import '../../widgets/shimmer.dart';
import '../HomePage/Cartpage.dart';



class OrderDeliveryDetails extends StatefulWidget {
  dynamic orderId;
  OrderDeliveryDetails({Key? key,required this.orderId}) : super(key: key);

  @override
  _OrderDeliveryDetailsState createState() => _OrderDeliveryDetailsState();
}

class _OrderDeliveryDetailsState extends State<OrderDeliveryDetails> {

  List<dynamic> FavItems=[
    {"FavImg":"assets/images/foodimgs/seaFood.jpg","FavItemName":"SEA Food","Rate":"250.00","FavVegNon":"Non-Veg","FavColorCatg":0xffFF0022,"FavSubtitle":"Comments"},
    {"FavImg":"assets/images/foodimgs/Pizza.jpg","FavItemName":"Pizza Maina","Rate":"59.00","FavVegNon":"Non-veg","FavColorCatg":0xffFF0022,"FavSubtitle":"Comments"},
    {"FavImg":"assets/images/foodimgs/icecream.jpg","FavItemName":"Ice Cream","Rate":"299.00","FavVegNon":"Veg","FavColorCatg":0xffFF0022,"FavSubtitle":"Comments"},
    {"FavImg":"assets/images/foodimgs/Fullmeals.png","FavItemName":"Fresh Juice","Rate":"150.00","FavVegNon":"Veg","FavColorCatg":0xffFF0022,"FavSubtitle":"Comments"},
    {"FavImg":"assets/images/foodimgs/milkcatg.jpg","FavItemName":"Milk Shake","Rate":"99.00","FavVegNon":"Veg","FavColorCatg":0xffFF0022,"FavSubtitle":"Comments"},
    {"FavImg":"assets/images/foodimgs/biriyani.webp","FavItemName":"Chicken Biriyani","Rate":"140.00","FavVegNon":"Non-Veg","FavColorCatg":0xffFF0022,"FavSubtitle":"Comments"},
    {"FavImg":"assets/images/foodimgs/tikka.jpg","FavItemName":"Panner Tikka","Rate":"170.00","FavVegNon":"Veg","FavColorCatg":0xffFF0022,"FavSubtitle":"Comments"},
    {"FavImg":"assets/images/foodimgs/milkshake.jpg","FavItemName":"Choco Dessert","Rate":"80.00","FavVegNon":"Veg","FavColorCatg":0xffFF0022,"FavSubtitle":"Comments"},
    {"FavImg":"assets/images/foodimgs/Fullmeals.png","FavItemName":"SouthIndian Special","Rate":"199.00","FavVegNon":"Non-veg","FavColorCatg":0xffFF0022,"FavSubtitle":"Meals"},
    {"FavImg":"assets/images/foodimgs/PannerMasala.png","FavItemName":"Panner Masala","Rate":"250.00","FavVegNon":"Veg","FavColorCatg":0xff007F11,"FavSubtitle":"Comments"},
    {"FavImg":"assets/images/foodimgs/Tiffen.png","FavItemName":"Mini Tiffen","Rate":"130.00","FavVegNon":"Veg","FavColorCatg":0xff007F11,"FavSubtitle":"Morning Special"},
    {"FavImg":"assets/images/foodimgs/dossa.png","FavItemName":"Dossa Special","Rate":"99.00","FavVegNon":"Veg","FavColorCatg":0xff007F11,"FavSubtitle":"Evening Special"},
    {"FavImg":"assets/images/foodimgs/Grill.jpg","FavItemName":"Grill Chicken","Rate":"399.00","FavVegNon":"Non-veg","FavColorCatg":0xffFF0022,"FavSubtitle":"InfuseGrill"},
  ];
  late  double width,height,width2,height2;

  Rxn<OrderModel> orderDetail=Rxn<OrderModel>();
  RxBool isLoading=RxBool(false);
  @override
  void initState() {
    getOrderDetailById();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    height2=height-16;
    SizeConfig().init(context);
    return SafeArea(
        child:Scaffold(
            backgroundColor:  Colors.white,
            body: Stack(
              children: [
                SizedBox(
                  height: height,
                  width: width,
                  child: Column(
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
                                onTap: () {
                                  Get.back();
                                },
                              ),
                              const SizedBox(width: 10,),
                              Container(
                                alignment: Alignment.center,
                                child: const Text('Order Detail',style: TextStyle(fontFamily: 'MB',fontSize: 18,color: Colors.black,letterSpacing: 0.1),),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height:10,),
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
                      Expanded(child: Obx(() => ListView.builder(
                        itemCount: orderDetail.value!.totalProductList!.length,
                        itemBuilder: (ctx,i){
                          return Container(
                            width: width,
                            margin: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10),
                            //padding:const EdgeInsets.fromLTRB(10,0,10,0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: ColorUtil.themeColorBg,
                            ),
                            child: Row(
                              crossAxisAlignment:CrossAxisAlignment.center,
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    height: 80,
                                    width: 80,
                                    clipBehavior: Clip.antiAlias,
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
                                            dbFilePath:orderDetail.value!.totalProductList![i].productImage,
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    mainAxisAlignment:MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 5,),
                                      Text(StringUtils.capitalize(orderDetail.value!.totalProductList![i].productName??""), style: const TextStyle(fontFamily:'MB',fontSize: 15,color: Colors.black,letterSpacing:  0.1),),
                                      const SizedBox(height: 7,),
                                      Text('${orderDetail.value!.totalProductList![i].quantity} * ${orderDetail.value!.totalProductList![i].productPrice}', style: const TextStyle(fontFamily: 'MB',fontSize: 18,color: Colors.black, letterSpacing: 0.1),),
                                      const SizedBox(height: 5,),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Text(
                                  "${MyConstants.rupeeString} ${orderDetail.value!.totalProductList![i].subTotal}",
                                  style: ts18(ColorUtil.themeColor,fontfamily: 'MB'),
                                ),
                                const SizedBox(width: 10,),
                              ],
                            ),
                          );
                        },
                      ))),
                      const SizedBox(height:20,),
                      Container(
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
                      ),
                      const SizedBox(height:10,),

                      Container(
                        padding: EdgeInsets.only(top: 10,bottom: 0),
                        margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xfff6f9fb)
                        ),
                        child: Column(
                          children: [
                            Obx(() => BillSummery('SubTotal', '${orderDetail.value!.subTotal}')),
                            Obx(() => Visibility(
                                visible: parseDouble(orderDetail.value!.discountAmount)>0,
                                child: BillSummery('Discount', '${orderDetail.value!.discountAmount}'))),
                            Obx(()=>
                                ListView.builder(
                                  itemCount: orderDetail.value!.taxList!.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (ctx,t){
                                    return BillSummery('${orderDetail.value!.taxList![t].OtherChargesName} (${orderDetail.value!.taxList![t].OtherChargesValue}%)', '${orderDetail.value!.taxList![t].OtherChargesAmount}');
                                  },
                                )),
                            Obx(()=>
                                ListView.builder(
                                  itemCount: orderDetail.value!.consolidateOtherCharges!.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (ctx,t){
                                    return Visibility(
                                        visible: orderDetail.value!.consolidateOtherCharges![t].OtherChargesAmount!>0,
                                        child: BillSummery('${orderDetail.value!.consolidateOtherCharges![t].OtherChargesCategoryName}', '${orderDetail.value!.consolidateOtherCharges![t].OtherChargesAmount}'));
                                  },
                                )),
                            Obx(() => Visibility(
                                visible: parseDouble(orderDetail.value!.roundOffAmount)!=0,
                                child: BillSummery('Round Off', '${orderDetail.value!.roundOffAmount}'))),
                            Container(
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
                                          'Total Payable',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'RB',
                                            color: ColorUtil.thBlack,
                                          ),
                                        ),
                                        Obx(() => Text(
                                          '${MyConstants.rupeeString} ${/*HasOutletRoundOff()?orderDetail.value!.grandTotalAmount!.round():*/orderDetail.value!.grandTotalAmount!+orderDetail.value!.roundOffAmount!}',
                                          style: TextStyle(fontSize: 17, fontFamily: 'RB', color: ColorUtil.thBlack,),
                                        ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),



                    ],
                  ),
                ),
              ],
            )));
  }

  void getOrderDetailById() async{
    isLoading.value=true;
    params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName",Value: Sp.GetTableStatusSp,Type: "string"));
    params.add(ParameterModel(Key: "TableNumberId",Value: null,Type: "string"));
    params.add(ParameterModel(Key: "DynamicTable",Value: null,Type: "string"));
    params.add(ParameterModel(Key: "OrderId",Value: widget.orderId,Type: "string"));
    params.add(ParameterModel(Key: "IsTableMerge",Value: false,Type: "string"));
    ApiManager.GetInvoke(params).then((value) {
      log("$value");
      isLoading.value=false;
      if(value[0]){
        var response=json.decode(value[1]);
        orderDetail.value=OrderModel();
        orderDetail.value!.OrderDetailFromJson(response['Table5'][0], response['Table8'], response['Table9']);
        orderDetail.value!.createTotalOrderKotWise(response['Table6'], response['Table7']);
        orderDetail.value!.updateConsolidateOtherCharges(response['Table12'],response['Table14']);
        orderDetail.value!.updateAddons(response['Table10']);
      }
    });
  }


}


addRemoveBtn(Widget icon){
  return Container(
    height: 25,
    width: 25,
    // decoration: BoxDecoration(
    //     color:Color(0xffF5F4F2),
    //     borderRadius:BorderRadius.circular(5)
    // ),
    child: Center(
      child: icon,
    ),
  );
}

Widget PaymentDtls(String Items, String Itemrate){
return Container(
  width: SizeConfig.screenWidth,
  margin: const EdgeInsets.only(left: 10.0,right: 10,top: 10),
  padding: const EdgeInsets.only(right: 10,),
  child: Row(
    children: [
      Text(Items,style:ts16(text1,fontfamily: 'RM',fontsize: 18),),
      const Spacer(),
      Text(Itemrate,style:ts16(text1,fontfamily: 'RM',fontsize: 18),)
    ],
  ),
);
}
Widget OrderDtls(String number, String OrderNumber){
  return Container(
    width: SizeConfig.screenWidth,
    margin: const EdgeInsets.only(left: 10.0,right: 10,top: 15),
    padding: const EdgeInsets.only(right: 10,),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(number,style:ts16(text1,fontfamily: 'RB',fontsize: 18),),
        const SizedBox(height: 5,),
        Text(OrderNumber,style:ts16(text1,fontfamily: 'RR',fontsize: 18),)
      ],
    ),
  );
}