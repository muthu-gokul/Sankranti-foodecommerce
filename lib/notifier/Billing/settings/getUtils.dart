import 'dart:convert';
import '../../../api/ApiManager.dart';
import '../../../api/sp.dart';
import '../../../models/parameterMode.dart';
import '../../../utils/constants.dart';
import '../../utils.dart';
import '../../utils/apiUtils.dart';
import '../billingController.dart';
import '../outletDetail.dart';
import 'itemBlockNotifier.dart';

Future getBillingUtils() async{
  //console("getBillingUtils");
  PRODUCT_BLOCKDETAIL.clear();
  List<ParameterModel> params= await getParameterEssential();
  params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.getBillingUtils));
  params.add(ParameterModel(Key: "LayOutType", Type: "String", Value: "DesktopVersion1"));
  params.add(ParameterModel(Key: "FloorId", Type: "String", Value: null));
  await ApiManager.GetInvoke(params).then((value){
    if(value[0]){
      var response=jsonDecode(value[1]);
      List<dynamic> blockedProducts=response['Table5']??[];
      if(blockedProducts.isNotEmpty){
        blockedProducts.forEach((element) {
          int index=filterproduct.indexWhere((f) => f['ProductId']==element['ProductId']);
          if(index!=-1){
            filterproduct[index][MyConstants.itemBlockPrefix+element['OrderTypeId'].toString()]=1;
          }

          int blockIndex=PRODUCT_BLOCKDETAIL.indexWhere((g) => g['ProductId']==element['ProductId']);
          if(blockIndex==-1){
            PRODUCT_BLOCKDETAIL.add({"ProductId":element['ProductId'],element['OrderTypeId'].toString():1});
          }
          else{
            PRODUCT_BLOCKDETAIL[blockIndex][element['OrderTypeId'].toString()]=1;
          }

        });
        filterproduct.refresh();
        PRODUCT_BLOCKDETAIL.refresh();
      }
    }
  });
}