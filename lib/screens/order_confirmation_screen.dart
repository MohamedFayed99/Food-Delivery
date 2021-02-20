import 'package:flutter/material.dart';
import 'package:fooddelivery/models/meal.dart';
import 'package:fooddelivery/providers/cart_item.dart';
import 'package:fooddelivery/screens/order_progress_screen.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class OrderConfirmationScreen extends StatefulWidget {
  static String id = 'OrderConfirmationScreen';
  @override
  _OrderConfirmationScreenState createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    //Meal orderedMeal = ModalRoute.of(context).settings.arguments;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<Meal> meals = Provider.of<CartItem>(context).meals;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            height: height,
            width: width,
            fit: BoxFit.cover,
          ),
          Positioned(
              top: -90,
              right: -180,
              child: Image.asset(
                'assets/images/ellipse.png',
                width: 290,
                height: 290,
              )),
          Positioned(
              top: -120,
              left: -140,
              child: Image.asset(
                'assets/images/hadramot2.png',
                width: 430,
                height: 430,
              )),
          Column(
            children: [
              SizedBox(
                height: 250,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    translator.translate("Restaurant information"),
                    style: TextStyle(fontSize: 12, color: Color(0xffE19B11)),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 100),
                            child: Text(
                              'Hadramot',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                          Text(
                            'Grill_Sandwiches_Fast food',
                            style: TextStyle(
                                fontSize: 15, color: Color(0xffE19B11)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 100),
                            child: Text(
                              'Soft drinks',
                              style: TextStyle(
                                  fontSize: 17, color: Color(0xffE19B11)),
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
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    '( Delivery 25 EGP )',
                    style: TextStyle(fontSize: 12, color: textColor),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'During 50 minutes',
                    style: TextStyle(fontSize: 17, color: textColor),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    'assets/images/motorcycle.png',
                    height: 25,
                    width: 25,
                  )
                ],
              ),
              Divider(
                color: textColor,
              ),

              meals.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 0),
                        itemCount: meals.length,
                        itemBuilder: (context, index) => Card(
                          child: Container(
                            height: 130,
                            width: 330,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.network(
                                  meals[index].mealImage,
                                  width: 120,
                                  height: 100,
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        meals[index].name,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
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
                                                fontSize: 10, color: textColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Price (${meals[index].price})',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xffCB9200)),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Delivery to',
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: Color(0xffCB9200)),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Sayeda Zainab Mosque',
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
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Text(
                        'Cart is Empty',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
//
              meals.isNotEmpty
                  ? Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 160, bottom: 20),
                      child: Container(
                        width: 150,
                        child: Builder(
                          builder: (context) => FlatButton(
                              color: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(OrderProgressScreen.id);
                              },
                              child: Text(
                                'Confirmation',
                                style: TextStyle(color: Color(0xffFDC83E)),
                              )),
                        ),
                      ),
                    )
                  : Container()
            ],
          )
        ],
      ),
    );
  }
}
