import 'package:flutter/material.dart';
import 'package:fooddelivery/models/meal.dart';
import 'package:fooddelivery/models/restaurant.dart';
import 'package:fooddelivery/providers/cart_item.dart';
import 'package:fooddelivery/screens/user_order_confirmation_screen.dart';
import 'package:fooddelivery/widgets/common_raw.dart';
import 'package:fooddelivery/widgets/products_view.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ViewRestaurantProducts extends StatefulWidget {
  static String id = 'ViewRestaurantProducts';
  @override
  _ViewRestaurantProductsState createState() => _ViewRestaurantProductsState();
}

class _ViewRestaurantProductsState extends State<ViewRestaurantProducts> {
  int tabBarIndex = 0;
  @override
  Widget build(BuildContext context) {
    Restaurant restaurant = ModalRoute.of(context).settings.arguments;

    double totalPrice = 00.00;
    List<Meal> meals = Provider.of<CartItem>(context).meals;
    if (meals.isNotEmpty) {
      for (var meal in meals) {
        setState(() {
          totalPrice += double.parse(meal.price) * meal.quantity;
        });
      }
    }
    // totalPrice = double.parse(orderedMeal.price * orderedMeal.quantity);
    return Stack(
      children: [
        DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                bottom: TabBar(
                  indicatorColor: Color(0xffCB9200),
                  onTap: (index) {
                    setState(() {
                      tabBarIndex = index;
                    });
                  },
                  tabs: [
                    Text(
                      translator.translate('Fast food'),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      translator.translate('Soft drinks'),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      translator.translate('Appetizer'),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      translator.translate('Best seller'),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  Column(
                    children: [
                      CommonRaw(
                          text: translator.translate(
                        'Fast food',
                      )),
                      Expanded(
                          child: ProductsView(
                        productCategory: 'fast food',
                        restaurantId: restaurant.restaurantId,
                      )),
                    ],
                  ),
                  Column(
                    children: [
                      CommonRaw(
                          text: translator.translate(
                        'Soft drinks',
                      )),
                      Expanded(
                          child: ProductsView(
                        productCategory: 'soft drinks',
                        restaurantId: restaurant.restaurantId,
                      )),
                    ],
                  ),
                  Column(
                    children: [
                      CommonRaw(
                          text: translator.translate(
                        'Appetizer',
                      )),
                      Expanded(
                          child: ProductsView(
                        productCategory: 'appetizer',
                        restaurantId: restaurant.restaurantId,
                      )),
                    ],
                  ),
                  Column(
                    children: [
                      CommonRaw(
                          text: translator.translate(
                        'Best seller',
                      )),
                      Expanded(
                          child: ProductsView(
                        productCategory: 'best seller',
                        restaurantId: restaurant.restaurantId,
                      )),
                    ],
                  ),
                ],
              ),
            )),
        Positioned(
            top: 30,
            right: -40,
            child: Image.asset(
              'assets/images/red-ellipse.png',
              width: 80,
              height: 50,
            )),
        Positioned(
            top: 30,
            right: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                restaurant.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            )),
        Positioned(
            top: 50,
            left: 100,
            child: Material(
              color: Colors.transparent,
              child: Text(
                '${restaurant.restaurantName}',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            )),
        Positioned(
            bottom: 5,
            left: 15,
            child: Material(
              child: Opacity(
                opacity: totalPrice == 00.00 ? .5 : 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(UserOrderConfirmationScreen.id);
                  },
                  child: Container(
                    width: 330,
                    height: 70,
                    decoration: BoxDecoration(
                        color: totalPrice == 00.00
                            ? Colors.transparent
                            : secondaryColor,
                        border: Border.all(
                            color: totalPrice == 00.00
                                ? textColor
                                : secondaryColor),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Icon(
                            Icons.shopping_basket,
                            size: 40,
                            color:
                                totalPrice == 00.00 ? textColor : primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 60, right: 60),
                          child: Text(
                            //totalPrice.toString(),
                            totalPrice == null ? '00.00' : '$totalPrice',
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
