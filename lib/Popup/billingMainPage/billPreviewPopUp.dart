import 'package:basic_utils/basic_utils.dart' as bu;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

import '../../notifier/billingNotifier.dart';
import '../../utils/sizeLocal.dart';

class BillPreview extends StatefulWidget {


  @override
  _BillPreviewState createState() => _BillPreviewState();
}

class _BillPreviewState extends State<BillPreview> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BillingNotifier>(
      builder: (ctx,bn,c)=>AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        color: Colors.transparent,


      ),
    );
  }
}



class BillPreviewFooter extends StatelessWidget {
  String? title;
  String? value;
  double padding;
  BillPreviewFooter({this.title,this.value,this.padding=5});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: padding),
      child: Row(
        children: [
          Text(title!,style: TextStyle(fontFamily: 'RM',color: Color(0xFF575757),fontSize: 16),),
          Spacer(),
          Text(value!,style: TextStyle(fontFamily: 'RM',color: Color(0xFF575757),fontSize: 16),),
        ],
      ),
    );
  }
}