import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/ApiManager.dart';
import '../../../models/customerDetails_model.dart';
import '../../../models/parameterMode.dart';
import '../../utils/apiUtils.dart';

TextEditingController firstName=new TextEditingController();
TextEditingController lastName=new TextEditingController();
TextEditingController phoneNumber=new TextEditingController();
TextEditingController Email=new TextEditingController();
TextEditingController address1=new TextEditingController();
TextEditingController address2=new TextEditingController();
TextEditingController zipCode=new TextEditingController();
TextEditingController landMark=new TextEditingController();

int customerListindex=-1;

/*
List<CustomerRemainder> remainderList=[];
RxList<CustomerDetailModel> customersList=RxList<CustomerDetailModel>();
RxList<CustomerDetailModel> filterCustomersList=RxList<CustomerDetailModel>();

void clearTextControllers(){
  firstName.clear();
  lastName.clear();
  phoneNumber.clear();
  Email.clear();
  address1.clear();
  address2.clear();
  zipCode.clear();
  landMark.clear();
  remainderList.clear();
}


void customerPopUpOpen(){
  Get.to(CustomerDetails());
}

void getCustomerList() async{
  customersList.value=[];
  filterCustomersList.value=[];
  List<ParameterModel> params= await getParameterEssential();
  params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.getCustomer));
  ApiManager().GetInvoke(params).then((value){
    if(value[0]){
      var parsed=json.decode(value[1]);
      var t=parsed["Table"] as List;
      customersList.value=t.map((e) => CustomerDetailModel.fromJson(e)).toList();
      filterCustomersList.value=customersList.value;
      checkCustomerSelect();
    }
  });
}


void OnCustomerclick(id,index) {
  if(HasCurrentOrder()){
    if (c_orderDetail.value!.customerId != id) {
      c_orderDetail.value!.customerId = id;
      customerListindex=index;
    }
  }
}

void checkCustomerSelect(){
  if(HasCurrentOrder()){
    if (c_orderDetail.value!.customerId != null && c_orderDetail.value!.customerId!>0) {
      customerListindex=filterCustomersList.value.indexWhere((element) => element.customerId==c_orderDetail.value!.customerId);
      CustomerDetailModel customerDetailModel=filterCustomersList.removeAt(customerListindex);
      filterCustomersList.insert(0, customerDetailModel);
      customerListindex=0;
      filterCustomersList.refresh();
    }
  }
}
*/






class CustomerDetailModel {
  int? customerId;
  String? shortCode;
  String? displayName;
  String? email;
  String? phoneNumber;
  String? address1HomeAddress;
  String? address2OfficeAddress;
  String? zipcode;
  String? landMark;

  CustomerDetailModel(
      {this.customerId,
        this.shortCode,
        this.displayName,
        this.email,
        this.phoneNumber,
        this.address1HomeAddress,
        this.address2OfficeAddress,
        this.zipcode,
        this.landMark});

  CustomerDetailModel.fromJson(Map<String, dynamic> json) {
    customerId = json['CustomerId'];
    shortCode = json['ShortCode'];
    displayName = json['DisplayName'];
    email = json['Email'];
    phoneNumber = json['PhoneNumber'];
    address1HomeAddress = json['Address1HomeAddress'];
    address2OfficeAddress = json['Address2OfficeAddress'];
    zipcode = json['Zipcode'];
    landMark = json['LandMark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerId'] = this.customerId;
    data['ShortCode'] = this.shortCode;
    data['DisplayName'] = this.displayName;
    data['Email'] = this.email;
    data['PhoneNumber'] = this.phoneNumber;
    data['Address1HomeAddress'] = this.address1HomeAddress;
    data['Address2OfficeAddress'] = this.address2OfficeAddress;
    data['Zipcode'] = this.zipcode;
    data['LandMark'] = this.landMark;
    return data;
  }
}