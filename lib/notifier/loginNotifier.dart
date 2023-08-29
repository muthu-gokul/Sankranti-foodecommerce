import 'package:flutter/material.dart';



class LoginTable {
  int? UserId;
  int? OutletCount;
  int? UserPin;
  String? Name;
  String? DataBaseName;
  String? CompanyName;
  int? IsMasteruser;
  bool IsMultiOutletUser;


  LoginTable({this.UserId,this.OutletCount,this.UserPin,this.Name,this.DataBaseName,this.CompanyName,this.IsMasteruser,
    this.IsMultiOutletUser=false});

  factory LoginTable.fromJson(Map<dynamic, dynamic> json) {
    return new LoginTable(
      UserId: json['UserId'],
      OutletCount: json['OutletCount'],
      UserPin: json['UserPin'],
      Name: json['Name'],
      DataBaseName: json['DataBaseName'],
      CompanyName: json['CompanyName'],
      IsMasteruser: json['IsMasteruser']??0,
      IsMultiOutletUser: json['IsMultiOutletUser']??false,
    );
  }
}

class LoginTblOutPut {

  String? Status;
  String? Message;


  LoginTblOutPut(
      {this.Status,this.Message});

  factory LoginTblOutPut.fromJson(Map<String, dynamic> json) {
    return new LoginTblOutPut(
      Status: json['@Status'],
      Message: json['@Message'],

    );
  }

  Map<String,dynamic> toJson(){
    var map = <String, dynamic>{
      'Status': Status,
      'Message':Message,


    };
    return map;
  }


}


class LoginModel{
  List<LoginTable>? loginTable;
  List<LoginTable>? allUsers;
  List<LoginTblOutPut>? loginTblOutput;
  LoginModel({this.loginTable,this.loginTblOutput,this.allUsers});

  factory LoginModel.fromJson(Map<dynamic, dynamic> json) {
    var loginTableJson=json['Table1'] as List;
    var allUSersJson=json['Table2'] as List?;
    var loginTblOutputJson=json['TblOutPut'] as List;
    List<LoginTable> _loginTable=loginTableJson.map((e) => LoginTable.fromJson(e)).toList();
    List<LoginTable> _allUSersTable=allUSersJson!=null? allUSersJson.map((e) => LoginTable.fromJson(e)).toList():[];
    List<LoginTblOutPut> _loginTblOutput=loginTblOutputJson.map((e) => LoginTblOutPut.fromJson(e)).toList();
    return new LoginModel(
        loginTable: _loginTable,
        loginTblOutput: _loginTblOutput,
        allUsers:_allUSersTable
    );
  }
}


class LoginNotifier extends ChangeNotifier{
  late LoginModel userDetail;
  bool loading=false;



  void fetchUserDetails(var parsed){
    userDetail=LoginModel.fromJson(parsed);
    notifyListeners();
  }
}