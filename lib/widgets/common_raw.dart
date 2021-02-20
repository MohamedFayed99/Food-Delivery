import 'package:flutter/material.dart';
import 'package:fooddelivery/screens/search_screen.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../constants.dart';

class CommonRaw extends StatelessWidget {
  final text;
  CommonRaw({this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
          height: 50,
        ),
        GestureDetector(
          child: Container(
            width: 60,
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: primaryColor,
                ),
                Text(
                  translator.translate('Back'),
                  style: TextStyle(color: primaryColor),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        SizedBox(
          width: 30,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(SearchScreen.id);
          },
          child: Image.asset(
            'assets/images/search.png',
            height: 35,
            width: 30,
          ),
        ),
        SizedBox(
          width: 30,
        ),
        Image.asset(
          'assets/images/t.png',
          height: 40,
          width: 30,
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, left: 50),
          child: Text(
            text,
            style: TextStyle(
              color: Color(0xffAE0001),
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
