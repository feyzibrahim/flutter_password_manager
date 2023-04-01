import 'package:flutter/material.dart';
import 'package:password_manager/special/addData.dart';

class MyFloatingButton extends StatefulWidget {
  @override
  _MyFloatingButtonState createState() => _MyFloatingButtonState();
}

class _MyFloatingButtonState extends State<MyFloatingButton> {
  bool floatIcon = true;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: floatIcon ? Icon(Icons.add) : Icon(Icons.close),
      onPressed: () {
        if (floatIcon) {
          changeFloatState();
          var bottomControler = showBottomSheet(
            context: context,
            builder: (context) => AddData(),
          );
          bottomControler.closed.then((value) => changeFloatState());
        } else
          Navigator.pop(context);
      },
    );
  }

  void changeFloatState() {
    setState(() {
      floatIcon = !floatIcon;
    });
  }
}
