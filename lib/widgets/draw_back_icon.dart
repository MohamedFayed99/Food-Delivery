import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


class DrawBackButton extends StatelessWidget {
  final color;
  final Function onPressed;
  DrawBackButton({this.color,this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
          Positioned(
          left: 10,
          top: 50,
          child: GestureDetector(
            onTap: onPressed,
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back,
                  color: color,
                ),
                Text(translator.translate('Back'),style: TextStyle(color: color),),
              ],
            ),
          ),

        )
      ],
    );
  }
}
