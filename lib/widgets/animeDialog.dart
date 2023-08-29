import 'package:flutter/material.dart';
class AnimeDialog{
  fadeTransition(BuildContext context,Widget widget,int duration,{Color barrierColor=Colors.black54,bool isBarrierDismissable=true, required VoidCallback onclose} ){
    return showGeneralDialog(context: context,
      barrierDismissible: isBarrierDismissable,
      barrierColor: barrierColor,
      barrierLabel: "g",
      transitionDuration: Duration(milliseconds: duration),
      transitionBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {

        return FadeTransition(
          opacity: animation,
          child: child,
        );
        // return SlideTransition(
        //   position: Tween<Offset>(
        //     begin: const Offset(0.0, 1.0),
        //     end: Offset.zero,
        //   ).chain(CurveTween(curve: Curves.linear)).animate(animation),
        //   child: FadeTransition(
        //     opacity: animation,
        //     child: child,
        //   ),
        // );
      },
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final Widget pageChild = Builder(builder: (ctx){
          return widget;
        } );
        return SafeArea(
          top: false,
          child: Builder(builder: (BuildContext context) {
            return pageChild;
          }),
        );
      },
    ).then((value){
      onclose();
    });
  }
}