import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static String id = 'SplashScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                top: -150,
                right: -170,
                child: Image.asset(
                  'assets/images/top-right.png',
                  height: 305,
                  width: 330,
                )),
            Positioned(
                bottom: -150,
                left: -170,
                child: Image.asset(
                  'assets/images/bottom-left.png',
                  height: 330,
                  width: 330,
                )),
            Positioned(
                bottom: -35,
                right: -35,
                child: Image.asset(
                  'assets/images/chef.png',
                  height: 170,
                  width: 170,
                )),
            Column(
              children: [
                SizedBox(
                  height: 140,
                ),
                Image.asset(
                  'assets/images/fooddelivery.png',
                  height: 400,
                  width: 380,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
