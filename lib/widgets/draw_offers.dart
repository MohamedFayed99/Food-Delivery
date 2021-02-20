import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/models/meal.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../constants.dart';

class DrawOffers extends StatefulWidget {
  final resId;
  DrawOffers({this.resId});
  @override
  _DrawOffersState createState() => _DrawOffersState();
}

class _DrawOffersState extends State<DrawOffers> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        // will get value document such as best seller or best offer or discounts
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('restaurant id', isEqualTo: widget.resId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
                padding: EdgeInsets.only(top: 0),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot product = snapshot.data.docs[index];
                  Meal meal = Meal(
                    name: product['name'],
                    price: product['price'],
                    description: product['components'],
                  );
                  return Container(
                      //height: 180,
                      //width: 200,
                      child: Column(
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 30),
                            child: Container(
                                width: 140,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: textColor),
                                  borderRadius: BorderRadius.circular(20),
                                  // boxShadow:
                                ),
                                child: product['image url'] == null
                                    ? Center(
                                        child: GestureDetector(
                                            //onTap: getImage,
                                            child: Image.asset(
                                          'assets/images/addImage.png',
                                          height: 20,
                                          width: 20,
                                        )),
                                      )
                                    : Container(
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            child: Image.network(
                                              product['image url'],
                                              width: 140,
                                              height: 120,
                                              fit: BoxFit.cover,
                                            )),
                                      ) // this container will contain the product image

                                ),
                          ),
                          Expanded(
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    meal.name,
                                    style: TextStyle(
                                        fontSize: 16, color: textColor),
                                  ),
                                ),
                                Text(
                                  meal.description,
                                  style:
                                      TextStyle(fontSize: 11, color: textColor),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    translator.translate(
                                        'Price ( ${meal.price} EGP)'),
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xffCB9200)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: textColor,
                        indent: 15,
                        endIndent: 15,
                      )
                    ],
                  ));
                });
          }
        });
  }
}
