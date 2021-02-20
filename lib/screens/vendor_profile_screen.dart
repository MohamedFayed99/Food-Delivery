import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/models/restaurant.dart';
import 'package:fooddelivery/screens/current_address_screen.dart';
import 'package:fooddelivery/screens/vendor_info_screen.dart';
import 'package:fooddelivery/screens/vendor_orders_screen.dart';
import 'package:fooddelivery/widgets/draw_back_icon.dart';
import 'package:fooddelivery/widgets/draw_containers_in_profile_screen.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class HomeProfileScreen extends StatelessWidget {
  static String id = 'HomeProfileScreen';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String userEmail = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('vendors')
          .where('email', isEqualTo: userEmail)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          DocumentSnapshot res = snapshot.data.docs[0];
          Restaurant newRestaurant = Restaurant(
              managerName: res['manager name'],
              address: res['address'],
              deliveryPrice: res['delivery price'],
              deliveryTime: res['delivery time'],
              email: res['email'],
              restaurantId: res['id'],
              natureOfFood: res['nature of food'],
              payMethod: res['payment method'],
              password: res['password'],
              personImageUrl: res['person image url'],
              phone: res['phone'],
              imageUrl: res['restaurant image url'],
              restaurantName: res['restaurant name'],
              subscriptionTerm: res['subscription term']);
          return Stack(
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
                      child: Text(
                        translator.translate('My account'),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
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
                    text: translator.translate('My Orders'),
                    onPressed: () {
                      Navigator.of(context).pushNamed(VendorOrdersScreen.id,
                          arguments: newRestaurant);
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  DrawContainers(
                    text: translator.translate('current address'),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CurrentAddressScreen.id,
                          arguments: newRestaurant);
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  DrawContainers(
                    text: translator.translate('Change account data'),
                    onPressed: () {
                      // edit this
                      Navigator.of(context).pushNamed(VendorInfoScreen.id,
                          arguments: newRestaurant);
                    },
                  ),
                ],
              )
            ],
          );
        }
      },
    ));
  }
}
