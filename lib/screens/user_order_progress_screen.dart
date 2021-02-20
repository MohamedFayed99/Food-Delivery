import 'package:flutter/material.dart';
import 'package:fooddelivery/screens/home_screen.dart';
import 'package:fooddelivery/screens/user_orders_screen.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class UserOrderProgressScreen extends StatelessWidget {
  static String id = 'OrderDetailsScreen';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            height: height,
            width: width,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              SizedBox(
                height: height * .4,
              ),
              Text(
                translator.translate('Your request is in progress'),
                style: TextStyle(
                  fontSize: 22,
                  color: Color(0xffEBAC08),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                translator.translate('To follow up on your current order'),
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xffAE0001),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                translator.translate('contact a restaurant '),
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xffAE0001),
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100, left: 20, right: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(HomeScreen.id);
                      },
                      child: Container(
                        height: 40,
                        width: 170,
                        decoration: BoxDecoration(
                            color: Color(0xffAE0001),
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset(
                                'assets/images/rectangle.png',
                                height: 20,
                                width: 20,
                              ),
                            ),
                            Center(
                              child: Text(
                                translator.translate('Back to home'),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xffFDC83E),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'assets/images/res.png',
                        height: 80,
                        width: 80,
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .popAndPushNamed(UserOrdersScreen.id);
                      },
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
