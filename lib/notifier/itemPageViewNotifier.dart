import 'package:flutter/material.dart';
import 'package:get/get.dart';

ScrollController indicatorController=new ScrollController();

RxInt jmax=new RxInt(-1);
RxInt carouselindex=new RxInt(-1);
RxBool itemsIndicatorPrevious=RxBool(false);
RxBool itemsIndicatorNext=RxBool(false);
RxBool indicatorClicked=RxBool(false);

PageController itemPageViewController=PageController();
void updatePageViewController(int index){
  itemPageViewController.animateToPage(index,duration: Duration(milliseconds: 200),curve: Curves.easeIn);
}
void updateindex(int index) {
  carouselindex.value=index;
}