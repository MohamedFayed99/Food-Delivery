import 'package:flutter/material.dart';

class DrawLogo extends StatelessWidget {
  final text;
  final logoImagePath;
  DrawLogo({this.text, this.logoImagePath});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          logoImagePath,
          fit: BoxFit.cover,
          width: 45,
          height: 45,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: 13),
        ),
      ],
    );
  }
}
