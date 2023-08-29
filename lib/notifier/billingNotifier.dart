import 'package:flutter/material.dart';






class BillingNotifier extends ChangeNotifier{

}



// class InnerSub{
//   SubCategoryTable5 subCategoryTable5;
//   List<SubCategoryTable5> InnerSubList;
//
// }


class TableServiceTakeAwaySettingsCheckBox{
  bool? value;
  String? title;
  TableServiceTakeAwaySettingsCheckBox({this.value,this.title});
}

class TableServiceTakeAwayModel{
  int? status;
  double? price;
  String? IdNumber;
  String? waitingTime;

  TableServiceTakeAwayModel({this.status, this.price, this.IdNumber, this.waitingTime});
}















