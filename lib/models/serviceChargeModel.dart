class ServiceTax {
  int? otherChargesId;
  String? otherChargesName;
  bool? isPercentage;
  bool? isAmount;
  double? otherChargesValue;
  int? otherChargesCategoryId;
  String? otherChargesCategoryName;

  ServiceTax(
      {this.otherChargesId,
        this.otherChargesName,
        this.isPercentage,
        this.isAmount,
        this.otherChargesValue,
        this.otherChargesCategoryId,
        this.otherChargesCategoryName});

  ServiceTax.fromJson(Map<String, dynamic> json) {
    otherChargesId = json['OtherChargesId'];
    otherChargesName = json['OtherChargesName'];
    isPercentage = json['IsPercentage'];
    isAmount = json['IsAmount'];
    otherChargesValue = json['OtherChargesValue'];
    otherChargesCategoryId = json['OtherChargesCategoryId'];
    otherChargesCategoryName = json['OtherChargesCategoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OtherChargesId'] = this.otherChargesId;
    data['OtherChargesName'] = this.otherChargesName;
    data['IsPercentage'] = this.isPercentage;
    data['IsAmount'] = this.isAmount;
    data['OtherChargesValue'] = this.otherChargesValue;
    data['OtherChargesCategoryId'] = this.otherChargesCategoryId;
    data['OtherChargesCategoryName'] = this.otherChargesCategoryName;
    return data;
  }
}