import 'package:flutter/material.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/models/restaurant.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CurrentAddressScreen extends StatelessWidget {
  static String id = 'CurrentAddressScreen';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Restaurant userRestaurant = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/background.png',
              height: height,
              width: width,
              fit: BoxFit.cover,
            ),
            Container(
              height: 70,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 190),
                child: Row(
                  children: [
                    Text(
                      translator.translate('current address'),
                      style: TextStyle(color: textColor, fontSize: 16),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${userRestaurant.address}',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.home,
                    color: Colors.black,
                    size: 40,
                  )
                ],
              ),
            ),
            Positioned(
                bottom: 10,
                right: 30,
                child: Image.asset(
                  'assets/images/fooddelivery2.png',
                  height: 80,
                  width: 80,
                ))
          ],
        ),
      ),
    );
  }
}
