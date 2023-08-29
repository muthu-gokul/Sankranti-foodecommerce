class CustomerDetailsModel {

  String? name;
  String?  phonenumber;

  int? CustomerId;
  String? CustomerFirstName;
  String? CustomerLastName;
  String? PhoneNumber;
  String? Email;
  String? Address1;
  String? Address2;
  String? Zipcode;
  String? LandMark;

  CustomerDetailsModel({this.name,this.phonenumber,this.CustomerId,this.CustomerFirstName,this.CustomerLastName,this.PhoneNumber,
  this.Email,this.Address1,this.Address2,this.Zipcode,this.LandMark});
  factory CustomerDetailsModel.fromJson(Map<String, dynamic> json) {
    return new CustomerDetailsModel(
        name: json['name'],
        phonenumber:json['phonenumber'],
        CustomerId:json['CustomerId'],
      CustomerFirstName:json['CustomerFirstName'],
      CustomerLastName:json['CustomerLastName'],
      PhoneNumber:json['PhoneNumber'],
      Email:json['Email'],
      Address1:json['Address1'],
      Address2:json['Address2'],
      Zipcode:json['Zipcode'],
      LandMark:json['LandMark'],
    );
  }

}