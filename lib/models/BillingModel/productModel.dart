import '../../notifier/Billing/configuration.dart';
import '../../notifier/utils.dart';

class ProductModel{
  double? quantity;
  double? taxValue;
  double? taxAmount;
  bool? isDiscount;
  bool? isPercentage;
  double? discountValue;
  double? discountAmount;
  double? discountedSubTotal;
  double? subTotal;
  double? additionalDiscountValue;
  double? totalOtherChargesAmount;
  double? grandTotal;
  List<OtherChargesMapping>? otherChargesList;
  List<OtherChargesMapping>? taxList;
  int? kotId;
  List<Null>? addOnCommentsList;
  String? notes;
  int? productMappingId;
  int? productId;
  String? productName;
  double? productPrice;
  int? productCategoryId;
  bool isProductWeightEnable;
  int orderTypeId;
  bool isHoldProduct;

  ProductModel(
      {this.quantity,
        this.taxValue=0.0,
        this.taxAmount=0.0,
        this.isDiscount=false,
        this.isPercentage=false,
        this.discountValue=0.0,
        this.discountAmount=0.0,
        this.discountedSubTotal=0.0,
        this.subTotal=0.0,
        this.additionalDiscountValue=0.0,
        this.totalOtherChargesAmount=0.0,
        this.grandTotal=0.0,
        this.otherChargesList,
        this.taxList,
        this.kotId,
        this.addOnCommentsList,
        this.notes,
        this.productMappingId,
        this.productId,
        this.productName,
        this.productPrice=0.0,
        this.productCategoryId,
        this.isProductWeightEnable=false,
        this.orderTypeId=1,
        this.isHoldProduct=false
      });

  ProductObj(orderId){
    var obj = {};
    obj['OrderProductMappingId'] = productMappingId;
    obj['OrderId'] = orderId;
    obj['ProductId'] = productId;
    obj['ProductPrice'] = productPrice;
    obj['ProductQuantity'] = quantity;
    obj['TaxAmount'] = taxAmount;
    obj['IsDiscount'] = isDiscount;
    obj['IsPercentage'] = isPercentage;
    obj['DiscountValue'] = discountValue;
    obj['DiscountAmount'] = discountAmount;
    obj['DiscountedSubtotal'] = discountedSubTotal;
    obj['SubTotal'] = subTotal;
    obj['AdditionalDiscount'] = additionalDiscountValue;
    obj['TotalAmount'] = grandTotal;
    obj['KOTId'] = kotId;
    obj['OrderStatusId'] = null;
    obj['IsActive'] = true;
    if(isHasBillSettingsAccess(featuresAccessId['OrderTypePriceTVP'])){
      obj['OrderTypeId'] = orderTypeId;
    }
    return obj;
  }

  FromJson(productDetailObj, orderTypeId,{isHoldProduct=false}) async{

    List<dynamic> productOtherChargesMappingList = await getOutletDetail("ProductOtherChargesList");
    List<dynamic> productTaxMappingList = await getOutletDetail("ProductTaxList");

    List<dynamic> productOCList=productOtherChargesMappingList.where((f) => f['ProductId']==productDetailObj['ProductId'] && f['OrderTypeId']==orderTypeId).toList();
    List<dynamic> productTaxList=productTaxMappingList.where((e) => e['ProductId']==productDetailObj['ProductId']).toList();

    var productModel = new ProductModel();
    productModel.productMappingId = productDetailObj['OrderProductMappingId'];
    productModel.productId = productDetailObj['ProductId'];
    productModel.productName = productDetailObj['ProductName'];
    productModel.productPrice = productDetailObj['ProductPrice'];
    productModel.productCategoryId = productDetailObj['ProductCategoryId'];
    productModel.quantity = productDetailObj['ProductQuantity'];
    productModel.taxAmount = productDetailObj['TaxAmount'];
    productModel.isDiscount = productDetailObj['IsDiscount'];
    productModel.isPercentage = productDetailObj['IsPercentage'];
    productModel.discountValue = productDetailObj['DiscountValue'];
    productModel.discountAmount = productDetailObj['DiscountAmount'];
    productModel.discountedSubTotal = productDetailObj['DiscountedSubtotal'];
    productModel.subTotal = productDetailObj['SubTotal'];
    productModel.additionalDiscountValue = productDetailObj['AdditionalDiscount'];
    productModel.grandTotal = productDetailObj['TotalAmount'];
    productModel.kotId = productDetailObj['KOTId'];
    productModel.orderTypeId =isHasBillSettingsAccess(featuresAccessId['OrderTypePriceTVP'])? productDetailObj['OrderTypeId']??orderTypeId:orderTypeId;
    productModel.otherChargesList = productOCList.map((e)=>OtherChargesMapping.FromJsonGetBillingOutlet(e)).toList();
    productModel.taxList = productTaxList.map((e)=>OtherChargesMapping.FromJsonGetBillingOutlet(e)).toList();
    productModel.addOnCommentsList = [];
    productModel.notes = "";
    productModel.totalOtherChargesAmount = 0.0;
    productModel.orderTypeId = productDetailObj['OrderTypeId']??1;
    productModel.isHoldProduct=isHoldProduct;
    return productModel;
  }
}



class OtherChargesMapping {
  int? OrderAmountClassificationId;
  int? OrderAmountClassificationTypeId;
  int? OrderId;
  int? OrderProductId;
  int? OrderProductMappingId;
  int? OtherChargesId;
  bool? IsPercentage;
  double? OtherChargesValue;
  double? OtherChargesAmount;
  int? RefId;
  String? OtherChargesName;
  int? OtherChargesCategoryId;
  bool? isExemption = false;
  bool? IsOverAllEnable=false;
  bool? IsOverAllPercentage=false;
  double? OverAllValue=0.0;

  OtherChargesMapping({this.OrderAmountClassificationId=null,
    this.OrderAmountClassificationTypeId=null, this.OrderId=null, this.OrderProductId,
    this.OrderProductMappingId = null, this.OtherChargesId=null, this.IsPercentage=false,
    this.OtherChargesValue=0.0, this.OtherChargesAmount=0.0, this.RefId=null,
    this.OtherChargesName=null, this.OtherChargesCategoryId=null, this.isExemption=false,
    this.IsOverAllEnable=false, this.IsOverAllPercentage=false, this.OverAllValue=0.0});

  ToJsonTax(){
    var obj = {};
    obj['OrderAmountClassificationId'] = this.OrderAmountClassificationId;
    obj['OrderAmountClassificationTypeId'] = 1;
    obj['OrderId'] = this.OrderId;
    obj['OtherChargesId'] = this.OtherChargesId;
    obj['OtherChargesCategoryId'] = this.OtherChargesCategoryId ==null ? this.OtherChargesCategoryId:1;
    obj['IsPercentage'] = this.IsPercentage;
    obj['OtherChargesValue'] = this.OtherChargesValue;
    obj['OtherChargesAmount'] = this.OtherChargesAmount;
    obj['RefId'] = this.RefId;
    obj['IsExemption'] = this.isExemption;
    obj['IsOverAllEnable'] = this.IsOverAllEnable ?? false;
    obj['IsOverAllPercentage'] = this.IsOverAllPercentage ??false;
    obj['OverAllValue'] = this.OverAllValue?? 0.0;
    obj['IsActive'] = true;
    return obj;
  }

  ToJsonTaxProduct(){
    var obj = {};
    obj['OrderAmountClassificationId'] = this.OrderAmountClassificationId;
    obj['OrderAmountClassificationTypeId'] = 1;
    obj['OrderId'] = this.OrderId;
    obj['OrderProductId'] = this.OrderProductId;
    obj['OtherChargesId'] = this.OtherChargesId;
    obj['OtherChargesCategoryId'] = this.OtherChargesCategoryId ==null ? this.OtherChargesCategoryId:1;
    obj['OtherChargesValue'] = this.OtherChargesValue;
    obj['OtherChargesAmount'] = this.OtherChargesAmount;
    obj['RefId'] = this.RefId;
    obj['IsExemption'] = this.isExemption;
    obj['IsPercentage'] = this.IsPercentage;
    obj['IsOverAllEnable'] = this.IsOverAllEnable ?? false;
    obj['IsOverAllPercentage'] = this.IsOverAllPercentage ??false;
    obj['OverAllValue'] = this.OverAllValue?? 0.0;
    obj['IsActive'] = true;
    return obj;
  }

  ToJsonTaxBillSplit(){
    var obj = {};
    obj['BillSplitAmountClassificationId'] = this.OrderAmountClassificationId;
    obj['OrderAmountClassificationTypeId'] = 1;
    obj['OrderId'] = this.OrderId;
    obj['OtherChargesId'] = this.OtherChargesId;
    obj['OtherChargesCategoryId'] = this.OtherChargesCategoryId ??1;
    obj['IsPercentage'] = this.IsPercentage;
    obj['OtherChargesValue'] = this.OtherChargesValue;
    obj['OtherChargesAmount'] = this.OtherChargesAmount;
    obj['RefId'] = this.RefId;
    obj['IsExemption'] = this.isExemption;
    obj['IsOverAllEnable'] = this.IsOverAllEnable ??false;
    obj['IsOverAllPercentage'] = this.IsOverAllPercentage ?? false;
    obj['OverAllValue'] = this.OverAllValue ?? 0.0;
    obj['IsActive'] = true;
    return obj;
  }

  CreateTaxMapping(orderId, taxDetail, productId){
    OtherChargesMapping taxModel = new OtherChargesMapping();
    taxModel.OrderId = orderId;
    taxModel.OtherChargesId = taxDetail.OtherChargesId;
    taxModel.OtherChargesName = taxDetail.OtherChargesName;
    taxModel.OtherChargesValue = taxDetail.OtherChargesValue;
    taxModel.OtherChargesAmount = taxDetail.OtherChargesAmount;
    taxModel.RefId = taxDetail.RefId;
    taxModel.OrderProductId = productId;
    taxModel.IsPercentage = true;

    return taxModel;
  }

  factory OtherChargesMapping.FromJsonTax(taxDetail){
    OtherChargesMapping taxModel = new OtherChargesMapping();
    taxModel.OrderAmountClassificationId = taxDetail['OrderAmountClassificationId'];
    taxModel.OrderAmountClassificationTypeId = taxDetail['OrderAmountClassificationTypeId'];
    taxModel.OrderId = taxDetail['OrderId'];
    taxModel.OrderProductId = taxDetail['OrderProductId'];
    taxModel.OtherChargesId = taxDetail['OtherChargesId'];
    taxModel.OtherChargesName = taxDetail['OtherChargesName'];
    taxModel.OtherChargesValue = taxDetail['OtherChargesValue']??0.0;
    taxModel.OtherChargesAmount = taxDetail['OtherChargesAmount']??0.0;
    taxModel.RefId = taxDetail['RefId'];
    taxModel.IsPercentage = taxDetail['IsPercentage'];
    taxModel.OtherChargesCategoryId = taxDetail['OtherChargesCategoryId'];
    taxModel.IsOverAllEnable = taxDetail['IsOverAllEnable']??false;
    taxModel.IsOverAllPercentage = taxDetail['IsOverAllPercentage']??false;
    taxModel.OverAllValue = taxDetail['OverAllValue']??0.0;
    return taxModel;
  }

  factory OtherChargesMapping.FromJsonGetBillingOutlet(taxDetail){
    OtherChargesMapping taxModel = new OtherChargesMapping();
    taxModel.OrderAmountClassificationId = taxDetail['OrderAmountClassificationId'];
    taxModel.OrderAmountClassificationTypeId = taxDetail['OrderAmountClassificationTypeId'];
    taxModel.OrderId = taxDetail['OrderId'];
    taxModel.OrderProductId = taxDetail['OrderProductId'];
    taxModel.OtherChargesId = taxDetail['OtherChargesId'];
    taxModel.OtherChargesName = taxDetail['OtherChargesName'];
    taxModel.OtherChargesValue = taxDetail['OtherChargesValue']??0.0;
    taxModel.OtherChargesAmount = taxDetail['OtherChargesAmount']??0.0;
    taxModel.RefId = taxDetail['ParentOtherChargesId'];
    taxModel.IsPercentage = taxDetail['IsPercentage'];
    taxModel.OtherChargesCategoryId = taxDetail['OtherChargesCategoryId'];
    taxModel.IsOverAllEnable = taxDetail['IsOverAllEnable']??false;
    taxModel.IsOverAllPercentage = taxDetail['IsOverAllPercentage']??false;
    taxModel.OverAllValue = taxDetail['OverAllValue']??0.0;
    return taxModel;
  }



  ToJsonOtherCharges(){
    var obj = {};
    obj['OrderAmountClassificationId'] = this.OrderAmountClassificationId;
    obj['OrderAmountClassificationTypeId'] = 2;
    obj['OrderId'] = this.OrderId;
    obj['OrderProductId'] = this.OrderProductId;
    obj['OtherChargesId'] = this.OtherChargesId;
    obj['OtherChargesCategoryId'] = this.OtherChargesCategoryId;
    obj['IsPercentage'] = this.IsPercentage;
    obj['OtherChargesValue'] = this.OtherChargesValue;
    obj['OtherChargesAmount'] = this.OtherChargesAmount;
    obj['RefId'] = this.RefId;
    obj['IsExemption'] = this.isExemption;
    obj['IsOverAllEnable'] = this.IsOverAllEnable;
    obj['IsOverAllPercentage'] = this.IsOverAllPercentage;
    obj['OverAllValue'] = this.OverAllValue;
    obj['IsActive'] = true;
    return obj;
  }

  ToJsonOtherChargesBillSplit(){
    var obj = {};
    obj['BillSplitAmountClassificationId'] = this.OrderAmountClassificationId;
    obj['OrderAmountClassificationTypeId'] = 2;
    obj['OrderId'] = this.OrderId;
    obj['OrderProductId'] = this.OrderProductId;
    obj['OtherChargesId'] = this.OtherChargesId;
    obj['OtherChargesCategoryId'] = this.OtherChargesCategoryId;
    obj['IsPercentage'] = this.IsPercentage;
    obj['OtherChargesValue'] = this.OtherChargesValue;
    obj['OtherChargesAmount'] = this.OtherChargesAmount;
    obj['RefId'] = this.RefId;
    obj['IsExemption'] = this.isExemption;
    obj['IsOverAllEnable'] = this.IsOverAllEnable;
    obj['IsOverAllPercentage'] = this.IsOverAllPercentage;
    obj['OverAllValue'] = this.OverAllValue;
    obj['IsActive'] = true;
    return obj;
  }

  CreateOCMapping(orderId, productId, OCDetail, {isOverAll=false}){
    OtherChargesMapping oCModel = new OtherChargesMapping();
    oCModel.OrderId = orderId;
    oCModel.OrderProductId = productId;
    oCModel.OtherChargesId = isOverAll?null: OCDetail.OtherChargesId;
    oCModel.OtherChargesName = isOverAll ? null: OCDetail.OtherChargesName;
    oCModel.OtherChargesValue = isOverAll?0.0: OCDetail.OtherChargesValue;
    oCModel.OtherChargesAmount = OCDetail.OtherChargesAmount;
    oCModel.IsPercentage = isOverAll ? false :  OCDetail.IsPercentage;
    oCModel.OtherChargesCategoryId = OCDetail.OtherChargesCategoryId;
    oCModel.IsOverAllEnable = OCDetail.IsOverAllEnable ? OCDetail.IsOverAllEnable : isOverAll;
    oCModel.IsOverAllPercentage = OCDetail.IsOverAllPercentage ?? false;
    oCModel.OverAllValue = OCDetail.OverAllValue ?? 0.0;
    return oCModel;
  }

  OtherChargesMapping.fromJson(Map<String, dynamic> taxDetail) {
    OtherChargesMapping taxModel = new OtherChargesMapping();
    taxModel.OrderAmountClassificationId = taxDetail['OrderAmountClassificationId'];
    taxModel.OrderAmountClassificationTypeId = taxDetail['OrderAmountClassificationTypeId'];
    taxModel.OrderId = taxDetail['OrderId'];
    taxModel.OrderProductId = taxDetail['OrderProductId'];
    taxModel.OtherChargesId = taxDetail['OtherChargesId'];
    taxModel.OtherChargesName = taxDetail['OtherChargesName'];
    taxModel.OtherChargesValue = taxDetail['OtherChargesValue']??0.0;
    taxModel.OtherChargesAmount = taxDetail['OtherChargesAmount']??0.0;
    taxModel.RefId = taxDetail['ParentOtherChargesId'];
    taxModel.IsPercentage = taxDetail['IsPercentage'];
    taxModel.OtherChargesCategoryId = taxDetail['OtherChargesCategoryId'];
    taxModel.IsOverAllEnable = taxDetail['IsOverAllEnable']??false;
    taxModel.IsOverAllPercentage = taxDetail['IsOverAllPercentage']??false;
    taxModel.OverAllValue = taxDetail['OverAllValue']??0.0;
    //return taxModel;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> obj = new Map<String, dynamic>();
    obj['OrderAmountClassificationId'] = this.OrderAmountClassificationId;
    obj['OrderAmountClassificationTypeId'] = this.OrderAmountClassificationTypeId;
    obj['OrderId'] = this.OrderId;
    obj['OrderProductId'] = this.OrderProductId;
    obj['OtherChargesId'] = this.OtherChargesId;
    obj['OtherChargesCategoryId'] = this.OtherChargesCategoryId;
    obj['IsPercentage'] = this.IsPercentage;
    obj['OtherChargesValue'] = this.OtherChargesValue;
    obj['OtherChargesAmount'] = this.OtherChargesAmount;
    obj['RefId'] = this.RefId;
    obj['IsExemption'] = this.isExemption;
    obj['IsOverAllEnable'] = this.IsOverAllEnable;
    obj['IsOverAllPercentage'] = this.IsOverAllPercentage;
    obj['OverAllValue'] = this.OverAllValue;
    obj['IsActive'] = true;
    obj['OtherChargesName'] = this.OtherChargesName;
    return obj;
  }

/*  factory OtherChargesMapping.FromJson(taxDetail){
    OtherChargesMapping taxModel = new OtherChargesMapping();
    taxModel.OrderAmountClassificationId = taxDetail['OrderAmountClassificationId'];
    taxModel.OrderAmountClassificationTypeId = taxDetail['OrderAmountClassificationTypeId'];
    taxModel.OrderId = taxDetail['OrderId'];
    taxModel.OrderProductId = taxDetail['OrderProductId'];
    taxModel.OtherChargesId = taxDetail['OtherChargesId'];
    taxModel.OtherChargesName = taxDetail['OtherChargesName'];
    taxModel.OtherChargesValue = taxDetail['OtherChargesValue']??0.0;
    taxModel.OtherChargesAmount = taxDetail['OtherChargesAmount']??0.0;
    taxModel.RefId = taxDetail['ParentOtherChargesId'];
    taxModel.IsPercentage = taxDetail['IsPercentage'];
    taxModel.OtherChargesCategoryId = taxDetail['OtherChargesCategoryId'];
    taxModel.IsOverAllEnable = taxDetail['IsOverAllEnable']??false;
    taxModel.IsOverAllPercentage = taxDetail['IsOverAllPercentage']??false;
    taxModel.OverAllValue = taxDetail['OverAllValue']??0.0;
    return taxModel;
  }*/
}




class ConsolidateOtherChargess {
  int? OrderId ;
  double? OtherChargesAmount;
  int? OtherChargesCategoryId;
  bool? isExemption;
  String? OtherChargesCategoryName;
  bool? IsOverAllEnable;
  bool? IsOverAllPercentage;
  double? OverAllValue;
  double? OverAllAmount ;

  ConsolidateOtherChargess({this.OrderId= null, this.OtherChargesAmount= 0.0,
    this.OtherChargesCategoryId= null, this.isExemption=false,
    this.OtherChargesCategoryName, this.IsOverAllEnable=false,
    this.IsOverAllPercentage=false, this.OverAllValue= 0.0, this.OverAllAmount= 0.0});

  factory ConsolidateOtherChargess.FromJson(Map<String, dynamic>  ocDetail){
    ConsolidateOtherChargess ocModel = new ConsolidateOtherChargess();
    ocModel.OrderId = ocDetail['OrderId'];
    ocModel.OtherChargesAmount = ocDetail['OtherChargesAmount']??0.0;
    ocModel.OtherChargesCategoryId = ocDetail['OtherChargesCategoryId'];
    ocModel.OtherChargesCategoryName = ocDetail['OtherChargesCategoryName'];
    ocModel.isExemption = ocDetail['IsExemption'];
    ocModel.IsOverAllEnable = ocDetail['IsOverAllEnable'];
    ocModel.IsOverAllPercentage = ocDetail['IsOverAllPercentage'];
    ocModel.OverAllValue = ocDetail['OverAllValue'];
    return ocModel;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OtherChargesCategoryId'] = this.OtherChargesCategoryId;
    data['OtherChargesCategoryName'] = this.OtherChargesCategoryName;
    data['IsOverAllEnable'] = this.IsOverAllEnable;
    data['IsOverAllPercentage'] = this.IsOverAllPercentage;
    data['OverAllValue'] = this.OverAllValue;
    data['OtherChargesAmount'] = this.OtherChargesAmount;
    data['isExemption'] = this.isExemption;
    data['OverAllAmount'] = this.OverAllAmount;
    return data;
  }

}

