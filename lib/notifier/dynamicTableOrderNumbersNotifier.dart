import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../api/ApiManager.dart';

import '../models/parameterMode.dart';
import 'Billing/configuration.dart';
import 'utils/apiUtils.dart';
class DynamicTableDetails extends ChangeNotifier{
  // int? DynamicOrderNumber;
  // int? DynamicOrderId;
  //
  // int? ParcelDynamicTable;
  // int? TokenNumber;
  //
  // int? HomeDeliveryDynamicTable;
  // int? HomedeliveryOrderNumber;
  //
  // int? QuickServiceDynamicTable;
  // int? QuickServiceOrderNumber;


//int OrderTypeID
  Future<dynamic> GetDynamicDetailsHit(int OrderTypeId) async{
    showLoader.value=true;

    List<ParameterModel> params=[];
    params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: "RB_Billing_Mobile_GenerateOrderNumber"));
    params.add(ParameterModel(Key: "OrderTypeId", Type: "int", Value: OrderTypeId));
    params.add(ParameterModel(Key: "DeviceId", Type: "String", Value: getDeviceId()));
    var body= {
      "Fields": params
    };
    final response = await http.post(Uri.parse(GetBaseUrl()+"/api/Mobile/GetInvoke"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body)
    );
    showLoader.value=false;

    var parsed=json.decode(response.body);
    print("DYNAMIC ORDER SP RESULTS--------$parsed");

/*    if(OrderTypeId==1){
      DynamicOrderNumber=parsed["Table"][0]['OrderNumber'];
      DynamicOrderId=parsed["Table"][0]['OrderId'];
      notifyListeners();
    }
    else if(OrderTypeId==2){
      DynamicOrderNumber=parsed["Table"][0]['OrderNumber'];
      DynamicOrderId=parsed["Table"][0]['OrderId'];
      ParcelDynamicTable=parsed["Table"][0]['DynamicTable'];
      notifyListeners();
    }
    else if(OrderTypeId==3){
      DynamicOrderNumber=parsed["Table"][0]['OrderNumber'];
      DynamicOrderId=parsed["Table"][0]['OrderId'];
      HomeDeliveryDynamicTable=parsed["Table"][0]['DynamicTable'];
      notifyListeners();
    }
    else if(OrderTypeId==4){
      DynamicOrderNumber=parsed["Table"][0]['OrderNumber'];
      DynamicOrderId=parsed["Table"][0]['OrderId'];
      QuickServiceDynamicTable=parsed["Table"][0]['DynamicTable'];
      notifyListeners();
    }*/
    return parsed;
  }

}