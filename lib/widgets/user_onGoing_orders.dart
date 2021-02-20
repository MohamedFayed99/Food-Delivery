import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/models/order.dart';
import 'package:fooddelivery/screens/user_order_details_screen.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../constants.dart';

class UserOngoingOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserItem>(context, listen: false).userInformation;

    final _auth = FirebaseAuth.instance;
    var newUser = _auth.currentUser;
    String userEmail = newUser.email;

    print(' user email: $userEmail');

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('user email', isEqualTo: userEmail)
            .where('onGoing', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Order> orders = [];
            for (var order in snapshot.data.docs) {
              orders.add(Order(
                mealName: order['meal name'],
                totalPrice: order['total price'],
                quantity: order['quantity'],
                specialRequest: order['special request'],
                mealImage: order['image url'],
                restaurantId: order['restaurant id'],
                userAddress: order['user address'],
                userName: order['user name'],
                userPhone: order['user phone'],
                time: order['time'],
              ));
            }

            return Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 280,
                  //width: 350,
                  child: orders.isNotEmpty
                      ? ListView.builder(
                          padding: EdgeInsets.only(top: 0),
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    UserOrderDetailsScreen.id,
                                    arguments: orders[index]);
                              },
                              child: Card(
                                child: Container(
                                  height: 150,
                                  width: 330,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Image.network(
                                          orders[index].mealImage,
                                          width: 120,
                                          height: 100,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Text(
                                              orders[index].mealName,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 10,
                                              width: 150,
                                              child: Center(
                                                child: Text(
                                                  translator.translate(
                                                          "quantity:") +
                                                      '${orders[index].quantity}',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: textColor),
                                                ),
                                              ),
                                            ),
                                          ),
                                          (orders[index].specialRequest) == ''
                                              ? SizedBox()
                                              : Expanded(
                                                  child: Container(
                                                    height: 10,
                                                    width: 150,
                                                    child: Center(
                                                      child: Text(
                                                        translator.translate(
                                                                "special request:") +
                                                            ' ${orders[index].specialRequest}',
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            color: textColor),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          Text(
                                            translator
                                                    .translate('Total price') +
                                                ':' +
                                                '(${orders[index].totalPrice})',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xffCB9200)),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            translator.translate('Delivery to'),
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: Color(0xffCB9200)),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${orders[index].userAddress}',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xffAE0001)),
                                              ),
                                              Icon(
                                                Icons.location_on,
                                                color: Colors.red,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                      : Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Text(
                            translator.translate('No Orders'),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: textColor,
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                      ),
                      Text(
                        translator.translate('Back'),
                        style: TextStyle(color: primaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        });
  }
}
