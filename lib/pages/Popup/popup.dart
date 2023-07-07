/*
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class Popup extends StatefulWidget {
  const Popup({Key? key}) : super(key: key);

  @override
  State<Popup> createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  bool showPerformance = false;

  onSettingCallback() {
    setState(() {
      showPerformance = !showPerformance;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text('Default'),
        onTap: () {
          showAnimatedDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return ClassicGeneralDialogWidget(
                titleText: 'Title',
                contentText: 'content',
                onPositiveClick: () {
                  Navigator.of(context).pop();
                },
                onNegativeClick: () {
                  Navigator.of(context).pop();
                },
              );
            },
          );
        },
      ),
    );
  }
}
*/
