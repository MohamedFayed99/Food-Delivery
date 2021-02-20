import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/models/meal.dart';
import 'package:fooddelivery/providers/cart_item.dart';
import 'package:fooddelivery/screens/user_order_progress_screen.dart';
import 'package:fooddelivery/widgets/custom_text_field.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class UserOrderConfirmationScreen extends StatefulWidget {
  static String id = 'OrderConfirmationScreen';
  @override
  _UserOrderConfirmationScreenState createState() =>
      _UserOrderConfirmationScreenState();
}

class _UserOrderConfirmationScreenState
    extends State<UserOrderConfirmationScreen> {
  bool isLoading = false;
  bool showConfirmationButton = true;

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String userName, userPhone, userAddress;

  @override
  Widget build(BuildContext context) {
    //Meal orderedMeal = ModalRoute.of(context).settings.arguments;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<Meal> meals = Provider.of<CartItem>(context).meals;

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/background.png',
              height: height,
              width: width,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Form(
                key: globalKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 50, right: 50),
                      child: Text(
                        translator.translate('Your Orders'),
                        style: TextStyle(fontSize: 20, color: textColor),
                      ),
                    ),

                    meals.isNotEmpty
                        ? Container(
                            height: 300,
                            child: ListView.builder(
                              padding: EdgeInsets.only(top: 0),
                              itemCount: meals.length,
                              itemBuilder: (context, index) => Column(
                                children: [
                                  Card(
                                    child: Container(
                                      height: 150,
                                      width: 330,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.network(
                                            meals[index].mealImage,
                                            width: 120,
                                            height: 120,
                                          ),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text(
                                                  meals[index].name,
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
                                                      meals[index].description,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: textColor),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 10,
                                                  width: 150,
                                                  child: Center(
                                                    child: Text(
                                                      translator.translate(
                                                              'quantity:') +
                                                          ('${meals[index].quantity}'),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: textColor),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                translator.translate(
                                                        'Total price') +
                                                    ('${double.parse(meals[index].price) * (meals[index].quantity)}'),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xffCB9200)),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                translator
                                                    .translate('Delivery to'),
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    color: Color(0xffCB9200)),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'user address',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xffAE0001)),
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
                                ],
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 200),
                            child: Text(
                              translator.translate('Cart is Empty'),
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                    meals.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 65, top: 20),
                            child: Row(
                              children: [
                                Container(
                                  width: 240,
                                  child: CustomTextField(
                                    hint:
                                        translator.translate("Enter your Name"),
                                    onClicked: (value) {
                                      userName = value;
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Image.asset(
                                    'assets/images/organic-food.png',
                                    height: 25,
                                    width: 25,
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    meals.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 65, top: 10),
                            child: Row(
                              children: [
                                Container(
                                  width: 240,
                                  child: CustomTextField(
                                    hint: translator.translate('phone number'),
                                    onClicked: (value) {
                                      userPhone = value;
                                    },
                                    keyboardType: TextInputType.phone,
                                  ),
                                ),
                                Expanded(
                                  child: Image.asset(
                                    'assets/images/organic-food.png',
                                    height: 25,
                                    width: 25,
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    meals.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 65, top: 10),
                            child: Row(
                              children: [
                                Container(
                                  width: 240,
                                  child: CustomTextField(
                                    hint: translator
                                        .translate('Enter your Address'),
                                    onClicked: (value) {
                                      userAddress = value;
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Image.asset(
                                    'assets/images/organic-food.png',
                                    height: 25,
                                    width: 25,
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),

//
                    (meals.isNotEmpty && showConfirmationButton == true)
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 160, bottom: 20),
                            child: Container(
                              width: 150,
                              child: Builder(
                                builder: (context) => FlatButton(
                                    color: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    onPressed: () async {
                                      //final user = Provider.of<UserItem>(context,listen: false).userInformation;
                                      if (globalKey.currentState.validate()) {
                                        globalKey.currentState.save();
                                        setState(() {
                                          isLoading = true;
                                        });
                                        for (var orderedMeal in meals) {
                                          DocumentReference ref =
                                              FirebaseFirestore.instance
                                                  .collection('orders')
                                                  .doc();
                                          ref.set({
                                            'order id': ref.id,
                                            'restaurant id':
                                                orderedMeal.restaurantId,
                                            'meal name': orderedMeal.name,
                                            'quantity': orderedMeal.quantity,
                                            'total price': double.parse(
                                                    orderedMeal.price) *
                                                (orderedMeal.quantity),
                                            'user name': userName,
                                            'user email': FirebaseAuth
                                                .instance.currentUser.email,
                                            'user phone': userPhone,
                                            'user address': userAddress,
                                            'special request':
                                                orderedMeal.specialRequest,
                                            'image url': orderedMeal.mealImage,
                                            'time': DateTime.now(),
                                            'onGoing': true,
                                            'onCompleted': false,
                                          });
                                        }
                                        setState(() {
                                          meals.clear();
                                          isLoading = false;
                                        });
                                        Navigator.of(context).popAndPushNamed(
                                            UserOrderProgressScreen.id);
                                      }
                                    },
                                    child: Text(
                                      translator.translate('Confirmation'),
                                      style:
                                          TextStyle(color: Color(0xffFDC83E)),
                                    )),
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
