class BillHeader{
  int? OrderNumber;
  int? OrderId;
  int? BillNumber;
  int? BillId;
  String? OrderTypeName;
  String? FloorName;
  String? TableNumber;
  String? DynamicTable;
  int? Covers;
  double? SubTotal;
  double? DiscountValue;
  double? DiscountAmount;
  double? GrandTotal;
  bool? IsPaid;
  bool? IsActive;


  BillHeader({this.OrderNumber,this.OrderId,this.BillNumber,this.BillId,this.OrderTypeName,this.FloorName,this.TableNumber,this.DynamicTable,
    this.Covers,this.SubTotal,this.DiscountValue,this.GrandTotal,this.IsPaid,this.IsActive,this.DiscountAmount});


  factory BillHeader.fromJson(Map<dynamic, dynamic> json) {
    return new BillHeader(
      OrderNumber: json['OrderNumber'],
      OrderId: json['OrderId'],
      BillNumber: json['BillNumber'],
      BillId: json['BillId'],
      OrderTypeName: json['OrderTypeName'],
      FloorName: json['FloorName'],
      TableNumber: json['TableNumber'],
      DynamicTable: json['DynamicTable'],
      Covers: json['Covers'],
      SubTotal: json['SubTotal'],
      DiscountValue: json['DiscountValue'],
      DiscountAmount: json['DiscountAmount'],
      GrandTotal: json['GrandTotal'],
      IsPaid: json['IsPaid'],
      IsActive: json['IsActive'],
    );
  }

  Map<String,dynamic> toJson(){
    var map = <String, dynamic>{
      'OrderNumber': OrderNumber,
      'OrderId': OrderId,
      'BillId': BillId,
      'BillNumber':BillNumber,
      'OrderTypeName':OrderTypeName,
      'FloorName':FloorName,
      'TableNumber':TableNumber,
      'DynamicTable':DynamicTable,
      'Covers':Covers,
      'SubTotal':SubTotal,
      'DiscountValue':DiscountValue,
      'DiscountAmount':DiscountAmount,
      'GrandTotal':GrandTotal,
      'IsPaid':IsPaid,
      'IsActive':IsActive,
    };
    return map;
  }
}

class BillItems{
  int? OrderNumber;
  // int KOTNumber;
  String? ProductName;
  int?  ProductQuantity;
  double?  Amount;
  double?  ProductPrice;
  double?  TaxValue;
  // String KOTComment;



  BillItems({this.OrderNumber,this.ProductName,this.ProductQuantity,this.Amount,this.ProductPrice,this.TaxValue});

  factory BillItems.fromJson(Map<dynamic, dynamic> json) {
    return new BillItems(
      OrderNumber: json['OrderNumber'],
      ProductName: json['ProductName'],
      ProductQuantity: json['ProductQuantity'],
      Amount: json['Amount'],
      ProductPrice: json['Price'],
      TaxValue: json['TaxValue'],

    );
  }

  Map<String,dynamic> toJson(){
    var map = <String, dynamic>{
      'OrderNumber': OrderNumber,
      'ProductName':ProductName,
      'ProductQuantity':ProductQuantity,
      'Amount':Amount,
      'ProductPrice':ProductPrice,
      'TaxValue':TaxValue,

    };
    return map;
  }
}

class BillKoTNumber{
  String? KOTNumber;
  BillKoTNumber({this.KOTNumber});
  factory BillKoTNumber.fromJson(Map<dynamic, dynamic> json) {
    return new BillKoTNumber(
      KOTNumber: json['KOTNumber'],

    );
  }

  Map<String,dynamic> toJson(){
    var map = <String, dynamic>{
      'KOTNumber':KOTNumber,

    };
    return map;
  }
}
class BillPaymentMappingList{
  int? BillPaymentMappingId;
  int? PaymentId;
  double? Amount;
  double? Tips;
  BillPaymentMappingList({this.BillPaymentMappingId,this.PaymentId,this.Amount,this.Tips});
  factory BillPaymentMappingList.fromJson(Map<dynamic, dynamic> json) {
    return new BillPaymentMappingList(
      BillPaymentMappingId: json['BillPaymentMappingId'],
      PaymentId: json['PaymentId'],
      Amount: json['Amount'],
      Tips: json['Tips'],

    );
  }

  Map<String,dynamic> toJson(){
    var map = <String, dynamic>{
      'BillPaymentMappingId':BillPaymentMappingId,
      'PaymentId':PaymentId,
      'Amount':Amount,
      'Tips':Tips,

    };
    return map;
  }
}