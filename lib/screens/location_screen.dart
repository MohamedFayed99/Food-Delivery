import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/constants.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class LocationScreen extends StatefulWidget {
  static String id = 'LocationScreen';
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 60,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: translator
                            .translate('Search for a region, or street. . .'),
                        hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                        fillColor: Colors.transparent,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: textColor,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Color(0xff707070),
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Color(0xff707070),
                            )),
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/rightIcon.png',
                    width: 40,
                    height: 20,
                  ),
                ],
              ),
            ),

            // this container for the location
            Container(
              height: 450,
              width: 370,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 220),
              child: Text(
                translator.translate('Delivery Address'),
                style: TextStyle(fontSize: 13, color: Color(0xffFF0001)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30, left: 100, bottom: 5),
              child: Row(
                children: [
                  Text(
                    '2 Mahmoud Nour Street _ Maadi',
                    style: TextStyle(fontSize: 13, color: Color(0xffFF0001)),
                  ),
                  Image.asset(
                    'assets/images/gg.png',
                    width: 20,
                    height: 30,
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              width: 330,
              decoration: BoxDecoration(
                  color: Color(0xff707070),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text(
                  translator.translate('Arrived here'),
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
