import '../../models/BillingModel/productModel.dart';

class OrderWithKoT{
  int? KotNumber;
  int? KotId;
  List<ProductModel>? productList;
  OrderWithKoT({this.KotNumber,this.productList,this.KotId});
}