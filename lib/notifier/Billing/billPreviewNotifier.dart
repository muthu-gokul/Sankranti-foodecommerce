import 'package:flutter/material.dart';
import '../../Popup/alertDialog.dart';
import '../../models/BillingModel/cartModel.dart';
import '../../widgets/calculation.dart';

import '../utils.dart';
import 'cartNotifier.dart';

List<Widget> billPreviewFooter=[];
var BP_Qty=0.0;
var BP_TotalItems=0;
void populateBillPreview(){
  billPreviewFooter.clear();
  BP_TotalItems=0;
  BP_Qty=0.0;
  if(!HasCurrentOrder()){
    selectTableAlert();
    return;
  }
  if (c_orderDetail.value!.consolidateProducts!.isEmpty) {
    CustomAlert().commonErrorAlert("No Products", "");
    return;
  }
  showBillPreview.value=true;
  var subTotal = 0.0, discountAmount = 0.0, taxAmount = 0.0, discountedSubTotal = 0.0, grandTotalAmount = 0.0, roundoff = 0.0;
  c_orderDetail.value!.consolidateProducts!.forEach((element) {
    subTotal = Calculation().add(subTotal, element.subTotal);
  });

  var tempTaxList = [];
  var tempOCList = [];
  var tempCOC = c_orderDetail.value!.consolidateOtherCharges!;

  tempCOC.forEach((v) { v.OtherChargesAmount = 0.0; v.isExemption = false; });


  var orderUtils = {
    "orderId": c_orderDetail.value!.orderId,
    "isDiscount": c_orderDetail.value!.isDiscount,
    "isPercentage": c_orderDetail.value!.isPercentage,
    "discountValue": c_orderDetail.value!.discountValue,
    "isOverAllDiscount": c_orderDetail.value!.isOverAllDiscount,
    "isOverAllTax": c_orderDetail.value!.isOverAllTax,
    "subTotal": subTotal,
    "taxAmount": 0.0,
    "discountAmount": discountAmount,
    "discountedSubTotal": 0.0,
    "grandTotalAmount": 0.0,
    "roundOffAmount": 0.0,
    "tempTaxList": tempTaxList,
    "tempOCList": tempOCList,
    "consolidateOtherChargesList": tempCOC
  };

  c_orderDetail.value!.consolidateProducts!.forEach((e) {
    BP_Qty = Calculation().add(BP_Qty, e.quantity);
    BP_TotalItems++;
    OrderModel().productCalculation(e, orderUtils);
    taxAmount = Calculation().add(taxAmount, e.taxAmount);
    discountedSubTotal = Calculation().add(discountedSubTotal, e.discountedSubTotal);
    grandTotalAmount = Calculation().add(grandTotalAmount, e.grandTotal);
  });

  roundoff=Calculation().roundOff(grandTotalAmount, grandTotalAmount);
  billPreviewFooter.add(BillPreviewFooter(title: "Sub Total",value: subTotal.toString(),));
  if(c_orderDetail.value!.isDiscount!)
    billPreviewFooter.add(BillPreviewFooter(title: "Discount",value:"- " +orderUtils['discountAmount'].toString(),));
  tempTaxList.forEach((element) {
    print(element);
    billPreviewFooter.add(BillPreviewFooter(title: "${element.OtherChargesName} (${element.OtherChargesValue}%)",value:element.OtherChargesAmount.toString(),));
  });
  tempCOC.forEach((element) {
    billPreviewFooter.add(BillPreviewFooter(title: "${element.OtherChargesCategoryName}",value:element.OtherChargesAmount.toString(),));
  });
  billPreviewFooter.add(BillPreviewFooter(title: "Round Off",value: roundoff,));
  billPreviewFooter.add(BillPreviewFooter(title: "Total Amount",value: grandTotalAmount.round(),));
}