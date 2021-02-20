import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/models/meal.dart';
import 'package:fooddelivery/screens/product_info_screen.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../constants.dart';

class ProductsView extends StatefulWidget {
  final String productCategory;
  final String restaurantId;
  ProductsView({this.productCategory, this.restaurantId});
  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  Widget build(BuildContext context) {
//    Restaurant restaurant = Provider.of<RestaurantItem>(context).restaurant;
    return StreamBuilder(
        // put this query : .where('productCategory',isEqualTo: widget.productCategory)
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('restaurant id', isEqualTo: widget.restaurantId)
            .where('category', isEqualTo: widget.productCategory)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot product = snapshot.data.docs[index];
                  Meal meal = Meal(
                      name: product['name'],
                      price: product['price'],
                      description: product['components'],
                      category: product['category'],
                      mealImage: product['image url'],
                      restaurantId: widget.restaurantId);
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(ProductInfoScreen.id, arguments: meal);
                      },
                      child: Card(
                        child: Container(
                            height: 130,
                            //width: 200,
                            child: Column(
                              children: [
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 10, right: 30),
                                      child: Container(
                                          width: 140,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border:
                                                Border.all(color: textColor),
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Text(
                                              meal.name,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Text(
                                            meal.description,
                                            style: TextStyle(
                                                fontSize: 11, color: textColor),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 25),
                                            child: Text(
                                              translator.translate(
                                                  'Price (${meal.price})'),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xffCB9200)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ),
                  );
                });
          }
        });
  }
}
