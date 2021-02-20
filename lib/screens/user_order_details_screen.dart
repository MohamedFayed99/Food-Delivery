import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/models/order.dart';
import 'package:fooddelivery/models/restaurant.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../constants.dart';

class UserOrderDetailsScreen extends StatelessWidget {
  static String id = 'UserOrderDetailsScreen';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Order order = ModalRoute.of(context).settings.arguments;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('vendors')
          .where('id', isEqualTo: order.restaurantId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          print(order.restaurantId);

          DocumentSnapshot res = snapshot.data.docs.first;
          Restaurant newRestaurant = Restaurant(
              deliveryPrice: res['delivery price'],
              deliveryTime: res['delivery time'],
              phone: res['phone'],
              restaurantName: res['restaurant name']);

          return Scaffold(
            body: Stack(
              children: [
                Image.asset(
                  'assets/images/background.png',
                  height: height,
                  width: width,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      Container(
                          width: 200,
                          height: 100,
                          decoration: BoxDecoration(
                              border: Border.all(color: textColor),
                              borderRadius: BorderRadius.circular(30)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              order.mealImage,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        translator.translate('meal name:') +
                            '${order.mealName}',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        translator.translate('quantity:') + '${order.quantity}',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        translator.translate('Total price') +
                            ':' +
                            '${order.totalPrice}',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      order.specialRequest == ''
                          ? Container()
                          : Text(
                              translator.translate('special request:') +
                                  '${order.specialRequest}',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        translator.translate('user name:') +
                            '${order.userName}',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        translator.translate('user phone:') +
                            '${order.userPhone}',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        translator.translate('user address:') +
                            '${order.userAddress}',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        translator.translate('time:') +
                            '${DateTime.fromMicrosecondsSinceEpoch(order.time.microsecondsSinceEpoch)}',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        translator.translate('Restaurant name:') +
                            '${newRestaurant.restaurantName}',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        translator.translate('Restaurant phone:') +
                            '${newRestaurant.phone}',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        translator.translate('Delivery time:') +
                            '${newRestaurant.deliveryTime}',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        translator.translate('Delivery price:') +
                            '${newRestaurant.deliveryPrice}',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
