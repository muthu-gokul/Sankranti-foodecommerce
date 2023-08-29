/*
import 'dart:convert';
import 'dart:developer';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';

import '../../../Popup/alertDialog.dart';
import '../../../api/ApiManager.dart';
import '../../../models/parameterMode.dart';
import '../../../widgets/src/printerService/printer/enums.dart';
import '../../../widgets/src/printerService/printer/network_printer.dart';
import '../../../widgets/src/printerService/printer/utils/src/capability_profile.dart';
import '../../../widgets/src/printerService/printer/utils/src/enums.dart';
import '../../../widgets/src/printerService/printer/utils/src/pos_column.dart';
import '../../../widgets/src/printerService/printer/utils/src/pos_styles.dart';
import '../../utils.dart';


const String ESC = "\u001B";
const String GS = "\u001D";
const String InitializePrinter = ESC + "@";
const String BoldOn = ESC + "E" + "\u0001";//u0011
const String BoldOn2 = ESC + "E" + "\u0111";//u0011
const String BoldOff = ESC + "E" + "\0";
const String DoubleOn = GS + "!" + "\u0011";//u0001
const String DoubleOn2 = GS + "!" + "\u0001";//u0001
const String DoubleOff = GS + "!" + "\0";




void getPrinterTemplate(String printerJson){
  try{
    if(printerJson.isNotEmpty){
      var parsedPrinter=json.decode(printerJson);
      log("parsedPrinter ${parsedPrinter}");
      parsedPrinter.forEach((e) async {
        var proceed=false;
        if(e['printerType']!=null&& e['printerType']!=''){
          if(e['printerType']=="Network Printer"){
            if(e['printerIpAddress']!=null && e['printerIpAddress']!='') {
              proceed = true;
            }
          }
          else if(e['printerType'].toString().toLowerCase()=="usb"){
            //print(softControls['hasExePrinting']);
            if(softControls['hasExePrinting'].toString().toLowerCase()=="true"){
              proceed=false;
              exePrinterCall(e);
            }
            else if(e['printerIpAddress']!=null && e['printerIpAddress']!='') {
              proceed = true;
            }
          }
          else if(e['printerType']=="Bluetooth"){
            if(e['printerName']!=null && e['printerName']!='') {
              proceed = true;
            }
          }

          if(proceed){
            if(e['printTemplateName']=="KOTFormat1"){
              await KOTFormat1(e);
            }
            else if(e['printTemplateName']=="KOTFormat2"){
              await KOTFormat1(e);
            }
            else if(e['printTemplateName']=="BillFormat3"){
              await BillFormat3(e);
            }
            else if(e['printTemplateName']=="BillFormat2"){
              await BillFormat3(e);
            }
            else if(e['printTemplateName']=="BillFormat4"){
              await BillFormat4(e,e['printerName']);
            }
          }
        }
      });
    }
  }
  catch(e){
    CustomAlert().commonErrorAlert("Print Receipt", e.toString());
  }
}
*/
/*   width 6 //23 chars   *//*


Future<void> KOTFormat1(printerDetail,{bool needReConnect=true}) async {
  // print(printerDetail['printerIpAddress']);
  var printDetail = printerDetail['printDetail'];
  var orderDetail = printDetail['orderDetail'];
  var productList = printDetail["productList"];
  // print(orderDetail);

  PosPrintResult res;
  const PaperSize paper = PaperSize.mm80;
  final profile = await CapabilityProfile.load();
  final printer = NetworkPrinter(paper, profile);
  res = await printer.connect(printerDetail['printerIpAddress'].toString(), port: 9100,timeout: Duration(milliseconds: SOCKET_TIMEOUT));
  //printer.disconnect();
  //print(res.msg);
  if (res == PosPrintResult.success){
    try{
      if(orderDetail['SuperTitle']!=''&&orderDetail['SuperTitle']!=null){
        printerRowTemplate1(printer,orderDetail['SuperTitle']);
        //printer.emptyLines(1);
      }
      if(orderDetail['Title']!=''&&orderDetail['Title']!=null){
        printerRowTemplate1(printer,orderDetail['Title']);
        //printer.emptyLines(1);
      }
      if(orderDetail['SubTitle']!=''&&orderDetail['SubTitle']!=null){
        printerRowTemplate1(printer,orderDetail['SubTitle']);
        //printer.emptyLines(1);
      }
      printer.row([
        PosColumn(text: BoldOn+'${orderDetail["OrderTypeName"]}   '+BoldOff, width: 6,styles: PosStyles(align:PosAlign.left,height: PosTextSize.size1, width: PosTextSize.size1,fontType: PosFontType.fontA)),
        PosColumn(text: 'Floor: '+BoldOn+'${orderDetail["FloorName"]}'+BoldOff, width: 6,styles: PosStyles(align:PosAlign.left,height: PosTextSize.size1, width: PosTextSize.size1,fontType: PosFontType.fontA)),
      ]);
      printer.row([
        PosColumn(text: '${orderDetail["OrderInfoKey"]??""} '+'${orderDetail["OrderInfoValue"]??""}', width: 6,styles: PosStyles(align:PosAlign.left,height: PosTextSize.size1, width: PosTextSize.size1,fontType: PosFontType.fontA)),
        PosColumn(text: '${orderDetail["OrderTypeDisplayName"]} '+'${orderDetail["OrderTypeDisplayNumber"]}', width: 6,styles: PosStyles(align:PosAlign.left,height: PosTextSize.size1, width: PosTextSize.size1,fontType: PosFontType.fontA)),
      ]);
      printer.text('Date: '+BoldOn+orderDetail["Date"]+BoldOff+", "+BoldOn+orderDetail["Time"]+BoldOff,styles: PosStyles(align: PosAlign.left, height: PosTextSize.size1, width: PosTextSize.size1));
      printer.emptyLines(1);

      printer.hr();
      printer.row([
        PosColumn(text: ' Item', width: 10, styles: PosStyles(align: PosAlign.left,height: PosTextSize.size1, width: PosTextSize.size1,fontType: PosFontType.fontA)),
        PosColumn(text: 'Qty', width: 2, styles: PosStyles(align: PosAlign.right,height: PosTextSize.size1, width: PosTextSize.size1,fontType: PosFontType.fontA)),
      ]);
      printer.hr();
      int totalItem = 0;
      var totalqty=0.0;
      productList.forEach((element) {
        totalqty=totalqty+element["ProductQuantity"];
        printer.row([

          PosColumn(text: ' ${element["ProductName"]}', width: 10, styles: PosStyles(align: PosAlign.left)),
          PosColumn(text: ' ${element["ProductQuantity"]}', width: 2, styles: PosStyles(align: PosAlign.right)),
        ]);

        if(element['KOTComments'].length!=0){
          element['KOTComments'].forEach((ele){
            printer.row([
              PosColumn(text: '     ', width: 2),
              PosColumn(text: ' ${ele['KOTComment']}', width: 10,styles: PosStyles(align: PosAlign.left, height: PosTextSize.size1, width: PosTextSize.size2,fontType: PosFontType.fontB,bold: false)),

            ]);
          });
        }
        if(element['AddOns'].length!=0){
          element['AddOns'].forEach((ele){
            printer.row([
              PosColumn(text: '    ', width: 2, styles: PosStyles(align: PosAlign.left)),
              PosColumn(text: ' ${ele['AddOn']}', width: 10, styles: PosStyles(align: PosAlign.left,height: PosTextSize.size1, width: PosTextSize.size1,fontType: PosFontType.fontA)),
            ]);
          });
        }
        if(element["Notes"].toString().isNotEmpty){
          printer.row([
            PosColumn(text: '   ', width: 2, styles: PosStyles(align: PosAlign.left)),
            PosColumn(text: ' ${element["Notes"]}', width: 10, styles: PosStyles(align: PosAlign.left,underline: true)),
          ]);
        }
        if(element['SeatNumber'].length!=0){
          element['SeatNumber'].forEach((ele){
            printer.row([
              PosColumn(text: ' ', width: 2, styles: PosStyles(align: PosAlign.left)),
              PosColumn(text: ' ${ele['SeatNo']}', width: 10, styles: PosStyles(align: PosAlign.left,height: PosTextSize.size1, width: PosTextSize.size1,fontType: PosFontType.fontA)),
            ]);
          });
        }
        totalItem++;
      });
      printer.hr();
      printer.emptyLines(1);
      printer.text("Total Items - " + totalItem.toString() + ", No of Quantity - " + totalqty.toString(),styles: PosStyles(align: PosAlign.left, height: PosTextSize.size1, width: PosTextSize.size1));
      printerRowTemplate4(printer, orderDetail["PrintBy"]);

      printer.feed(1);
      printer.cut();
      printer.disconnect();
    }
    catch(e){
      printer.cut();
      printer.disconnect();
      CustomAlert().commonErrorAlert("Print Receipt KoT", e.toString());
    }
  }
  else if(res==PosPrintResult.timeout){
    if(needReConnect){
      KOTFormat1(printerDetail,needReConnect: false);
    }
  }
  else{
    //printer.disconnect();
    print("Not Connected");
  }
}
const PosStyles posStyles1=PosStyles(align: PosAlign.center, height: PosTextSize.size1, width: PosTextSize.size1);
Future<void> BillFormat3(printerDetail,{bool needReConnect=true}) async{
  //print("hii");
  var printDetail = printerDetail['printDetail'];
  var addressDetail = printDetail['address'];
  var orderDetail = printDetail['orderDetail'];
  var productList = printDetail["productList"];
  var otherChargesList = printDetail["otherChargesList"];
  var paymentTypeList = printDetail["paymentTypeList"];

  PosPrintResult res;
  const PaperSize paper = PaperSize.mm80;
  final profile = await CapabilityProfile.load();
  final printer = NetworkPrinter(paper, profile);
  log("orderDetail[TableNumber] ${orderDetail["TableNumber"]}");
  res = await printer.connect(printerDetail['printerIpAddress'], port: 9100,timeout: Duration(milliseconds: SOCKET_TIMEOUT));
  if (res == PosPrintResult.success){
    try{
      printer.row([
        PosColumn(text: '', width: 1),
        PosColumn(text: '${addressDetail["Name"]}', width: 11,styles: PosStyles(align: PosAlign.center, height: addressDetail["Name"].length<15?PosTextSize.size2:PosTextSize.size2,
            width: addressDetail["Name"].length<15?PosTextSize.size2:PosTextSize.size1,bold: true)),
      ]);
      printer.text(addressDetail["Address"],styles: PosStyles(align: PosAlign.center, height: PosTextSize.size1, width: PosTextSize.size1));
      //printerRowTemplate2(printer,addressDetail["Address"]);
      // printer.text(addressDetail["Address"],styles: PosStyles(align: PosAlign.center, height: PosTextSize.size1, width: PosTextSize.size1,));
      printer.emptyLines(1);
      printerRowTemplate2(printer,"Ph: " + addressDetail["PhoneNumber"]);
      printer.text("GSTIN: " + addressDetail["GSTNumber"],styles: PosStyles(align: PosAlign.left, height: PosTextSize.size1, width: PosTextSize.size1));
      // printerRowTemplate2(printer,"GSTIN: " + addressDetail["GSTNumber"]);
      printer.emptyLines(1);
      //printerRowTemplate6(printer,"* * * Bill No - " + orderDetail["BillNumber"].toString() + " * * *",bold: true);
      printer.text(BoldOn+"* * * Bill No - " + orderDetail["BillNumber"].toString() + " * * *"+BoldOff,styles: posStyles1);
      // printer.text(BoldOn+orderDetail["OrderTypeName"]+BoldOff,styles: PosStyles(align: PosAlign.left, height: PosTextSize.size1, width: PosTextSize.size1));

      // printer.text(orderDetail["OrderTypeName"],styles: PosStyles(align: PosAlign.left, height: PosTextSize.size1, width: PosTextSize.size1,bold: true));

      printerRowTemplate3(printer,BoldOn+orderDetail["OrderTypeName"]+BoldOff,"Order#: "+BoldOn+orderDetail["OrderNumber"].toString()+BoldOff);
      printerRowTemplate3(printer,orderDetail["OrderTypeDisplayName"]+BoldOn+orderDetail["OrderTypeDisplayNumber"].toString()+BoldOff,"Covers#: "+BoldOn+orderDetail["Covers"].toString()+BoldOff);
      printerRowTemplate3(printer,"cashier: "+BoldOn+orderDetail["CashierName"].toString()+BoldOff,"captain: "+BoldOn+orderDetail["CaptainName"].toString()+BoldOff);

      */
/*printer.text("Date: "+DoubleOn+orderDetail["Date"]+", "+orderDetail["Time"]+DoubleOff,
          styles: PosStyles(align: PosAlign.left, height: PosTextSize.size1, width: PosTextSize.size1)
      );*//*

      printer.text("Date: "+BoldOn+orderDetail["Date"]+", "+orderDetail["Time"]+BoldOff,styles: PosStyles(align: PosAlign.left, height: PosTextSize.size1, width: PosTextSize.size1));
      // printerRowTemplate4(printer,"Date: "+BoldOn+orderDetail["Date"]+", "+orderDetail["Time"]+BoldOff);

      printer.hr();
      printer.row([
        */
/* PosColumn(text: BoldOn+'ITEM NAME'+BoldOff, width: 6, styles: PosStyles(align: PosAlign.left)),
        PosColumn(text: BoldOn+'PRICE'+BoldOff, width: 2, styles: PosStyles(align: PosAlign.right)),
        PosColumn(text: BoldOn+'QTY'+BoldOff, width: 2, styles: PosStyles(align: PosAlign.right)),
        PosColumn(text: BoldOn+'SUB'+BoldOff, width: 2, styles: PosStyles(align: PosAlign.right)),*//*

        PosColumn(text: 'ITEM NAME', width: 6, styles: PosStyles(align: PosAlign.left,bold: true)),
        PosColumn(text: 'PRICE', width: 2, styles: PosStyles(align: PosAlign.right,bold: true)),
        PosColumn(text: 'QTY', width: 2, styles: PosStyles(align: PosAlign.right,bold: true)),
        PosColumn(text: 'SUB', width: 2, styles: PosStyles(align: PosAlign.right,bold: true)),
      ]);
      printer.hr();
      double totalqty = 0;
      int totalItem = 0;
      productList.forEach((e){
        printer.row([
          PosColumn(text: e["ProductName"].toString(), width: 6, styles: PosStyles(align: PosAlign.left)),
          PosColumn(text: CheckDecimalPoint(e["ProductPrice"].toString()), width: 2, styles: PosStyles(align: PosAlign.right)),
          PosColumn(text: e["ProductQuantity"].toString(), width: 2, styles: PosStyles(align: PosAlign.right)),
          PosColumn(text: CheckDecimalPoint(e["ProductSubTotal"].toString()), width: 2, styles: PosStyles(align: PosAlign.right)),
        ]);
        totalItem++;
        totalqty += double.parse(e["ProductQuantity"].toString());
      });
      printer.hr();

      printer.row([
        PosColumn(text: 'Sub Total RS', width: 6,styles: PosStyles(align: PosAlign.right, height: PosTextSize.size1, width: PosTextSize.size1,)),
        PosColumn(text: '${CheckDecimalPoint(orderDetail["SubTotal"].toString())}', width: 6,styles: PosStyles(align: PosAlign.right, height: PosTextSize.size1, width: PosTextSize.size1,)),
      ]);

      otherChargesList.forEach((e){
        if (e["isExemption"].toString()=="false"){
          printer.row([
            PosColumn(text: '${e['title']}', width: 6,styles: PosStyles(align: PosAlign.right, height: PosTextSize.size1, width: PosTextSize.size1,)),
            PosColumn(text: '${CheckDecimalPoint(e['value'].toString())}', width: 6,styles: PosStyles(align: PosAlign.right, height: PosTextSize.size1, width: PosTextSize.size1,)),
          ]);
        }
      });

      printer.hr();
      printer.row([
        PosColumn(text: 'Total RS', width: 6,styles: PosStyles(align: PosAlign.right, height: PosTextSize.size1, width: PosTextSize.size1,bold: true)),
        PosColumn(text: '${CheckDecimalPoint(orderDetail["GrandTotal"].toString())}', width: 6,styles: PosStyles(align: PosAlign.right, height: PosTextSize.size2, width: PosTextSize.size2,bold: true)),
      ]);
      printer.emptyLines(1);
      printer.text("Total Items - " + totalItem.toString() + ", No of Quantity - " + totalqty.toString(),styles: PosStyles(align: PosAlign.left, height: PosTextSize.size1, width: PosTextSize.size1));
      printer.emptyLines(1);
      if(paymentTypeList.length>0){
        printer.text(BoldOn+"Settlement Type:"+BoldOff,styles: posStyles1);
        paymentTypeList.forEach((e){
          printer.row([
            PosColumn(text: '${e['title']}', width: 6,styles: PosStyles(align: PosAlign.right, height: PosTextSize.size1, width: PosTextSize.size1,)),
            PosColumn(text: '${CheckDecimalPoint(e['value'].toString())}', width: 6,styles: PosStyles(align: PosAlign.right, height: PosTextSize.size1, width: PosTextSize.size1,)),
          ]);
        });
      }

      printer.feed(1);
      printer.cut();
      printer.disconnect();
    }catch(e,t){
      log("${t.toString()}");
      CustomAlert().commonErrorAlert("Bill Print Receipt", e.toString());
      printer.cut();
      printer.disconnect();
    }
  }
  else if(res==PosPrintResult.timeout){
    if(needReConnect)
      BillFormat3(printerDetail,needReConnect: false);
  }
  else{

  }
}

exePrinterCall(e){
  List<ParameterModel> list=[];
  list.add(ParameterModel(Key: "printerdetail", Type: "string", Value: json.encode([e])));
  var body={
    "Fields": list.map((e) => e.toJson()).toList()
  };
  ApiManager().PostCall(softControls['printerActionUrl'], body).then((value){
    print("exePrinterCall $value");
  });

}

printerRowTemplate1(NetworkPrinter printer, dynamic title,{bool bold=false}){
  return printer.row([
    PosColumn(text: '', width: 1),
    PosColumn(text: '$title', width: 11,styles: PosStyles(align: PosAlign.center, height: PosTextSize.size1, width: PosTextSize.size2,bold: bold)),
  ]);
}
printerRowTemplate2(NetworkPrinter printer, dynamic title,{bool bold=false}){
  return printer.row([
    PosColumn(text: '', width: 1),
    PosColumn(text: '$title', width: 11,styles: PosStyles(align: PosAlign.center, height: PosTextSize.size1, width: PosTextSize.size1,bold: bold)),
  ]);
}
printerRowTemplate3(NetworkPrinter printer, dynamic title1, dynamic title2){
  return printer.row([
    PosColumn(text: '$title1', width: 6,styles: PosStyles(align: PosAlign.left, height: PosTextSize.size1, width: PosTextSize.size1,)),
    PosColumn(text: '$title2', width: 6,styles: PosStyles(align: PosAlign.left, height: PosTextSize.size1, width: PosTextSize.size1,)),
  ]);
}
printerRowTemplate4(NetworkPrinter printer, dynamic title,{bool bold=false}){
  return printer.row([
    PosColumn(text: '', width: 1),
    PosColumn(text: '$title', width: 11,styles: PosStyles(align: PosAlign.left, height: PosTextSize.size1, width: PosTextSize.size1,bold: bold)),
  ]);
}
printerRowTemplate5(NetworkPrinter printer, dynamic title,{bool bold=false}){
  return printer.row([
    PosColumn(text: '$title', width: 12,styles: PosStyles(align: PosAlign.center, height: PosTextSize.size2, width: PosTextSize.size2,bold: bold)),
  ]);
}
printerRowTemplate6(NetworkPrinter printer, dynamic title,{bool bold=false}){
  return printer.row([
    PosColumn(text: '$title', width: 12,styles: PosStyles(align: PosAlign.center, height: PosTextSize.size1, width: PosTextSize.size1,bold: bold)),
  ]);
}

*/
/*void billPrint(String printerJson){
  //log("billPrint $printerJson");
  try{
    if(printerJson.isNotEmpty){
      log("billPrint $printerJson");
      var parsedPrinter=json.decode(printerJson);
      parsedPrinter.forEach((e){
        if(e['printTemplateName']=="BillFormat3"){
          BillFormat3(e);
        }
      });
    }
  }
  catch(e){
    CustomAlert().commonErrorAlert("Bill Print Receipt", e.toString());
  }
}*//*



//Bluetooth

BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
List<BluetoothDevice> devices = [];
Future<void> initPlatformStateBluetooth() async {


  bool? isConnected = await bluetooth.isConnected;
  try {
    devices = await bluetooth.getBondedDevices();
    print(devices);
  } on PlatformException {
    // TODO - Error
  }

  bluetooth.onStateChanged().listen((state) {
    switch (state) {
      case BlueThermalPrinter.CONNECTED:
        print("bluetooth device state: connected");
        */
/* setState(() {
          _connected = true;
          print("bluetooth device state: connected");
        });*//*

        break;
      case BlueThermalPrinter.DISCONNECTED:
        print("bluetooth device state: disconnected");
        */
/*setState(() {
          _connected = false;
          print("bluetooth device state: disconnected");
        });*//*

        break;
      case BlueThermalPrinter.DISCONNECT_REQUESTED:
        print("bluetooth device state: disconnect requested");
        */
/*setState(() {
          _connected = false;
          print("bluetooth device state: disconnect requested");
        });*//*

        break;
      case BlueThermalPrinter.STATE_TURNING_OFF:
        print("bluetooth device state: bluetooth turning off");
        */
/*setState(() {
          _connected = false;
          print("bluetooth device state: bluetooth turning off");
        });*//*

        break;
      case BlueThermalPrinter.STATE_OFF:
        print("bluetooth device state: bluetooth off");
        */
/*setState(() {
          _connected = false;
          print("bluetooth device state: bluetooth off");
        });*//*

        break;
      case BlueThermalPrinter.STATE_ON:
        print("bluetooth device state: bluetooth on");
        */
/*setState(() {
          _connected = false;
          print("bluetooth device state: bluetooth on");
        });*//*

        break;
      case BlueThermalPrinter.STATE_TURNING_ON:
        print("bluetooth device state: bluetooth turning on");
        */
/*setState(() {
          _connected = false;
          print("bluetooth device state: bluetooth turning on");
        });*//*

        break;
      case BlueThermalPrinter.ERROR:
        print("bluetooth device state: error");
        */
/* setState(() {
          _connected = false;
          print("bluetooth device state: error");
        });*//*

        break;
      default:
        print("state $state");
        break;
    }
  });

*/
/*  if (!mounted) return;
  setState(() {
    _devices = devices;
  });

  if ( isConnected!=null) {
    if(isConnected){
      setState(() {
        _connected = true;
      });
    }

  }*//*

}

BillFormat4(printerDetail,String printerName) async{

  //1-center
  //2-right
  //0-left

  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  BluetoothDevice? bluetoothDevice=getBluetoothDevice(printerName);

  if(bluetoothDevice!=null){
    bool isConn=await bluetooth.isDeviceConnected(bluetoothDevice)??false;
    var proceed=false;
    if(isConn){
      proceed=true;
    }
    else{
      await bluetooth.connect(bluetoothDevice);
      proceed=true;
    }
    bluetooth.isConnected.then((isConnected) {
      if (isConnected!) {

        var printDetail = printerDetail['printDetail'];
        var addressDetail = printDetail['address'];
        var orderDetail = printDetail['orderDetail'];
        var productList = printDetail["productList"];
        var otherChargesList = printDetail["otherChargesList"];
        var paymentTypeList = printDetail["paymentTypeList"];
        try{

          bluetooth.printCustom(addressDetail["Name"], 3, 1);
          bluetooth.printCustom(addressDetail["Address"], 0, 1);
          bluetooth.printCustom("Ph: " + addressDetail["PhoneNumber"], 0, 1);
          bluetooth.printCustom("GSTIN: " + addressDetail["GSTNumber"], 0, 0);

          bluetooth.printCustom("\n"+"Bill No - " + orderDetail["BillNumber"].toString(), 2, 1);
          bluetooth.printLeftRight(orderDetail["OrderTypeName"], "Order#: "+orderDetail["OrderNumber"].toString(), 1,format: "%-15s %15s %n");
          bluetooth.printLeftRight(orderDetail["OrderTypeDisplayName"]+orderDetail["OrderTypeDisplayNumber"].toString(),"Covers#: "+orderDetail["Covers"].toString(), 0,format: "%-15s %15s %n");
          bluetooth.printCustom("Date: " +BoldOn+orderDetail["Date"]+", "+orderDetail["Time"]+BoldOff, 0, 0);

          //bluetooth.printCustom("-----------------------------------", 0, 1);
          htBt(bluetooth);
          double totalqty = 0;
          int totalItem = 0;
          productList.forEach((e){
            bluetooth.printCustom(e["ProductName"].toString(), 1, 0);
            bluetooth.printLeftRight(CheckDecimalPoint(e["ProductPrice"].toString())+" * "+e["ProductQuantity"].toString(), CheckDecimalPoint(e["ProductSubTotal"].toString()), 0);
            totalItem++;
            totalqty += double.parse(e["ProductQuantity"].toString());
          });
          htBt(bluetooth);

          bluetooth.printLeftRight("Sub Total Rs", CheckDecimalPoint(orderDetail["SubTotal"].toString()), 0,format: "%15s %15s %n");
          otherChargesList.forEach((e){
            if (e["isExemption"].toString()=="false"){
              bluetooth.printLeftRight('${e['title']}', CheckDecimalPoint(e['value'].toString()), 0,format: "%15s %15s %n");
            }
          });
          htBt(bluetooth);
          bluetooth.printLeftRight("       Total Rs", CheckDecimalPoint(orderDetail["GrandTotal"].toString()), 1,format: "%15s %15s %n");
          bluetooth.printNewLine();
          bluetooth.printCustom("Total Items- " + totalItem.toString() + ", Total Qty- " + totalqty.toString(), 0, 0);
          bluetooth.printNewLine();
          if(paymentTypeList.length>0){
            bluetooth.printCustom("Settlement Type:", 1, 1);
            paymentTypeList.forEach((e){
              bluetooth.printLeftRight('${e['title']}', '${CheckDecimalPoint(e['value'].toString())}', 0);
            });
          }
          bluetooth.printNewLine();
          bluetooth.printNewLine();
          bluetooth.printNewLine();
          bluetooth.printNewLine();
        }
        catch(e){
          print("BillFormat4 catch $e");
        }
      }
      else{
        CustomAlert().commonErrorAlert("Turn on Bluetooth", "");
        //addNotifications(1,msg:"Turn on Bluetooth",img: notificationErrorIcon);
      }
    });
  }
  else{
   //addNotifications(1);
  }
}

void htBt(BlueThermalPrinter blueThermalPrinter){
  blueThermalPrinter.printCustom("-------------------------------", 0, 1);
}

BluetoothDevice? getBluetoothDevice(String deviceName){
  BluetoothDevice? bluetoothDevice;
  try{
    bluetoothDevice=devices.where((element) => element.name==deviceName).toList()[0];
    return bluetoothDevice;
  }
  catch(e){
    return bluetoothDevice;
  }
}


String CheckDecimalPoint(String input)
{
  if (input.contains("."))
  {
    return input;
  }
  else
  {
    return input + ".00";
  }
}*/
