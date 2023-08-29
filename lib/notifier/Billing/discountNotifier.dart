import 'package:get/get.dart';
import '../utils.dart';
import 'cartNotifier.dart';

var isOverallDisPopUp=false.obs;
var overAllDiscountValue="".obs;

onDiscountClick(){
  showBillPreview.value=false;
  if(!HasCurrentOrder()){
    selectTableAlert();
    return;
  }
  blurAboveBillScreen.value=true;
  isOverallDisPopUp.value=true;
  overAllDiscountValue.value="";
  if(c_orderDetail.value!.isOverAllDiscount!){
    if(c_orderDetail.value!.isDiscount!){
      if(c_orderDetail.value!.discountValue!>0){
        overAllDiscountValue.value=c_orderDetail.value!.discountValue!.toString();
      }
    }
  }
}

void updateoverAllDis(String val){

  if(c_orderDetail.value!.isPercentage!){

    if(overAllDiscountValue.value.length<2){
      if(overAllDiscountValue.value.isNotEmpty){
        if(overAllDiscountValue.value[0]=="0"){
          overAllDiscountValue.value="";
          // overAllDis=overAllDis+val;
        }
        else{
          overAllDiscountValue.value=overAllDiscountValue.value+val;
        }
      }
      else{
        if(val=="0"){
          overAllDiscountValue.value="";
        }
        else{
          overAllDiscountValue.value=overAllDiscountValue.value+val;
        }
      }
    }
  }
  else{
    if(overAllDiscountValue.value.length<4){
      if(overAllDiscountValue.value.isNotEmpty){
        if(overAllDiscountValue.value[0]=="0"){
          overAllDiscountValue.value="";
          //  overAllDis=overAllDis+val;
        }
        else{
          overAllDiscountValue.value=overAllDiscountValue.value+val;
        }
      }
      else{
        if(val=="0"){
          overAllDiscountValue.value="";
        }
        else{
          overAllDiscountValue.value=overAllDiscountValue.value+val;
        }
      }
    }
  }
}

void onOverAllDiscountCancel(){
    isOverallDisPopUp.value=false;
    blurAboveBillScreen.value=false;
    c_orderDetail.value!.isOverAllDiscount=false;
    c_orderDetail.value!.isDiscount=false;
    c_orderDetail.value!.discountValue=0.0;
    c_orderDetail.value!.discountAmount=0.0;
    c_orderDetail.value!.orderCalculation();
    c_orderDetail.refresh();
}

void onOverAllDiscountDone(){
  if(overAllDiscountValue.value.isEmpty){
    return;
  }
  isOverallDisPopUp.value=false;
  blurAboveBillScreen.value=false;
  c_orderDetail.value!.isOverAllDiscount=true;
  c_orderDetail.value!.isDiscount=true;
  c_orderDetail.value!.discountValue=parseDouble(overAllDiscountValue.value);
  c_orderDetail.value!.orderCalculation();
  c_orderDetail.refresh();
}