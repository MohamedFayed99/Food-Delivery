import 'package:flutter/material.dart';
import 'package:fooddelivery/models/meal.dart';
import 'package:fooddelivery/models/order.dart';
import 'package:fooddelivery/providers/cart_item.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ProductInfoScreen extends StatefulWidget {
  static String id = 'ProductInfoScreen';
  final String resId;
  ProductInfoScreen({this.resId});
  @override
  _ProductInfoScreenState createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  int _quantity = 1;
  String specialRequest;
  Order order = Order();
  double totalPrice = 00.00;
  @override
  Widget build(BuildContext context) {
    Meal meal = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Form(
        key: globalKey,
        child: Stack(
          children: [
            Positioned(
                top: -30,
                left: -50,
                child: Image.asset(
                  'assets/images/ba.png',
                  width: 300,
                  height: 300,
                )),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Color(0xff828282),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black54),
                      ),
                      child: Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                                image: NetworkImage(meal.mealImage),
                                //alignment: Alignment.center,
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 180, top: 20),
                    child: Container(
                        width: 150,
                        height: 40,
                        child: Text(
                          meal.category,
                          style: TextStyle(fontSize: 20, color: primaryColor),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 180),
                    child: Container(
                        width: 150,
                        height: 40,
                        child: Text(
                          meal.name,
                          style: TextStyle(fontSize: 20, color: primaryColor),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 180),
                    child: Container(
                        width: 150,
                        child: Text(
                          meal.description,
                          style: TextStyle(fontSize: 11, color: textColor),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 200),
                    child: Container(
                        width: 140,
                        height: 30,
                        child: Text(
                          translator.translate('Price ( ${meal.price} )'),
                          style:
                              TextStyle(fontSize: 20, color: Color(0xffCB9200)),
                        )),
                  ),
                  Divider(
                    color: textColor,
                    indent: 15,
                    endIndent: 15,
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 80),
                        child: Container(
                          child: Row(
                            children: [
                              Text(
                                translator.translate('Special request?'),
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                translator.translate('(optional)'),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.comment,
                        size: 30,
                        color: Colors.black,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 150, top: 0),
                    child: Container(
                      width: 150,
                      height: 30,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                            hintText: translator.translate('Click to enter'),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(top: -10, bottom: 3, left: 5),
                            labelStyle: TextStyle(color: secondaryColor)),
                        onSaved: (value) {
                          specialRequest = value;
                        },
                      ),
                    ),
                  ),
                  Divider(
                    color: textColor,
                    indent: 15,
                    endIndent: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _quantity++;
                            });
                          },
                          child: Icon(
                            Icons.add,
                            color: primaryColor,
                            size: 30,
                          )),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        '$_quantity',
                        style: TextStyle(fontSize: 40, color: Colors.black),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      GestureDetector(
                          onTap: () {
                            if (_quantity > 1) {
                              setState(() {
                                _quantity--;
                              });
                            }
                          },
                          child: Icon(
                            Icons.remove,
                            color: primaryColor,
                            size: 30,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 140,
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
                              onPressed: () {
                                addToCart(context, meal);
                                Navigator.pop(context);
                              },
                              child: Text(
                                translator.translate('Add to cart'),
                                style: TextStyle(color: Color(0xffFDC83E)),
                              )),
                        ),
                      ),
                      Container(
                        width: 140,
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
                              onPressed: () {},
                              child: Text(
                                translator.translate('follow order'),
                                style: TextStyle(color: Color(0xffFDC83E)),
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              top: 300,
              left: 10,
              child: Material(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
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
              ),
            )
          ],
        ),
      ),
    );
  }

  void addToCart(context, Meal meal) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    globalKey.currentState.save();
    meal.quantity = _quantity;
    meal.specialRequest = specialRequest;
    print(meal.specialRequest);

    bool exist = false;
    var productsInCart = cartItem.meals;
    for (var productInCart in productsInCart) {
      if (productInCart.name == meal.name) {
        exist = true;
      }
    }
    if (exist) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('you\'ve added this item before'),
      ));
    } else {
      cartItem.addProduct(meal);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Added to Cart'),
      ));
    }
  }
}
