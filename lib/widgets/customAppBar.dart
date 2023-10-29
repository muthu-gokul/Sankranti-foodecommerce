
import 'package:flutter/material.dart';

import '../styles/constants.dart';
import '../styles/style.dart';
import '../utils/colorUtil.dart';

class CustomAppBar extends StatelessWidget {
  String title;
  Widget? prefix;
  CustomAppBar({required this.title,this.prefix});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      // width: SizeConfig.screenWidth,
      child: Row(
        children: [
          prefix==null?GestureDetector(
            onTap:(){
              Navigator.pop(context);
            },
            child: Container(
                height:50,
                width:50,
                color: Colors.transparent,
                child: Icon(Icons.arrow_back_ios_new_outlined,color: text1,size: 20,)
            ),
          ):prefix!,
          Text(title,style: ts16(text1,fontfamily: 'RM'),)
        ],
      ),
    );
  }
}

class ArrowBack extends StatelessWidget {
  final VoidCallback onTap;
  const ArrowBack({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:  Container(
        height: 35,
        width: 35,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: const Color(0xffEFF1F8),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: const Color(0xffD4D5D7))),
        child: Icon(
          Icons.arrow_back_ios_sharp,
          color: ColorUtil.themeColor,
          size: 20,
        ),
      ),
    );
  }
}

