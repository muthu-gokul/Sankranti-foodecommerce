
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodecommerce/pages/navHomeScreen.dart';
import 'package:foodecommerce/utils/colorUtil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../../notifier/themeNotifier.dart';
import '../../styles/constants.dart';
import '../../styles/style.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/bottomPainter.dart';
import '../../widgets/companySettingsTextField.dart';



class OrderDeliveryDetails extends StatefulWidget {
  const OrderDeliveryDetails({Key? key}) : super(key: key);

  @override
  _OrderDeliveryDetailsState createState() => _OrderDeliveryDetailsState();
}

class _OrderDeliveryDetailsState extends State<OrderDeliveryDetails> {
  @override
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
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    height2=height-16;
    SizeConfig().init(context);
    return SafeArea(
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: ColorUtil.themeColorBg,
              body: Container(
                height: height,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Container(
                      height: 70,
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
                              child: Text('Your Food Details',style: TextStyle(fontFamily: 'RB',fontSize: 18,color: Colors.black,letterSpacing: 0.1),),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(height:20,),
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
                                child: Image.asset('assets/images/foodimgs/dossa.png',height: 70, fit: BoxFit.cover,  ),
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
                                child: Text("1X",style: TextStyle( fontFamily: 'RB',fontSize: 16,color:ColorUtil.thBlack,letterSpacing: 0.1),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25,),
                    Container(
                        margin: EdgeInsets.only(left: 10.0,),
                        alignment: Alignment.centerLeft,
                        child: Text('Payment Details',style:ts18(text1,fontfamily: 'RB',),)
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.only(left: 10.0,right: 10),
                      height: 1,
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorUtil.grey1,style: BorderStyle.solid),
                      ),
                    ),
                    SizedBox(height: 10,),
                    PaymentDtls('Price of the Item', '199.00'),
                    PaymentDtls('Delivery Charge', 'Free'),
                    PaymentDtls('Taxes', '2.00'),
                    Container(
                      height: 60,
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.only(left: 10.0,right: 10,top: 20),
                      padding: EdgeInsets.only(left: 10.0,right: 10,),
                      decoration: BoxDecoration(
                        color: ColorUtil.primaryColor,
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Text("Grand Total",style: TextStyle(fontFamily: 'RB',fontSize:16,color: ColorUtil.thBlack,letterSpacing: 0.1),),
                          Spacer(),
                          Text("201.00",style: TextStyle(fontFamily: 'RB',fontSize:16,color: ColorUtil.thBlack,letterSpacing: 0.1),),
                        ],
                      ),
                    ),
                    SizedBox(height: 25,),
                    Container(
                        margin: EdgeInsets.only(left: 10.0,),
                        alignment: Alignment.centerLeft,
                        child: Text('Order Details',style:ts18(text1,fontfamily: 'RB',),)
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.only(left: 10.0,right: 10),
                      height: 1,
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorUtil.grey1,style: BorderStyle.solid),
                      ),
                    ),
                    SizedBox(height: 5,),
                    OrderDtls('Order Number','18536767'),
                    OrderDtls('Payment mode','Cash On Delivery'),
                    OrderDtls('Delivered Address','No:14, NP Developed Plots, TVK IndustialEstate, Ekakttuthangal, Chennai - 600032'),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Masterpage()),);
                      },
                      child: Container(
                        height: 60,
                        width: SizeConfig.screenWidth!*0.85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: ColorUtil.themeColor,
                        ),
                        alignment: Alignment.center,
                        child: Text("Reorder",style: TextStyle(fontFamily: 'RB',fontSize:18,color: ColorUtil.primaryColor,letterSpacing: 0.1),),
                      ),
                    ),
                    SizedBox(height: 15,),
                  ],
                ),
              ),

            ),
          ],
        )
    );
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
  margin: EdgeInsets.only(left: 10.0,right: 10,top: 10),
  padding: EdgeInsets.only(right: 10,),
  child: Row(
    children: [
      Text(Items,style:ts16(text1,fontfamily: 'RM',fontsize: 18),),
      Spacer(),
      Text(Itemrate,style:ts16(text1,fontfamily: 'RM',fontsize: 18),)
    ],
  ),
);
}
Widget OrderDtls(String number, String OrderNumber){
  return Container(
    width: SizeConfig.screenWidth,
    margin: EdgeInsets.only(left: 10.0,right: 10,top: 15),
    padding: EdgeInsets.only(right: 10,),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(number,style:ts16(text1,fontfamily: 'RB',fontsize: 18),),
        SizedBox(height: 5,),
        Text(OrderNumber,style:ts16(text1,fontfamily: 'RR',fontsize: 18),)
      ],
    ),
  );
}