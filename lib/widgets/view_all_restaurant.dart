import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/models/restaurant.dart';
import 'package:fooddelivery/screens/view_restaurant_products.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ViewAllRestaurants extends StatefulWidget {
  @override
  _ViewAllRestaurantsState createState() => _ViewAllRestaurantsState();
}

class _ViewAllRestaurantsState extends State<ViewAllRestaurants> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('vendors').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot res = snapshot.data.docs[index];
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
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
                    child: Column(children: [
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(6),
                          height: MediaQuery.of(context).size.height * 0.20,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade100,
                                offset: Offset(3, 8),
                                blurRadius: 15)
                          ]),
                          child: (newRestaurant.imageUrl == null)
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(
                                    newRestaurant.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              ViewRestaurantProducts.id,
                              arguments: newRestaurant);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    translator.translate("arrives in") +
                                        " ${50}" +
                                        translator.translate("minutes"),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Image.asset(
                                    'assets/images/motorcycle.png',
                                    height: 22,
                                    width: 22,
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: Text(
                                    " ${newRestaurant.restaurantName} ",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(children: [
                            Expanded(
                              child: Text(
                                newRestaurant.natureOfFood,
                                style: TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 13,
                                    color: Color(0xffE19B11)),
                                maxLines: 4,
                                textDirection: TextDirection.rtl,
                                softWrap: true,
                              ),
                            ),
                          ]),
                          Row(
                            children: [
                              Text(""),
                              Text(
                                translator.translate("Min:") +
                                    '${newRestaurant.deliveryTime}',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text(
                                  translator.translate("Delivery:") +
                                      '${newRestaurant.deliveryPrice}',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          )
                        ]),
                      )
                    ]),
                  );
                });
          }
        });
  }
}
