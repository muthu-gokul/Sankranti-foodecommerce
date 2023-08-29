import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';

class UserTable{
  int? UserId;
  String? Name;
  UserTable({this.UserId,this.Name});

  factory UserTable.fromJson(Map<dynamic, dynamic> json) {
    return new UserTable(
      UserId: json['UserId'],
      Name: json['Name'],
    );
  }

  Map<String,dynamic> toJson(){
    var map = <String, dynamic>{
      'UserId': UserId,
      'Name':Name,
    };
    return map;
  }
}

class UserOutlet{
  int? UserId;
  int? OutletId;
  String? OutletName;
  String? OutletAddress;
  String? OutletCity;
  String? OutletState;
  String? ZipCode;
  String? PhoneNumber;
  String? Email;
  String? currentDate;
  UserOutlet({this.UserId,this.OutletId,this.OutletName,this.OutletAddress,this.OutletCity,this.OutletState,this.PhoneNumber,
    this.Email,this.ZipCode,this.currentDate});

  factory UserOutlet.fromJson(Map<dynamic, dynamic> json) {
    return new UserOutlet(
      UserId: json['UserId'],
      OutletId: json['OutletId'],
      OutletName: json['OutletName'],
      OutletAddress: json['OutletAddress'],
      OutletCity: json['OutletCity'],
      OutletState: json['OutletState'],
      ZipCode: json['ZipCode'],
      PhoneNumber: json['PhoneNumber'],
      Email: json['Email'],
      currentDate: json['CurrentDate'],
    );
  }

  Map<String,dynamic> toJson(){
    var map = <String, dynamic>{
      'UserId': UserId,
      'OutletId': OutletId,
      'OutletName':OutletName,
    };
    return map;
  }
}

class Captain{
  int? UserId;
  int? OutletId;
  int? CaptainId;
  String? CaptainName;
  String? EmployeeDesignationName;
  Captain({this.UserId,this.OutletId,this.CaptainName,this.EmployeeDesignationName,this.CaptainId});

  factory Captain.fromJson(Map<dynamic, dynamic> json) {
    return new Captain(
      UserId: json['UserId'],
      OutletId: json['OutletId'],
      CaptainId: json['CaptainId'],
      CaptainName: json['CaptainName'],
      EmployeeDesignationName: json['EmployeeDesignationName'],
    );
  }

  Map<String,dynamic> toJson(){
    var map = <String, dynamic>{
      'UserId': UserId,
      'OutletId': OutletId,
      'CaptainName':CaptainName,
    };
    return map;
  }
}

class Waiter{
  int? UserId;
  int? OutletId;
  int? FloorId;
  int? WaiterId;
  String? WaiterName;
  String? EmployeeDesignationName;
  Waiter({this.UserId,this.OutletId,this.WaiterName,this.WaiterId,this.FloorId,this.EmployeeDesignationName});

  factory Waiter.fromJson(Map<dynamic, dynamic> json) {
    return new Waiter(
      UserId: json['UserId'],
      OutletId: json['OutletId'],
      WaiterId: json['WaiterId'],
      WaiterName: json['WaiterName'],
      FloorId: json['FloorId'],
      EmployeeDesignationName: json['EmployeeDesignationName'],
    );
  }

  Map<String,dynamic> toJson(){
    var map = <String, dynamic>{
      'UserId': UserId,
      'OutletId': OutletId,
      'WaiterName':WaiterName,
    };
    return map;
  }
}

class OutletFloor{
  int? OutletId;
  int? FloorId;
  String? FloorName;
  OutletFloor({this.OutletId,this.FloorId,this.FloorName});

  factory OutletFloor.fromJson(Map<dynamic, dynamic> json) {
    return new OutletFloor(
      OutletId: json['OutletId'],
      FloorId: json['FloorId'],
      FloorName: json['FloorName'],
    );
  }

  Map<String,dynamic> toJson(){
    var map = <String, dynamic>{
      'OutletId': OutletId,
      'FloorId':FloorId,
      'FloorName':FloorName,
    };
    return map;
  }

}

class OrderType{
  int? OrderTypeId;
  int? FloorId;
  String? OrderTypeName;
  int? ParentOrderType;
  OrderType({this.OrderTypeId,this.FloorId,this.OrderTypeName,this.ParentOrderType});

  factory OrderType.fromJson(Map<dynamic, dynamic> json) {
    return new OrderType(
      OrderTypeId: json['OrderTypeId'],
      FloorId: json['FloorId'],
      OrderTypeName: json['OrderTypeName'],
      ParentOrderType: json['ParentOrderType'],
    );
  }

  Map<String,dynamic> toJson(){
    var map = <String, dynamic>{
      'OrderTypeId': OrderTypeId,
      'FloorId':FloorId,
      'OrderTypeName':OrderTypeName,
      'ParentOrderType':ParentOrderType,
    };
    return map;
  }

}

class TablesFloor{
  int? FloorId;
  String? FloorName;
  int? TableNumberId;
  String? TableNumber;
  bool IsDynamic;
  int? NoOfSeats;
  bool IsHold;

  String? TableStatus;
  GlobalKey? key;

  double GrandTotalAmount;
  int IsTableMerge;

  int? OrderId;

  TablesFloor({this.FloorId,this.FloorName,this.TableNumberId,this.TableNumber,this.TableStatus,this.key,
    this.IsDynamic=false,this.NoOfSeats,this.IsHold=false,this.GrandTotalAmount=0.0,this.IsTableMerge=0,this.OrderId});

  factory TablesFloor.fromJson(Map<dynamic, dynamic> json) {
    return new TablesFloor(
        FloorId: json['FloorId'],
        FloorName: json['FloorName'],
        TableNumberId: json['TableNumberId'],
        TableNumber: json['TableNumber'],
        IsDynamic: json['IsDynamic']??false,
        NoOfSeats: json['NoOfSeats'],
        IsHold:json['TableStatus']=="Hold"?true: json['IsHold']??false,
        GrandTotalAmount: json['GrandTotalAmount']??0.0,
        IsTableMerge: json['IsTableMerge']??0,
        OrderId: json['OrderId'],
        TableStatus: json['TableStatus']==null?"Free":json['TableStatus'],
        key:GlobalKey()
    );
  }

  Map<String,dynamic> toJson(){
    var map = <String, dynamic>{
      'FloorId': FloorId,
      'FloorName':FloorName,
      'TableNumberId':TableNumberId,
      'TableNumber':TableNumber,
    };
    return map;
  }

}

class MenuList{
  int? OutletId;
  int? MenuId;
  String? MenuName;
  bool isDefault;
  bool isCustomMenu;
  MenuList({this.OutletId,this.MenuId,this.MenuName,this.isDefault=false,this.isCustomMenu=false});

  factory MenuList.fromJson(Map<dynamic, dynamic> json) {
    return new MenuList(
      OutletId: json['OutletId'],
      MenuId: json['MenuId'],
      MenuName: json['MenuName'],
      isDefault: json['IsDefault'],
      isCustomMenu: json['IsCustomMenu']??false,
    );
  }

  Map<String,dynamic> toJson(){
    var map = <String, dynamic>{
      'OutletId': OutletId,
      'MenuId':MenuId,
      'MenuName':MenuName,
    };
    return map;
  }

}

/*NONEeeeDDD*/
class MainCategoryTable4{
  int? MenuId;
  int? MainCategory;
  String? MainCategoryName;
  String imgPath;
  MainCategoryTable4({this.MenuId,this.MainCategory,this.MainCategoryName,this.imgPath="CategoryItems/DefaultCategory.png"});

  factory MainCategoryTable4.fromJson(Map<dynamic, dynamic> json) {
    return new MainCategoryTable4(

        MenuId: json['MenuId'],
        MainCategory: json['MainCategory'],
        MainCategoryName: json['MainCategoryName'],
        imgPath: json['ProductCategoryLogo']
    );
  }

  Map<String,dynamic> toJson(){
    var map = <String, dynamic>{

      'MenuId':MenuId,
      'MainCategory':MainCategory,
      'MainCategoryName':MainCategoryName,
      'imgPath':imgPath,

    };
    return map;
  }

}



class SubCategory{

  int? ProductCategoryId;
  int? ParentProductCategoryId;
  String? ProductCategoryName;
  int? CategoryOrder;
  int? MenuId;
  SubCategory({this.ProductCategoryId,this.ProductCategoryName,this.ParentProductCategoryId,this.CategoryOrder,this.MenuId});

  factory SubCategory.fromJson(Map<dynamic, dynamic> json) {
    return new SubCategory(
      ProductCategoryId: json['ProductCategoryId'],
      ProductCategoryName: json['ProductCategoryName'],
      ParentProductCategoryId: json['ParentProductCategoryId'],
      CategoryOrder:json['CategoryOrder'],
      MenuId:json['MenuId'],
    );
  }

  Map<String,dynamic> toJson(){
    var map = <String, dynamic>{
      'ProductCategoryId':ProductCategoryId,
      'ProductCategoryName':ProductCategoryName,
      'ParentProductCategoryId':ParentProductCategoryId,
      'CategoryOrder':CategoryOrder,
      'MenuId':MenuId,
    };
    return map;
  }

}

class ProductDetails{

  int? ProductCategoryId;
  int? ProductId;
  String? ProductCode;
  String? ProductName;
  String? ProductShortform;
  double? Tax;
  int? ActiveStatus;
  int? OtherChargesId;
  int? KOTCommentId;
  String? KOTComment;
  String? ProductLogo;
  double? TaxAmount;
  double? productPrice;

  int? KotNo;
  int? KotId;
  int? OrderId;
  int? OrderProductId;
  int? OrderNumber;

  dynamic balanceStock;

  double? DineIn;
  double? TakeAway;
  double? HomeDelivery;
  double? QuickService;
  double? TabService;

  int? DineinOrderProductId;
  int? TakeawayOrderProductId;
  int? HomedeliveryOrderProductId;
  int? QuickserviceOrderProductId;


  int? ParcelChargesId;
  bool? IsParcelChargesPercentage;
  double? ParcelChargesAmount;
  double? ParcelChargesValue;

  String? notes;
  TextEditingController? notesController=new TextEditingController();


  int? quantity;
  int? UpdatedProductQuantity;
  double? UpdatedCalculatedPrice;
  double? calculatedprice;
  int? isItemBlink;
  int? tapCount;
  AnimationController? fadeController;
  Animation<double>? animation;

  bool? isDiscount;
  bool? isDiscountPercentage;
  double? discountValue;
  double? discountAmount;

  late bool isModifier;

  List<ProductDetails>? modifiers;


  ProductDetails({this.ProductCategoryId,this.ProductId,this.ProductName,this.ProductCode,this.ProductShortform,this.DineIn,this.HomeDelivery,this.TakeAway,this.QuickService,this.TabService,
    this.calculatedprice,this.quantity,this.isItemBlink,this.tapCount,this.fadeController,this.animation,this.DineinOrderProductId,
    this.TakeawayOrderProductId,this.HomedeliveryOrderProductId,this.QuickserviceOrderProductId,this.UpdatedProductQuantity,
    this.UpdatedCalculatedPrice,this.Tax,this.OtherChargesId,this.KOTComment,this.KOTCommentId,this.ProductLogo,this.TaxAmount,
    this.notes,this.notesController,this.ActiveStatus,this.KotId,this.KotNo,this.OrderId,this.OrderProductId,this.balanceStock,this.ParcelChargesAmount,this.ParcelChargesId,
    this.isDiscount,this.discountAmount,this.discountValue,this.isDiscountPercentage,this.OrderNumber,
    this.productPrice,this.ParcelChargesValue,this.IsParcelChargesPercentage,this.modifiers,this.isModifier=false});

  factory ProductDetails.fromJson(Map<dynamic, dynamic> json) {
    return new ProductDetails(
      ProductCategoryId: json['ProductCategoryId'],
      ProductId: json['ProductId'],
      ProductName: StringUtils.capitalize(json['ProductName']),
      ProductCode: json['ProductCode']??"",
      ProductShortform: json['ProductShortform']??"",
      DineIn: json['DineIn'],
      TakeAway: json['TakeAway'],
      HomeDelivery: json['HomeDelivery'],
      QuickService: json['QuickService'],
      TabService: json['TabService'],
      Tax: json['Tax']??0.0,
      ActiveStatus: json['ActiveStatus'],
      balanceStock: json['BalanceStock'],
      ParcelChargesId: json['ParcelChargesId'],
      IsParcelChargesPercentage: json['IsParcelChargesPercentage']??false,
      ParcelChargesValue: json['ParcelChargesValue']??0.0,
      OtherChargesId:json['OtherChargesId'],
      ProductLogo:json['ProductLogo'],
      quantity: 1,
      tapCount: 0,
      UpdatedProductQuantity: 0,
      UpdatedCalculatedPrice: 0,
      isDiscount: json['IsDiscount']??false,
      isDiscountPercentage: json['IsPercentage']??false,
      discountValue: json['DiscountValue']??0.0,
      discountAmount: json['DiscountAmount']??0.0,
    );
  }

  factory ProductDetails.fromJsonGetBillingOutLet(Map<dynamic, dynamic> json,List<ProductDetails> modifiers) {
    return new ProductDetails(
        ProductCategoryId: json['ProductCategoryId'],
        ProductId: json['ProductId'],
        ProductName: StringUtils.capitalize(json['ProductName']),
        ProductCode: json['ProductCode']??"",
        ProductShortform: json['ProductShortform']??"",
        DineIn: json['DineIn'],
        TakeAway: json['TakeAway'],
        HomeDelivery: json['HomeDelivery'],
        QuickService: json['QuickService'],
        TabService: json['TabService'],
        Tax: json['Tax']??0.0,
        ActiveStatus: json['ActiveStatus'],
        balanceStock: json['BalanceStock'],
        ParcelChargesId: json['ParcelChargesId'],
        IsParcelChargesPercentage: json['IsParcelChargesPercentage']??false,
        ParcelChargesValue: json['ParcelChargesValue']??0.0,
        OtherChargesId:json['OtherChargesId'],
        ProductLogo:json['ProductLogo'],
        isModifier:json['IsModifier']??false,
        quantity: 1,
        tapCount: 0,
        UpdatedProductQuantity: 0,
        UpdatedCalculatedPrice: 0,
        isDiscount: json['IsDiscount']??false,
        isDiscountPercentage: json['IsPercentage']??false,
        discountValue: json['DiscountValue']??0.0,
        discountAmount: json['DiscountAmount']??0.0,
        modifiers: modifiers
    );
  }



  factory ProductDetails.fromJsonDineIn(Map<dynamic, dynamic> json) {
    return new ProductDetails(
      ProductCategoryId: json['ProductCategoryId'],
      ProductId: json['ProductId'],
      ProductName: StringUtils.capitalize(json['ProductName']),
      ProductCode: json['ProductCode']??"",
      ProductShortform: json['ProductShortform']??"",
      DineIn: json['ProductPrice'],
      DineinOrderProductId:json['DineinOrderProductId'],
      quantity: json['ProductQuantity'],
      calculatedprice: json['Amount'],
      Tax: json['Tax']??0.0,
      TaxAmount: json['TaxAmount'],
      OtherChargesId:json['OtherChargesId'],
      ProductLogo:json['ProductLogo'],
      UpdatedProductQuantity: 0,
      UpdatedCalculatedPrice: 0,
      notesController: TextEditingController()..text=json['Notes'],
      KotNo: json['KOTNumber'],
      KotId: json['KOTId'],
      OrderId: json['OrderId'],
      OrderProductId: json['OrderProductId'],
      isDiscount: json['IsDiscount']??false,
      isDiscountPercentage: json['IsPercentage']??false,
      discountValue: json['DiscountValue']??0.0,
      discountAmount: json['DiscountAmount']??0.0,
    );
  }
  factory ProductDetails.fromJsonTakeaway(Map<dynamic, dynamic> json) {
    return new ProductDetails(
      ProductCategoryId: json['ProductCategoryId'],
      ProductId: json['ProductId'],
      ProductName: StringUtils.capitalize(json['ProductName']),
      ProductCode: json['ProductCode']??"",
      ProductShortform: json['ProductShortform']??"",
      TakeAway: json['ProductPrice'],
      TakeawayOrderProductId:json['TakeawayOrderProductId'],
      quantity: json['ProductQuantity'],
      calculatedprice: json['Amount'],
      Tax: json['Tax']??0.0,
      TaxAmount: json['TaxAmount'],
      OtherChargesId: json['OtherChargesId'],
      ProductLogo:json['ProductLogo'],
      UpdatedProductQuantity: 0,
      UpdatedCalculatedPrice: 0,
      notesController: TextEditingController()..text=json['Notes'],
      KotNo: json['KOTNumber'],
      KotId: json['KOTId'],
      OrderId: json['OrderId'],
      OrderProductId: json['OrderProductId'],
      isDiscount: json['IsDiscount']??false,
      isDiscountPercentage: json['IsPercentage']??false,
      discountValue: json['DiscountValue']??0.0,
      discountAmount: json['DiscountAmount']??0.0,
    );
  }
  factory ProductDetails.fromJsonHomeDelivery(Map<dynamic, dynamic> json) {
    return new ProductDetails(
      ProductCategoryId: json['ProductCategoryId'],
      ProductId: json['ProductId'],
      ProductName: StringUtils.capitalize(json['ProductName']),
      ProductCode: json['ProductCode']??"",
      ProductShortform: json['ProductShortform']??"",
      HomeDelivery: json['ProductPrice'],
      HomedeliveryOrderProductId:json['HomeDeliveryOrderProductId'],
      quantity: json['ProductQuantity'],
      calculatedprice: json['Amount'],
      Tax: json['Tax']??0.0,
      TaxAmount: json['TaxAmount'],
      OtherChargesId: json['OtherChargesId'],
      ProductLogo:json['ProductLogo'],
      UpdatedProductQuantity: 0,
      UpdatedCalculatedPrice: 0,
      notesController: TextEditingController()..text=json['Notes'],
      KotNo: json['KOTNumber'],
      KotId: json['KOTId'],
      OrderId: json['OrderId'],
      OrderProductId: json['OrderProductId'],
      isDiscount: json['IsDiscount']??false,
      isDiscountPercentage: json['IsPercentage']??false,
      discountValue: json['DiscountValue']??0.0,
      discountAmount: json['DiscountAmount']??0.0,
    );
  }
  factory ProductDetails.fromJsonQuickService(Map<dynamic, dynamic> json) {
    return new ProductDetails(
      ProductCategoryId: json['ProductCategoryId'],
      ProductId: json['ProductId'],
      ProductName: StringUtils.capitalize(json['ProductName']),
      ProductCode: json['ProductCode']??"",
      ProductShortform: json['ProductShortform']??"",
      QuickService: json['ProductPrice'],
      QuickserviceOrderProductId:json['QuickServiceOrderProductId'],
      quantity: json['ProductQuantity'],
      calculatedprice: json['Amount'],
      Tax: json['Tax']??0.0,
      TaxAmount: json['TaxAmount'],
      OtherChargesId: json['OtherChargesId'],
      ProductLogo:json['ProductLogo'],
      UpdatedProductQuantity: 0,
      UpdatedCalculatedPrice: 0,
      notesController: TextEditingController()..text=json['Notes'],
      KotNo: json['KOTNumber'],
      KotId: json['KOTId'],
      OrderId: json['OrderId'],
      OrderProductId: json['OrderProductId'],
      isDiscount: json['IsDiscount']??false,
      isDiscountPercentage: json['IsPercentage']??false,
      discountValue: json['DiscountValue']??0.0,
      discountAmount: json['DiscountAmount']??0.0,
    );
  }


  factory ProductDetails.deepCopy(ProductDetails productDetails,TickerProviderStateMixin tickerProviderStateMixin)=> ProductDetails(
      ProductCategoryId: productDetails.ProductCategoryId,
      ProductId: productDetails.ProductId,
      ProductName: productDetails.ProductName,
      ProductCode: productDetails.ProductCode,
      ProductShortform: productDetails.ProductShortform,
      DineIn: productDetails.DineIn,
      DineinOrderProductId:productDetails.DineinOrderProductId,
      quantity: productDetails.quantity,
      calculatedprice: productDetails.calculatedprice,
      Tax: productDetails.Tax,
      TaxAmount:productDetails.TaxAmount,
      OtherChargesId:productDetails.OtherChargesId,
      ProductLogo:productDetails.ProductLogo,
      UpdatedProductQuantity: 0,
      UpdatedCalculatedPrice: 0,
      notesController: productDetails.notesController,
      KotNo: productDetails.KotNo,
      KotId: productDetails.KotId,
      OrderId: productDetails.OrderId,
      OrderProductId: productDetails.OrderProductId,
      isDiscount: productDetails.isDiscount,
      isDiscountPercentage: productDetails.isDiscountPercentage,
      discountValue: productDetails.discountValue,
      discountAmount: productDetails.discountAmount,
      fadeController: AnimationController(duration: Duration(milliseconds: 300),vsync: tickerProviderStateMixin,)
  );

  ProductDetails.fromBillHistoryJson(Map<String, dynamic> json) {
    OrderId = json['OrderId'];
    OrderProductId = json['OrderProductId'];
    OrderNumber = json['OrderNumber'];
    ProductId = json['ProductId'];
    ProductName = json['ProductName'];
    productPrice = json['Price'];
    quantity = json['ProductQuantity'];
    calculatedprice = json['Amount'];
    isDiscount = json['IsDiscount'];
    isDiscountPercentage = json['IsPercentage'];
    discountValue = json['DiscountValue'];
    discountAmount = json['DiscountAmount'];
    OtherChargesId = json['OtherChargesId'];
    Tax = json['TaxValue'];
    TaxAmount = json['TaxAmount'];
    ParcelChargesId = json['ParcelChargesId'];
    IsParcelChargesPercentage = json['IsParcelPercentage'];
    ParcelChargesValue = json['ParcelChargesValue'];
    ParcelChargesAmount = json['ParcelChargeAmount'];
    KotId = json['KOTId'];
    notes = json['Notes'];

  }

  Map<String, dynamic> toJsonBillHistory() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrderProductId'] = this.OrderProductId;
    data['OrderTypeOrderId'] = this.OrderId;
    data['ProductId'] = this.ProductId;
    data['Price'] = this.productPrice;
    data['ProductQuantity'] = this.quantity;
    data['Amount'] = this.calculatedprice;
    data['IsDiscount'] = this.isDiscount!?1:0;
    data['IsPercentage'] = this.isDiscountPercentage!?1:0;
    data['DiscountValue'] = this.discountValue;
    data['DiscountAmount'] = this.discountAmount;
    data['OtherChargesId'] = this.OtherChargesId;
    data['TaxAmount'] = this.TaxAmount;
    data['ParcelChargesId'] = this.ParcelChargesId;
    data['IsParcelPercentage'] =this.IsParcelChargesPercentage==null?0: this.IsParcelChargesPercentage!?1:0;
    data['ParcelChargesValue'] = this.ParcelChargesValue;
    data['ParcelChargesAmount'] = this.ParcelChargesAmount;
    data['KOTId'] = this.KotId;
    data['Notes'] = this.notes;
    return data;
  }

  Map<String,dynamic> toJson(){
    var map = <String, dynamic>{
      'OrderProductId':DineinOrderProductId,
      'OrderTypeOrderId':null,
      'ProductId':ProductId,
      'Price':DineIn,
      'ProductQuantity':quantity,
      'Amount':calculatedprice,
      'IsDiscount':isDiscount!?1:0,
      'IsPercentage':isDiscountPercentage!?1:0,
      'DiscountValue':discountValue,
      'DiscountAmount':discountAmount,
      'OtherChargesId':OtherChargesId,
      'TaxAmount':TaxAmount,
      'ParcelChargesId':ParcelChargesId,
      'IsParcelPercentage':IsParcelChargesPercentage==null?0:IsParcelChargesPercentage!?1:0,
      'ParcelChargesValue':ParcelChargesValue??0.0,
      'ParcelChargesAmount':ParcelChargesAmount??0.0,
      'KOTId':KotId,
      'Notes':notesController!=null?notesController!.text:"",
    };
    return map;
  }

  Map<String,dynamic> toJsonFromShiftTable(int? OrderId){
    var map = <String, dynamic>{
      'OrderProductId':DineinOrderProductId,
      'OrderId': OrderId,
      'OrderTypeOrderId':null,
      'CaptainId':null,
      'WaiterId':null,
      'ProductId':ProductId,
      'Price':DineIn,
      'ProductQuantity':quantity,
      'Amount':calculatedprice,
      'IsDiscount':null,
      'IsPercentage':null,
      'DiscountValue':null,
      'OtherChargesId':OtherChargesId,
      'TaxAmount':TaxAmount,
      'KOTId':KotId,
      'KitchenOrderStatusId':null,
      'Notes':notesController!.text,
      'IsActive':null,

    };
    return map;
  }

  Map<String,dynamic> toJsonTakeAway(){
    var map = <String, dynamic>{
      'OrderProductId':TakeawayOrderProductId,
      'OrderTypeOrderId':null,
      'ProductId':ProductId,
      'Price':TakeAway,
      'ProductQuantity':quantity,
      'Amount':calculatedprice,
      'IsDiscount':isDiscount!?1:0,
      'IsPercentage':isDiscountPercentage!?1:0,
      'DiscountValue':discountValue,
      'DiscountAmount':discountAmount,
      'OtherChargesId':OtherChargesId,
      'TaxAmount':TaxAmount,
      'ParcelChargesId':ParcelChargesId,
      'IsParcelPercentage':IsParcelChargesPercentage!?1:0,
      'ParcelChargesValue': ParcelChargesValue,
      'ParcelChargesAmount':ParcelChargesAmount??0.0,
      'KOTId':KotId,
      'Notes':notesController!.text
    };
    return map;
  }

  Map<String,dynamic> toJsonHomeDelivery(){
    var map = <String, dynamic>{
      'OrderProductId':HomedeliveryOrderProductId,
      'OrderTypeOrderId':null,
      'ProductId':ProductId,
      'Price':HomeDelivery,
      'ProductQuantity':quantity,
      'Amount':calculatedprice,
      'IsDiscount':isDiscount!?1:0,
      'IsPercentage':isDiscountPercentage!?1:0,
      'DiscountValue':discountValue,
      'DiscountAmount':discountAmount,
      'OtherChargesId':OtherChargesId,
      'TaxAmount':TaxAmount,
      'ParcelChargesId':null,
      'IsParcelPercentage':0,
      'ParcelChargesValue':0.0,
      'ParcelChargesAmount':0.0,
      'KOTId':KotId,
      'Notes':notesController!.text
    };
    return map;
  }

  Map<String,dynamic> toJsonQuickService(){
    var map = <String, dynamic>{
      'OrderProductId':null,
      'OrderTypeOrderId':null,
      'ProductId':ProductId,
      'Price':QuickService,
      'ProductQuantity':quantity,
      'Amount':calculatedprice,
      'IsDiscount':isDiscount!?1:0,
      'IsPercentage':isDiscountPercentage!?1:0,
      'DiscountValue':discountValue,
      'DiscountAmount':discountAmount,
      'OtherChargesId':OtherChargesId,
      'TaxAmount':TaxAmount,
      'ParcelChargesId':null,
      'IsParcelPercentage':0,
      'ParcelChargeValue':0.0,
      'ParcelChargeAmount':0.0,
      'KOTId':KotId,
      'Notes':notesController!.text
    };
    return map;
  }

  Map<String,dynamic> toHoldOrders(double? price){
    var map = <String, dynamic>{
      'HoldOrderProductMappingId':null,
      'HoldOrderId':null,
      'ProductId':ProductId,
      'Price':price,
      'ProductQuantity':quantity,
      'Amount':calculatedprice,
      'IsDiscount':isDiscount!?1:0,
      'IsPercentage':isDiscountPercentage!?1:0,
      'DiscountValue':discountValue,
      'DiscountAmount':discountAmount,
      'OtherChargesId':OtherChargesId,
      'TaxAmount':TaxAmount,
      'ParcelChargesId':ParcelChargesId,
      'IsParcelPercentage':IsParcelChargesPercentage==null?0:IsParcelChargesPercentage!?1:0,
      'ParcelChargesValue':ParcelChargesValue??0.0,
      'ParcelChargesAmount':ParcelChargesAmount??0.0,
      'KOTId':null,
      'KOTCommentId':null,
      'Notes':notesController!.text.toString(),
      'IsActive':1
    };
    return map;
  }


  Map<String,dynamic> toJsonItemWiseBillSplit(int orderId,){
    var map = <String, dynamic>{
      'BillSplitCombineProductMappingId':null,
      'BillId':null,
      'OrderId':orderId,
      'ProductId':ProductId,
      'Price':DineIn,
      'ProductQuantity':quantity,
      'Amount':calculatedprice,
      'IsDiscount':isDiscount!?1:0,
      'IsPercentage':isDiscountPercentage!?1:0,
      'DiscountValue':discountValue,
      'DiscountAmount':discountAmount,
      'DiscountedAmount':calculatedprice!-discountAmount!,
      'OtherChargesId':OtherChargesId,
      'TaxAmount':TaxAmount,
    };
    return map;
  }
}


class KitchenComment{
  int? KitchenKOTCommentMappingId;
  int? KOTCommentId;
  String? KOTComment;
  int? ProductId;
  int? KOTId;
  int? OrderId;
  int? OrderProductId;

  KitchenComment({this.KOTCommentId,this.KOTComment,this.ProductId,this.KitchenKOTCommentMappingId,this.KOTId,this.OrderId,this.OrderProductId});

  factory KitchenComment.fromJson(Map<String, dynamic> json) {
    return new KitchenComment(
      KOTCommentId: json['KOTCommentId'],
      KOTComment: json['KOTComment'],
      ProductId: json['ProductId'],
      KitchenKOTCommentMappingId: json['KitchenKOTCommentMappingId'],
      KOTId: json['KOTId'],
      OrderId: json['OrderId'],
      OrderProductId: json['OrderProductId'],
    );
  }

  Map<String,dynamic> toJson(){
    var map = <String, dynamic>{
      'KitchenKOTCommentMappingId':null,
      'KOTCommentId': KOTCommentId,
      'KOTComment':KOTComment,
      'ProductId':ProductId,
    };
    return map;
  }

  Map<String,dynamic> shiftTabletoJson(int? orderProductId){
    var map = <String, dynamic>{
      'KitchenKOTCommentMappingId':null,
      'KOTCommentId': KOTCommentId,
      'KOTComment':KOTComment,
      'KOTId':KOTId,
      'OrderProductId':OrderProductId,
      'ProductId':ProductId,
    };
    return map;
  }
}

class AddOns{
  int? KOTAddOnMappingId;
  int? AddonId;
  String? AddOnName;
  int? ProductId;
  int? KOTId;
  int? OrderId;
  int? OrderProductId;

  AddOns({this.AddonId,this.AddOnName,this.ProductId,this.KOTAddOnMappingId,this.KOTId,this.OrderId,this.OrderProductId});

  factory AddOns.fromJson(Map<String, dynamic> json) {
    return new AddOns(
      AddonId: json['AddOnId'],
      AddOnName: json['AddOnName'],
      ProductId: json['ProductId'],
      KOTAddOnMappingId: json['KOTAddOnMappingId'],
      KOTId: json['KOTId'],
      OrderId: json['OrderId'],
      OrderProductId: json['OrderProductId'],
    );
  }

  Map<String,dynamic> toJson(){
    var map = <String, dynamic>{
      'KOTAddOnMappingId':null,
      'AddOnId': AddonId,
      'ProductId':ProductId,
    };
    return map;
  }

  Map<String,dynamic> shiftTabletoJsonAddons(){
    var map = <String, dynamic>{
      'FromKOTAddOnMappingId':null,
      'AddOnId': AddonId,
      'ProductId':ProductId,
      'KOTId':KOTId,
      'OrderProductId':OrderProductId,

    };
    return map;
  }

}

class TableSeats{
  int? TableSeatNumberMappingId;
  int? OrderId;
  int? SeatNumber;
  int? ProductId;
  int? KOTId;
  int? IsActive;

  TableSeats({this.OrderId,this.SeatNumber,this.ProductId,this.TableSeatNumberMappingId,this.KOTId,this.IsActive});

  factory TableSeats.fromJson(Map<String, dynamic> json) {
    return new TableSeats(
      OrderId: json['OrderId'],
      TableSeatNumberMappingId: json['TableSeatNumberMappingId'],
      SeatNumber: json['SeatNumber'],
      ProductId: json['ProductId'],
      IsActive: json['IsActive'],
      KOTId: json['KOTId'],
    );
  }

  Map<String,dynamic> toJson(){
    var map = <String, dynamic>{
      'TableSeatNumberMappingId':null,
      'OrderId': OrderId,
      'KOTId':KOTId,
      'ProductId':ProductId,
      'SeatNumber':SeatNumber,
      'IsActive':IsActive,

    };
    return map;
  }

  Map<String,dynamic> toHoldOrderJson(){
    var map = <String, dynamic>{
      'HoldOrderSeatNumberMappingId':null,
      'OrderId': OrderId,
      'KOTId':KOTId,
      'ProductId':ProductId,
      'SeatNumber':SeatNumber,
      'IsActive':IsActive,

    };
    return map;
  }
}

class PaymentType{
  int? PaymentId;
  String? PaymentName;
  int? PaymentCategoryId;
  double? ServiceFee;


  PaymentType({this.PaymentName,this.PaymentCategoryId,this.ServiceFee,this.PaymentId});

  factory PaymentType.fromJson(Map<String, dynamic> json) {
    return new PaymentType(
      PaymentId: json['PaymentId'],
      PaymentName: json['PaymentName'],
      PaymentCategoryId: json['PaymentCategoryId'],
      ServiceFee: json['ServiceFee'],
    );
  }

  Map<String,dynamic> toJson(){
    var map = <String, dynamic>{
      'PaymentId':PaymentId,
      'PaymentName': PaymentName,
      'ServiceFee':ServiceFee,
      'PaymentCategoryId':PaymentCategoryId,

    };
    return map;
  }
}

class ProductDetailMaster{
  List<UserTable>? userTable;
  List<UserOutlet>? userOutlet;
  List<Captain>? captain;
  List<Waiter>? waiter;
  List<OutletFloor>? outletFloor;
  List<OrderType>? orderType;
  List<TablesFloor>? tablesFloor;
  List<MenuList>? menuList;
  List<SubCategory>? subCategory;
  List<dynamic>? productList;
  List<dynamic>? consolidateModifiersList;
  List<dynamic>? kitchenComments;
  List<dynamic>? addons;
  List<dynamic>? paymentType;
  String? startDate;

  List<dynamic>? otherCharges;
  List<dynamic>? productOtherCharges;
  List<dynamic>? productTaxes;
  List<dynamic>? parentOtherCharges;

  ProductDetailMaster({this.userTable,this.userOutlet,this.captain,this.waiter,this.outletFloor,this.orderType,
    this.tablesFloor,this.menuList,this.subCategory,this.productList,this.kitchenComments,this.addons,this.paymentType,
    this.startDate,this.consolidateModifiersList,this.otherCharges,this.productOtherCharges,this.productTaxes,this.parentOtherCharges});

  factory ProductDetailMaster.fromJson(Map<dynamic,dynamic> json){
    var _userTable=json["Table"] as List;
    // var _userOutlet=json["Table1"] as List;
    // var _captain=json["Table2"] as List;
    // var _waiter=json["Table3"] as List;
    var _outletFloor=json["Table4"] as List;
    var _orderType=json["Table5"] as List;
    var _tablesFloor=json["Table6"] as List;
    var _menuList=json["Table7"] as List;
    var _subCategory=json["Table8"] as List;
    var _productList=json["Table9"] as List;
    var _kcList=json["Table10"] as List;
    var _addonsList=json["Table11"] as List;
    var _paymentTypeList=json["Table12"] as List;
    List<dynamic>? _dateeList=[];
    _dateeList=json["Table13"] as List?;
    // log("json[Table21] ${json["Table21"]}");
    var _modifiersList=[];
    if(json["Table21"]!=null){
      _modifiersList=json["Table21"] as List;
    }
    List<UserTable> userTableList  =_userTable.map((e) => UserTable.fromJson(e)).toList();
    /*
    List<UserOutlet> userOutletList=_userOutlet.map((e) => UserOutlet.fromJson(e)).toList();
    List<Captain> captainList      =_captain.map((e) => Captain.fromJson(e)).toList();
    List<Waiter> waiterList        =_waiter.map((e) => Waiter.fromJson(e)).toList();*/

    List<UserOutlet> userOutletList=[];
    List<Captain> captainList      =[];
    List<Waiter> waiterList        =[];
    List<OutletFloor> outletFloorList=_outletFloor.map((e) => OutletFloor.fromJson(e)).toList();
    List<OrderType> orderTypeList=_orderType.map((e) => OrderType.fromJson(e)).toList();
    List<TablesFloor> tablesFloorList=_tablesFloor.map((e) => TablesFloor.fromJson(e)).toList();
    List<MenuList> menuList=_menuList.map((e) => MenuList.fromJson(e)).toList();
    List<SubCategory> subCategoryList=_subCategory.map((e) => SubCategory.fromJson(e)).toList();
    //List<ProductDetails> productList=_productList.map((e) => ProductDetails.fromJsonGetBillingOutLet(e,[])).toList();
    /*  List<ProductDetails> productList=[];
    List<ProductDetails> consolidateModifiers=_modifiersList.map((e) => ProductDetails.fromJson(e)).toList();

    _productList.forEach((element) {
      if(element['IsModifier']){
        List<ProductDetails> tempModifiersMain=[];
        List<dynamic> tempModifiers=_modifiersList.where((ele) => ele['ParentProductId']==element['ProductId']).toList();
        tempModifiersMain=tempModifiers.map((e) => ProductDetails.fromJsonGetBillingOutLet(e,[])).toList();
     //   log("tempModifiersMain $tempModifiersMain");
        productList.add(ProductDetails.fromJsonGetBillingOutLet(element,tempModifiersMain));
     //   productList.add(ProductDetails.fromJsonGetBillingOutLet(element,tempModifiers.map((e) => ProductDetails.fromJsonGetBillingOutLet(e,[])).toList()));
      }
      else{
        productList.add(ProductDetails.fromJsonGetBillingOutLet(element,[]));
      }
    });*/
    // log("_productList $_productList");

    /*List<KitchenComment> kcList=_kcList.map((e) => KitchenComment.fromJson(e)).toList();
    List<AddOns> addonsList=_addonsList.map((e) => AddOns.fromJson(e)).toList();
    List<PaymentType> paymentTypeList=_paymentTypeList.map((e) => PaymentType.fromJson(e)).toList();*/
    return new ProductDetailMaster(
        userTable: userTableList,
        userOutlet: userOutletList,
        captain: captainList,
        waiter: waiterList,
        outletFloor: outletFloorList,
        orderType: orderTypeList,
        tablesFloor: tablesFloorList,
        menuList: menuList,
        subCategory: subCategoryList,
        productList: _productList,
        kitchenComments: _kcList,
        addons: _addonsList,
        paymentType: _paymentTypeList,
        consolidateModifiersList: [],
        startDate:_dateeList!.isNotEmpty?_dateeList[0]['StartedDate']:"",
        otherCharges: json["Table17"] as List,
        productOtherCharges: json["Table19"] as List,
        productTaxes: json["Table20"] as List,
        parentOtherCharges: json["Table21"] as List
    );
  }
}