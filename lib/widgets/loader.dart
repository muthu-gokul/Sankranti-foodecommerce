import 'package:flutter/material.dart';

import '../styles/constants.dart';
import '../utils/sizeLocal.dart';



class Loader extends StatelessWidget {
  bool? value;
  Loader({this.value});
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring:value!?false: true,
      child: Opacity(
        /*duration: animeDuration,
        curve: animeCurve,*/
        opacity: value!?1:0,
        // opacity: 1,
        child: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            color:Colors.black54,
            child: Center(
              child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset("assets/images/Loader.gif",filterQuality: FilterQuality.high,gaplessPlayback: true,isAntiAlias: true,)
              ),
            )
        ),
      ),
    );
  }
}
class Blur extends StatelessWidget {
  bool? value;
  Blur({this.value});
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring:value!?false: true,
      child: AnimatedOpacity(
        duration: animeDuration,
        curve: animeCurve,
        opacity: value!?1:0,
        // opacity: 1,
        child: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          color:Colors.black54,
        ),
      ),
    );
  }
}