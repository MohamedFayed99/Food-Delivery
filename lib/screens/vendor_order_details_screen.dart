import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/models/order.dart';

class VendorOrderDetailsScreen extends StatelessWidget {
  static String id = 'VendorOrderDetailsScreen';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Order order = ModalRoute.of(context).settings.arguments;
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
            padding: const EdgeInsets.only(left: 30),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
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
                  'meal name: ${order.mealName}',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'quantity: ${order.quantity}',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Total price: ${order.totalPrice}',
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
                        'special request: ${order.specialRequest}',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'user name: ${order.userName}',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'user phone: ${order.userPhone}',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'user address: ${order.userAddress}',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'time: ${DateTime.fromMicrosecondsSinceEpoch(order.time.microsecondsSinceEpoch)}',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: Container(
                    width: 150,
                    child: Builder(
                      builder: (context) => FlatButton(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('orders')
                                .doc(order.orderId)
                                .update(
                                    {"onCompleted": true, "onGoing": false});
                          },
                          child: Text(
                            'Completed',
                            style: TextStyle(color: Color(0xffFDC83E)),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
