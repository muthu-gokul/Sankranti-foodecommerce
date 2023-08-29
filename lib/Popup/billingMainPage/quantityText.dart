import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../notifier/appStateNotifier.dart';



class QtyText extends StatelessWidget {
  dynamic text;
  double wid;
  bool  isSelect;
  QtyText({required this.text,this.wid=50,
  this.isSelect=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wid,
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: 'x',
          style: TextStyle( fontFamily: 'RR',
              color:isSelect?Colors.white: Provider.of<AppStateNotifier>(context,listen:false).billingCalculatedPriceColor,
              fontSize: 13.5),
          children:  <TextSpan>[
            TextSpan(text: '$text',
                style: TextStyle( fontFamily: 'RR', color:isSelect?Colors.white: Provider.of<AppStateNotifier>(context,listen:false).billingTextColor.withOpacity(0.7),fontSize: 16)
            ),

          ],
        ),
      ),
    );
  }
}
