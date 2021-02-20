import 'package:flutter/material.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/screens/add_restaurant.dart';
import 'package:fooddelivery/screens/orders_screen.dart';
import 'package:fooddelivery/screens/view_restaurant_info.dart';
import 'package:fooddelivery/screens/view_restaurant_products.dart';
import 'package:fooddelivery/widgets/draw_back_icon.dart';
import 'package:fooddelivery/widgets/draw_containers_in_profile_screen.dart';

class HomeProfileScreen extends StatelessWidget {
  static String id = 'HomeProfileScreen';
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
          DrawBackButton(
            color: textColor,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Positioned(
              top: 40,
              right: 20,
              child: Image.asset(
                'assets/images/fooddelivery2.png',
                height: 50,
                width: 50,
              )),
          Positioned(
              bottom: -180,
              left: -200,
              child: Image.asset(
                'assets/images/bottom-left.png',
                height: 330,
                width: 330,
              )),
          Positioned(
              top: 100,
              right: 0,
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  color: Color(0xffAE0001),
                  borderRadius: BorderRadius.circular(30),
//                  gradient: LinearGradient(
//                    stops:[.1,1],
//                    colors: [
//                      Color(0xffAE0001),
//                      Color(0xffAA0C0D36),
//
//                    ]
//                  )
                ),
                child: Center(
                  // delete gesture detector here , i made it to test only
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ViewRestaurantProducts.id);
                    },
                    child: Text(
                      'My account',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )),
          Column(
            children: [
              SizedBox(
                height: 155,
              ),
              DrawContainers(
                text: 'My Orders',
                onPressed: () {
                  Navigator.of(context).pushNamed(OrdersScreen.id);
                },
              ),
              SizedBox(
                height: 5,
              ),
              DrawContainers(
                text: 'current address',
                onPressed: () {
                  Navigator.of(context).pushNamed(ViewRestaurantInformation.id);
                },
              ),
              SizedBox(
                height: 5,
              ),
              DrawContainers(
                text: 'Change account data',
                onPressed: () {
                  // edit this
                  Navigator.of(context).pushNamed(AddRestaurantScreen.id);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
