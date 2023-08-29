import 'package:flutter/material.dart';

class BillingItemEditPopUpNotifier extends ChangeNotifier{

 bool  billingitemisclick=false;

 bool isTablePositionClick=false;
 bool isDiscountClick=false;
 bool isAddonsClick=false;
 bool isKitchenCommentsClick=false;
 bool isCustomQuantityClick=false;

 void changePopUpStatus() {
   this.billingitemisclick=!this.billingitemisclick;
   notifyListeners();
 }

 void changeTablePositionClickTrue(){
   isTablePositionClick=true;
   notifyListeners();
 }
 void changeTablePositionClickFalse(){
   isTablePositionClick=false;
   notifyListeners();
 }

 void changeisDiscountClickTrue(){
   isDiscountClick=true;
   notifyListeners();
 }
 void changeisDiscountClickFalse(){
   isDiscountClick=false;
   notifyListeners();
 }

 void changeisAddonsClickTrue(){
   isAddonsClick=true;
   notifyListeners();
 }
 void changeisAddonsClickFalse(){
   isAddonsClick=false;
   notifyListeners();
 }

 void changeisKitchenCommentsClickTrue(){
   isKitchenCommentsClick=true;
   notifyListeners();
 }
 void changeisKitchenCommentsClick(){
   isKitchenCommentsClick=false;
   notifyListeners();
 }

 void changeisCustomQuantityClick(bool value){
   isCustomQuantityClick=value;
   notifyListeners();
 }
}