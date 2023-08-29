import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:basic_utils/basic_utils.dart' as ub;
import '../../api/ApiManager.dart';
import '../../api/sp.dart';
import '../../models/parameterMode.dart';
import '../../notifier/appStateNotifier.dart';
import '../../notifier/utils/apiUtils.dart';
import '../../styles/app_theme.dart';
import '../../styles/style.dart';
import '../../utils/colorUtil.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/customCheckBox.dart';
import '../../widgets/loader.dart';
import '../../widgets/navigationBarIcon.dart';
class ItemBlock extends StatefulWidget {
  VoidCallback drawerCallback;
  ItemBlock({required this.drawerCallback});

  @override
  State<ItemBlock> createState() => _ItemBlockState();
}

class _ItemBlockState extends State<ItemBlock> {


  RxList<dynamic> unModifiedList=RxList<dynamic>();
  RxList<dynamic> productList=RxList<dynamic>();
  RxList<dynamic> filterProductList=RxList<dynamic>();

  @override
  void initState(){
    getProducts();
    super.initState();
  }

  void getProducts() async{
    List<ParameterModel> params= await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.getItemBlockProducts));
    ApiManager.GetInvoke(params).then((value){
      //console(value);
      if(value[0]){
        var response=json.decode(value[1]);
        unModifiedList.value=response['Table1'];
        productList.value=jsonDecode(jsonEncode(response['Table1']));
        filterProductList.value=productList.value;
      }
    });
  }
  double getProductAspectRatio(){
    double ar=1.0;
    if(SizeConfig.screenHeight!<700){
      ar=1.0;
    }
    else{
      (SizeConfig.screenWidth!/(SizeConfig.screenHeight!-360));
    }
    return ar;
  }

  int productPerPage=15;
  //String prefix="SYSO";
  String currentOT="SYSO-1";

  void onUpdate() async{

    List<dynamic> modifiedList=filterProductList.where((p0) => unModifiedList.any((element) => p0['ProductId']==element['ProductId']
      && p0[currentOT] !=element[currentOT]
    )).toList();



    if(modifiedList.length==0){
      //addNotifications(NotificationType.info,msg: "No Products Modified to Update...");
      return;
    }

    List<ParameterModel> params= await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.updateItemBlockProducts));
    params.add(ParameterModel(Key: "OrderTypeId", Type: "String", Value: currentOT));
    params.add(ParameterModel(Key: "ProductJson", Type: "String", Value: jsonEncode(modifiedList)));

    ApiManager.GetInvoke(params).then((value){
      //console(value);
      if(value[0]){
       // addNotifications(NotificationType.success,msg: "Updated Successfully");
        getProducts();
        //getBillingUtils();
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: AppTheme.restroTheme,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap:widget.drawerCallback,
                      child: NavBarIcon(

                      ),
                    ),
                    Text("Item Block",style: ts15(Colors.white),)
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                width:SizeConfig.screenWidth!-20,
                height: 40,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Color(0xFFCFCFCF)),
                    color: Colors.white
                ),
                child: TextFormField(
                 // controller: searchItemController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      // contentPadding: EdgeInsets.only(left: 20),
                      hintText: "Search Product",
                      hintStyle:TextStyle(fontFamily: 'QR',color: Colors.grey)
                  ),
                  onChanged: (value){
                    if(value.isEmpty){
                      filterProductList.value=productList;
                    }
                    else{
                      filterProductList.value=productList.where((p0) => p0['ProductName'].toString().toLowerCase().contains(value.toLowerCase()) ||
                          p0['ProductCode'].toString().toLowerCase().contains(value.toLowerCase())
                      ).toList();
                    }
                  },
                ),
              ),
              const SizedBox(height: 10,),
              Expanded(
                child: Obx(() => PageView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  onPageChanged: (i) {},
                  itemCount: filterProductList.length < productPerPage  ? 1 : ((filterProductList.length /productPerPage).ceil()),
                  itemBuilder: (BuildContext context, int itemIndex) {
                    return Padding(
                      padding: EdgeInsets.only(left:SizeConfig.width10!, right: SizeConfig.width10!),
                      child: GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount:productPerPage,
                        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:/*SizeConfig.screenWidth!>420? 4:*/3,
                            // crossAxisCount:1,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            //childAspectRatio:SizeConfig.screenWidth!>420? 1.55:(SizeConfig.screenWidth!/(SizeConfig.screenHeight!-350))
                            childAspectRatio: getProductAspectRatio()
                          /*childAspectRatio:c_OrderTypeId.value==QUICLSERVICE_ID?(SizeConfig.screenWidth!/(SizeConfig.screenHeight!-400)):
                                      (SizeConfig.screenWidth!/(SizeConfig.screenHeight!-350))*/

                        ),
                        itemBuilder: (BuildContext context, int index) {
                          int gridindex =index+(productPerPage*itemIndex);
                          //if (index < 50)
                          return gridindex < filterProductList.length
                              ? GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: (){
                                //console("hii",v2: filterProductList[gridindex][currentOT]);
                                if(filterProductList[gridindex][currentOT]==1){
                                  filterProductList[gridindex][currentOT]=0;
                                }
                                else{
                                  filterProductList[gridindex][currentOT]=1;
                                }
                                filterProductList.refresh();
                              },
                              /*  onTap:filterproduct[gridindex][MyConstants.itemBlockPrefix+c_OrderTypeId.value.toString()]==1?null:() {
                              onProductClick(filterproduct[gridindex],gridIndex: gridindex);
                            },*/

                              child:  Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color:Provider.of<AppStateNotifier>(context,listen:false).itemBgColor,
                                  ),
                                  child: LayoutBuilder(
                                      builder: (BuildContext ctx, BoxConstraints constraints) {
                                        return Stack(
                                          clipBehavior: Clip.hardEdge, alignment: Alignment.center,
                                          children: [
                                            Opacity(
                                              opacity:1,
                                              // opacity:filterproduct[gridindex][MyConstants.itemBlockPrefix+c_OrderTypeId.value.toString()]==1?0.5:1,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    margin: EdgeInsets.only(bottom: 3),
                                                    child: Text(
                                                      ub.StringUtils.capitalize( "${filterProductList[gridindex]['ProductName']}"),textAlign: TextAlign.center,
                                                      style:TextStyle(fontFamily: 'RR', color: Provider.of<AppStateNotifier>(context,listen:false).itemTextColor,
                                                          fontSize:14,letterSpacing: 0.1),maxLines: 2,overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top:5,
                                              right:5,
                                              child: CustomCheckBox(
                                                isSelect: filterProductList[gridindex][currentOT]==1,
                                                onlyCheckbox: true,
                                              ),
                                            )
                                            /* filterproduct[gridindex][MyConstants.itemBlockPrefix+c_OrderTypeId.value.toString()]==1? Container(
                                              alignment:Alignment.center,
                                              margin:EdgeInsets.only(bottom:20),
                                              child: SvgPicture.asset("assets/icon/item-block.svg",fit: BoxFit.fill,)
                                          ):Container(),*/



                                          ],
                                        );
                                      }
                                  )
                              )
                          )
                              : Container(
                            width: 0,
                            height: 0,
                          );
                        },
                      ),
                    );
                  },
                ),)
              ),
              const SizedBox(height: 10,),
              Container(
                height: 70,
                width: SizeConfig.screenWidth,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   /* GestureDetector(
                      onTap:(){
                      },
                      child: Container(
                        width: SizeConfig.screenWidth!*0.4,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color: ColorUtil.red),
                          color: ColorUtil.red.withOpacity(0.3),
                        ),
                        child:Center(child: Text('Close',style: TextStyle(fontSize: 18,color: ColorUtil.red,fontFamily:'RR'), )) ,
                      ),
                    ),*/
                    GestureDetector(
                      onTap:(){
                        onUpdate();
                      },
                      child: Container(
                        width: SizeConfig.screenWidth!*0.4,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: ColorUtil.red,
                        ),
                        child:Center(child: Text('Update',style: TextStyle(fontSize: 18,color: Color(0xffffffff),fontFamily:'RM'), )) ,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Obx(() => Loader(value: showLoader.value,))
        ],
      ),
    );
  }
}
