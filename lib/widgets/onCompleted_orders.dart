import 'package:flutter/material.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/widgets/draw_back_icon.dart';

class OnCompletedOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Center(
            child: Text(
              'There are no requests currently',
              style: TextStyle(fontSize: 20, color: textColor),
            ),
          ),
        ),
        DrawBackButton(
          color: Color(0xffAE0001),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
