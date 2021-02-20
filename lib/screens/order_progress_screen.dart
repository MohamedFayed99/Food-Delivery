import 'package:flutter/material.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/screens/home_screen.dart';
import 'package:fooddelivery/screens/orders_screen.dart';

class OrderProgressScreen extends StatelessWidget {
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
          Positioned(
              top: -90,
              right: -180,
              child: Image.asset(
                'assets/images/ellipse.png',
                width: 290,
                height: 290,
              )),
          Positioned(
              top: -120,
              left: -140,
              child: Image.asset(
                'assets/images/hadramot2.png',
                width: 430,
                height: 430,
              )),
          Column(
            children: [
              SizedBox(
                height: 250,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Restaurant information',
                    style: TextStyle(fontSize: 12, color: Color(0xffE19B11)),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 100),
                            child: Text(
                              'Hadramot',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                          Text(
                            'Grill_Sandwiches_Fast food',
                            style: TextStyle(
                                fontSize: 15, color: Color(0xffE19B11)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 100),
                            child: Text(
                              'Soft drinks',
                              style: TextStyle(
                                  fontSize: 17, color: Color(0xffE19B11)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                color: textColor,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    '( Delivery 25 EGP )',
                    style: TextStyle(fontSize: 12, color: textColor),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'During 50 minutes',
                    style: TextStyle(fontSize: 17, color: textColor),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    'assets/images/motorcycle.png',
                    height: 25,
                    width: 25,
                  )
                ],
              ),
              Divider(
                color: textColor,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Your request is in progress',
                style: TextStyle(
                  fontSize: 22,
                  color: Color(0xffEBAC08),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'To follow up on your current order',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xffAE0001),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'contact a restaurant ',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xffAE0001),
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'at',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffAE0001),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 40,
                    width: 160,
                    decoration: BoxDecoration(
                        color: Color(0xff828282).withOpacity(.3),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Text(
                        '012345678912',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffAE0001),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 20),
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
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/rectangle.png',
                                height: 20,
                                width: 20,
                              ),
                            ),
                            Center(
                              child: Text(
                                'Back to home',
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
                        Navigator.of(context).pushNamed(OrdersScreen.id);
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
