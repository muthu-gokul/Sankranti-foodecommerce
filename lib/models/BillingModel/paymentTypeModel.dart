class PaymentTypeMapping {
  int? billPaymentMappingId;
  int? billId;
  double? amount;
  int? paymentId;
  String? paymentName;

  PaymentTypeMapping(
      {this.billPaymentMappingId,
        this.billId,
        this.amount,
        this.paymentId,
        this.paymentName});

  PaymentTypeMapping.fromJson(Map<String, dynamic> json) {
    billPaymentMappingId = json['BillPaymentMappingId'];
    billId = json['BillId'];
    amount = json['Amount'];
    paymentId = json['PaymentId'];
    paymentName = json['PaymentName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BillPaymentMappingId'] = this.billPaymentMappingId;
    data['BillId'] = this.billId;
    data['PaymentId'] = this.paymentId;
    data['PaymentName'] = this.paymentName;
    data['Amount'] = this.amount;
    return data;
  }

  toJsonSettlement(billId) {
    final  data = {};
    data['BillPaymentMappingId'] = this.billPaymentMappingId;
    data['BillId'] = billId;
    data['PaymentId'] = this.paymentId;
    data['PaymentName'] = this.paymentName;
    data['Amount'] = this.amount;
    return data;
  }

  createPaymentType(pId, pName, amt) {
    PaymentTypeMapping paymentType = new PaymentTypeMapping();
    paymentType.paymentId = int.parse(pId.toString());
    paymentType.paymentName = pName;
    paymentType.amount = double.parse(amt.toString());
    return paymentType;
  }
}