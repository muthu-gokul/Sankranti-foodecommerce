import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scutiwidgets/scutiwidgets.dart';

import '../utils/constants.dart';

final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: Color(0xFFECECEC)),
  );
}
class PinWidget extends StatelessWidget {

  int pinLength;
  VoidCallback onComplete;
  PinWidget({required this.pinLength,required this.onComplete}){
    init();
  }

  void init(){
    textControllers.clear();
    for(int i=0;i<pinLength;i++){
      textControllers.add(new TextEditingController());
      focusNodes.add(new FocusNode());
    }
  }

  void nextField(String value,int index) {
    if (value.length == 1) {
      focusNodes[index+1].requestFocus();
    }
    else if(value.isEmpty){
      if(index>0){
        focusNodes[index-1].requestFocus();
      }
    }
  }

  List<TextEditingController> textControllers=[];
  List<FocusNode> focusNodes=[];

  String getValue(){
    String pin="";
    textControllers.forEach((element) {
      if(element.text.isNotEmpty){
        pin+=element.text;
      }
    });
    return pin;
  }

  validate(){
    if(getValue().length!=pinLength){
      isValid.value=false;
    }
    else{
      isValid.value=true;
    }
    return isValid.value;
  }

  void clearValues(){
    textControllers.forEach((element) {
      element.text="";
    });
  }

  void requestFocus(){
    if(focusNodes.length>0){
      focusNodes[0].requestFocus();
    }
  }

  var isValid=true.obs;
  var errorText="* Required".obs;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for(int i=0;i<textControllers.length;i++)
                SizedBox(
                  width: 45,
                  height: 45,
                  child: TextFormField(
                    controller: textControllers[i],
                    focusNode: focusNodes[i],
                    autofocus: true,
                    obscureText: true,
                    obscuringCharacter: '*',
                    style: const TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.allow(RegExp(MyConstants.digitRegEx)),
                    ],

                    onChanged: (value) {
                      if(i==pinLength-1 && value.isNotEmpty){
                        focusNodes[i].unfocus();
                        onComplete();
                      }
                      else if(value.length==pinLength){
                        focusNodes[i].unfocus();
                        onComplete();
                      }
                      else{
                        nextField(value,i);
                      }
                    },
                  ),
                )
            ],
          ),
        ),
        Obx(() => Visibility(
          visible: !isValid.value,
          child: Padding(padding: EdgeInsets.only(left:20,right: 20,top: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text("* Required",style: TextStyle(fontSize: 14,color: Colors.red,fontFamily: 'RR'),textAlign: TextAlign.left,)),
          ),
        ))
      ],
    );
  }
}
