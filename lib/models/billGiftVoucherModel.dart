import 'package:flutter/cupertino.dart';

class BillGiftVoucherModel{

  int? billGiftVoucherMappingId;
  int? billId;
  int? giftVoucherId;
  String? giftVoucherName;
  double? giftVoucherValue;
  TextEditingController? giftVoucherQuantity;
  int? qty;
  double? amount;


  BillGiftVoucherModel({this.billGiftVoucherMappingId,this.billId,this.giftVoucherId,this.amount,
    this.giftVoucherQuantity,this.giftVoucherValue,this.giftVoucherName,this.qty});

   BillGiftVoucherModel.fromJson(Map<String, dynamic> json) {

        this.billGiftVoucherMappingId= json['CustomerFeedBackId'];
        this.billId= json['BillId'];
     this.giftVoucherId= json['GiftVoucherId'];
     this.giftVoucherValue= json['GiftVoucherValue'];
     this.giftVoucherName= json['GiftVoucherName'];
     if(json['GiftVoucherQuantity']!=null){
       this.giftVoucherQuantity!.text= json['GiftVoucherQuantity'].toString();
     }

     this.amount= json['Amount'];
  }
   BillGiftVoucherModel.fromJsonLocal(Map<String, dynamic> json) {

        this.billGiftVoucherMappingId= json['CustomerFeedBackId'];
        this.billId= json['BillId'];
     this.giftVoucherId= json['GiftVoucherId'];
     this.giftVoucherValue= json['GiftVoucherValue'];
     this.giftVoucherName= json['GiftVoucherName'];
       this.qty= json['qty'];

     this.amount= json['Amount'];
  }

  Map<String,dynamic> toJson(){
    var map = <String, dynamic>{
      'BillGiftVoucherMappingId':billGiftVoucherMappingId,
      'BillId': billId,
      'GiftVoucherId':giftVoucherId,
      'GiftVoucherQuantity':giftVoucherQuantity!.text.isNotEmpty?int.parse(giftVoucherQuantity!.text):0,
      'Amount':amount,
      'IsActive':1,
    };
    return map;
  }

  Map<String,dynamic> toJsonLocal(){
    var map = <String, dynamic>{
      'BillGiftVoucherMappingId':billGiftVoucherMappingId,
      'BillId': billId,
      'GiftVoucherId':giftVoucherId,
      'GiftVoucherName':giftVoucherName,
      'GiftVoucherValue':giftVoucherValue,
      'qty':qty,
      'Amount':amount,
      'IsActive':1,
    };
    return map;
  }


}