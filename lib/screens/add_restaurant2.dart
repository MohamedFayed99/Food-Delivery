import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/models/restaurant.dart';
import 'package:fooddelivery/providers/restaurant_item.dart';
import 'package:fooddelivery/screens/add_product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class AddRestaurant2 extends StatefulWidget {
  static String id = 'AddRestaurant2';

  @override
  _AddRestaurant2State createState() => _AddRestaurant2State();
}

class _AddRestaurant2State extends State<AddRestaurant2> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool showOffers = false;
  bool showFoodRatings = false;
  bool showOffersContainers = false;
  File personImage;

  final picker = ImagePicker();
  bool showMore = false;

  Future getPersonImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        personImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Restaurant restaurant = ModalRoute.of(context).settings.arguments;
    final resItem = Provider.of<RestaurantItem>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Stack(
          children: [
            Positioned(
                top: -90,
                right: -180,
                child: Image.asset(
                  'assets/images/ellipse.png',
                  width: 290,
                  height: 290,
                )),
            Positioned(
                top: 120,
                right: 5,
                child: restaurant.personImageUrl == null
                    ? InkWell(
                        child: Image.asset(
                          'assets/images/person-icon.png',
                          height: 50,
                          width: 50,
                        ),
                        onTap: getPersonImage,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          restaurant.personImageUrl,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ))),
            Positioned(
                top: -120,
                left: -140,
                child: Container(
                  height: 430,
                  width: 430,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/white-circle.png',
                        height: 430,
                        width: 430,
                      ),
                      Container(
                        height: 430,
                        width: 430,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(200),
                                topRight: Radius.circular(200),
                                bottomLeft: Radius.circular(200)),
                            image: DecorationImage(
                                image: NetworkImage(restaurant.imageUrl),
                                //alignment: Alignment.center,
                                fit: BoxFit.cover)),
                      ),
                    ],
                  ),
                )),
//          Positioned(
//              bottom: -225,
//              left: -150,
//              child: Image.asset(
//                'assets/images/red-ellipse.png',
//                height: 330,
//                width: 330,
//              )
//          ),
            Form(
              key: globalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 260,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translator.translate('Restaurant information'),
                        style:
                            TextStyle(fontSize: 12, color: Color(0xffE19B11)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 100),
                                child: Text(
                                  '${restaurant.restaurantName}',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 100),
                                child: Text(
                                  '${restaurant.natureOfFood}',
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xffE19B11)),
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
                  Container(
                    //height: 50,
                    width: 360,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 90,
                        ),
                        Container(
                          width: 120,
                          child: Text(
                              translator.translate(
                                  '( Delivery ${restaurant.deliveryPrice} EGP)'),
                              style: TextStyle(
                                fontSize: 12,
                                color: textColor,
                              )),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 120,
                          child: Text(
                              translator.translate(
                                  'During ${restaurant.deliveryTime} minutes'),
                              style: TextStyle(
                                fontSize: 12,
                                color: textColor,
                              )),
                        ),
                        Image.asset(
                          'assets/images/motorcycle.png',
                          height: 25,
                          width: 25,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: textColor,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        color: primaryColor,
                        child: Center(
                          child: Text(
                            translator.translate('Add products'),
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          DocumentReference ref = FirebaseFirestore.instance
                              .collection('vendors')
                              .doc();
                          restaurant.restaurantId = ref.id;
                          print(ref.id);
                          print(restaurant.restaurantId);
                          setState(() {
                            isLoading = true;
                          });
                          await ref.set({
                            'id': restaurant.restaurantId,
                            'restaurant name': restaurant.restaurantName,
                            'manager name': restaurant.managerName,
                            'email': restaurant.email,
                            'phone': restaurant.phone,
                            'password': restaurant.password,
                            'nature of food': restaurant.natureOfFood,
                            'address': restaurant.address,
                            'restaurant image url': restaurant.imageUrl,
                            'person image url': restaurant.imageUrl,
                            'subscription term': restaurant.subscriptionTerm,
                            'payment method': restaurant.payMethod,
                            'delivery price': restaurant.deliveryPrice,
                            'delivery time': restaurant.deliveryTime,
                          });
                          resItem.addRestaurant(restaurant);
                          print(resItem.restaurants[0].restaurantId);
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.of(context).popAndPushNamed(AddProduct.id,
                              arguments: ref.id);
                        }),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
