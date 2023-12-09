import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../styles/constants.dart';
import '../utils/colorUtil.dart';
import '../utils/sizeLocal.dart';


//Color addNewTextFieldText=Color(0xFF787878);
Color disableColor=Color(0xFFe8e8e8);
// Color addNewTextFieldBorder=Color(0xFFCDCDCD);
// Color addNewTextFieldFocusBorder=Color(0xFF6B6B6B);

class AddNewLabelTextField extends StatelessWidget {
  bool isEnabled;
  String? labelText;
  double scrollPadding;
  TextInputType textInputType;
  Widget? prefixIcon;
  Widget? suffixIcon;
  Function(String)? onChange;
  VoidCallback? ontap;
  TextInputFormatter? textInputFormatter;
  VoidCallback? onEditComplete;
  bool isObscure;
  int? maxlines;
  int? textLength;
  String? regExp;

  bool hasInput;
  bool required;
  String dataname;
  double? width;
  EdgeInsets? margin;
  bool needEmailValidation;
  late TextEditingController textEditingController;

  AddNewLabelTextField({this.labelText,this.scrollPadding=270.0,this.textInputType:TextInputType.text,this.width,
    this.prefixIcon,this.ontap,this.onChange,this.textInputFormatter,this.isEnabled=true,this.suffixIcon,this.onEditComplete,
    this.isObscure=false,this.maxlines=1,this.textLength=null,this.regExp='[A-Za-z0-9@.,]',this.hasInput=true,this.required=false,
    required this.dataname,this.margin,this.needEmailValidation=false}){
    textEditingController= new TextEditingController();
  }
  var isValid=true.obs;
  var orderBy=1.obs;
  var errorText="* Required".obs;
  var reload=false.obs;
  @override
  Widget build(BuildContext context) {
    return  maxlines!=null? Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: margin??ColorUtil.formMargin,
          height: 50,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.transparent
          ),
          child:  Obx(() => TextFormField(
            autofocus: false,
            enabled: reload.value?isEnabled:isEnabled,
            onTap: ontap,
            obscureText: isObscure,
            obscuringCharacter: '*',
            scrollPadding: EdgeInsets.only(bottom: scrollPadding),
            style:  TextStyle(fontFamily: 'RR',fontSize: 16,color:ColorUtil.text3,letterSpacing: 0.2),
            controller: textEditingController,
            cursorColor:ColorUtil.text4,
            decoration: InputDecoration(
              fillColor:isEnabled?Colors.white:ColorUtil.disableColor,
              filled: true,
              labelStyle: TextStyle(fontFamily: 'RR',fontSize: 16,color: ColorUtil.text3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                borderSide: BorderSide(
                  width: 0.2,
                  color: ColorUtil.text4,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                borderSide: BorderSide(
                  width: 0.2,
                  color: ColorUtil.text4,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                borderSide: BorderSide(
                  width: 0.2,
                  color:ColorUtil.primary,
                ),
              ),
              labelText: labelText,
              contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
            ),
            maxLines: maxlines,
            keyboardType: textInputType,
            textInputAction: TextInputAction.done,
            // inputFormatters:  <TextInputFormatter>[
            //
            //   //textInputFormatter
            // ],

            inputFormatters:regExp!=null? [
              LengthLimitingTextInputFormatter(textLength),
              FilteringTextInputFormatter.allow(RegExp(regExp!)),
            ]:[
              LengthLimitingTextInputFormatter(textLength),
            ],
            onChanged: (v){
              onChange!(v);
            },
            onEditingComplete: (){
              onEditComplete!();
            },
          )),
        ),
        Obx(
                ()=>isValid.value?Container():Container(
                margin:  EdgeInsets.only(left:5,right:0,bottom:5,),
                child: Text(errorText.value,style: TextStyle(color: Colors.red),)
            )
        ),
      ],
    ):
    Container(

      margin: EdgeInsets.only(left:20,right:20,top:15,),
      //    height: 50,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.transparent
      ),
      child:  TextFormField(
        enabled: isEnabled,
        onTap: ontap,
        obscureText: isObscure,
        obscuringCharacter: '*',
        scrollPadding: EdgeInsets.only(bottom: scrollPadding),
        style:  TextStyle(fontFamily: 'RR',fontSize: 15,color:addNewTextFieldText,letterSpacing: 0.2),
        controller: textEditingController,
        decoration: InputDecoration(
            fillColor:isEnabled?Colors.white: Color(0xFFe8e8e8),
            filled: true,
            labelStyle: TextStyle(fontFamily: 'RL',fontSize: 15,color: addNewTextFieldText.withOpacity(0.9)),
            border:  OutlineInputBorder(
                borderSide: BorderSide(color: addNewTextFieldBorder)
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: addNewTextFieldBorder)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color:addNewTextFieldFocusBorder)
            ),
            labelText: labelText,
            contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon



        ),
        maxLines: maxlines,
        keyboardType: textInputType,
        textInputAction: TextInputAction.done,

        onChanged: (v){
          onChange!(v);
        },
        onEditingComplete: (){

          onEditComplete!();
        },
      ),

    );
  }

  getType(){
    return 'inputTextField';
  }

  getValue(){
    return textEditingController.text;
  }

  setValue(var value){
    textEditingController.text=value.toString();
  }

  String getDataName(){
    return dataname;
  }

  void clearValues(){
    textEditingController.text="";
  }

  validate(){
    requiredCheck();
    if(needEmailValidation&&isValid.value){
      emailValidation();
    }
    return isValid.value;
  }
  requiredCheck(){
    if(textEditingController.text.isEmpty){
      isValid.value=false;
      errorText.value="* Required";
    }
    else{
      isValid.value=true;
    }
    // return isValid.value;
  }
  minLengthCheck(dynamic min){
    if(textEditingController.text.isEmpty){
      isValid.value=false;
      errorText.value="* Minimum Length is $min";
    }
    else if(textEditingController.text.length<int.parse(min.toString())){
      isValid.value=false;
      errorText.value="* Minimum Length is $min";

    }
    else{
      isValid.value=true;
    }
    //  return isValid.value;
  }
  maxLengthCheck(dynamic max){
    if(textEditingController.text.isEmpty){
      isValid.value=false;
      errorText.value="* Maximum Length is $max";
    }
    else if(textEditingController.text.length>int.parse(max.toString())){
      isValid.value=false;
      errorText.value="* Maximum Length is $max";

    }
    else{
      isValid.value=true;
    }
    // return isValid.value;
  }
  emailValidation(){

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern as String);
    if(textEditingController.text.isEmpty){
      isValid.value=true;
      return;
    }
    if (!regex.hasMatch(textEditingController.text)) {
      isValid.value=false;
      errorText.value='* Email format is invalid';
    }
    else {
      isValid.value=true;
    }
    // return isValid.value;
  }

  int getOrderBy() {
    return orderBy.value;
  }

  setOrderBy(int oBy) {
    orderBy.value=oBy;
  }
}
class AddNewLabelTextFieldTest extends StatelessWidget {
  bool isEnabled;
  String? labelText;

  double scrollPadding;
  TextInputType textInputType;
  Widget? prefixIcon;
  Widget? suffixIcon;
  Function(String)? onChange;
  VoidCallback? ontap;
  TextInputFormatter? textInputFormatter;
  VoidCallback? onEditComplete;
  bool isObscure;
  int? maxlines;
  int? textLength;
  String regExp;

  bool hasInput;
  bool required;
  late TextEditingController textEditingController;

  AddNewLabelTextFieldTest({this.labelText,this.scrollPadding=270.0,this.textInputType:TextInputType.text,
    this.prefixIcon,this.ontap,this.onChange,this.textInputFormatter,this.isEnabled=true,this.suffixIcon,this.onEditComplete,
    this.isObscure=false,this.maxlines=1,this.textLength=null,this.regExp='[A-Za-z0-9@.,]',this.hasInput=false,this.required=false}){
      textEditingController= new TextEditingController();
  }
  var isValid=true.obs;
  var errorText="* Required".obs;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  maxlines!=null? Container(
      margin: EdgeInsets.only(left:20,right:20,top:15,),
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: Colors.transparent
      ),
      child:  TextFormField(
         enabled: isEnabled,
         onTap: ontap,
         obscureText: isObscure,
         obscuringCharacter: '*',
         scrollPadding: EdgeInsets.only(bottom: scrollPadding),
        style:  TextStyle(fontFamily: 'RR',fontSize: 15,color:addNewTextFieldText,letterSpacing: 0.2),
        controller: textEditingController,
        decoration: InputDecoration(
          fillColor:isEnabled?Colors.white:disableColor,
          filled: true,
          labelStyle: TextStyle(fontFamily: 'RL',fontSize: 15,color: addNewTextFieldText.withOpacity(0.9)),
          border:  OutlineInputBorder(
              borderSide: BorderSide(color: addNewTextFieldBorder)
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: addNewTextFieldBorder)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color:addNewTextFieldFocusBorder)
          ),
          labelText: labelText,
           contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon



        ),
        maxLines: maxlines,
        keyboardType: textInputType,
        textInputAction: TextInputAction.done,
        // inputFormatters:  <TextInputFormatter>[
        //
        //   //textInputFormatter
        // ],

        inputFormatters: [
          LengthLimitingTextInputFormatter(textLength),
          FilteringTextInputFormatter.allow(RegExp(regExp)),
        ],
        onChanged: (v){
           onChange!(v);
        },
        onEditingComplete: (){

           onEditComplete!();
        },
      ),
    ):
    Container(

      margin: EdgeInsets.only(left:20,right:20,top:15,),
  //    height: 50,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.transparent
      ),
      child:  TextFormField(
        enabled: isEnabled,
        onTap: ontap,
        obscureText: isObscure,
        obscuringCharacter: '*',
        scrollPadding: EdgeInsets.only(bottom: scrollPadding),
        style:  TextStyle(fontFamily: 'RR',fontSize: 15,color:addNewTextFieldText,letterSpacing: 0.2),
        controller: textEditingController,
        decoration: InputDecoration(
            fillColor:isEnabled?Colors.white: Color(0xFFe8e8e8),
            filled: true,
            labelStyle: TextStyle(fontFamily: 'RL',fontSize: 15,color: addNewTextFieldText.withOpacity(0.9)),
            border:  OutlineInputBorder(
                borderSide: BorderSide(color: addNewTextFieldBorder)
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: addNewTextFieldBorder)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color:addNewTextFieldFocusBorder)
            ),
            labelText: labelText,
            contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon



        ),
        maxLines: maxlines,
        keyboardType: textInputType,
        textInputAction: TextInputAction.done,

        onChanged: (v){
          onChange!(v);
        },
        onEditingComplete: (){

          onEditComplete!();
        },
      ),

    );
  }

  getType(){
    return 'inputTextField';
  }

  getValue(){
    return textEditingController.text;
  }

  setValue(var value){
    textEditingController.text=value.toString();
  }

}
