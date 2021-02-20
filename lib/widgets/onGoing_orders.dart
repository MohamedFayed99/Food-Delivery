import 'package:flutter/material.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/models/meal.dart';
import 'package:fooddelivery/providers/cart_item.dart';
import 'package:fooddelivery/screens/home_screen.dart';
import 'package:fooddelivery/screens/order_progress_screen.dart';
import 'package:fooddelivery/widgets/draw_back_icon.dart';
import 'package:provider/provider.dart';

class OngoingOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Meal> meals = Provider.of<CartItem>(context).meals;
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/hadramot.png',
              height: 80,
              width: 80,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Hadramot',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  width: 150,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      '(Delivery 25 EGP) ',
                      style: TextStyle(fontSize: 6, color: Colors.black54),
                    ),
                    Text(
                      'During 50 minutes',
                      style: TextStyle(fontSize: 6, color: Colors.black54),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'assets/images/motorcycle.png',
                      height: 20,
                      width: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 1,
                  width: 150,
                  color: Colors.black,
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 250,
          //width: 350,
          child: meals.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 0),
                    itemCount: meals.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(OrderProgressScreen.id);
                      },
                      child: Card(
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
                                        fontSize: 20, color: Color(0xffCB9200)),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Delivery to',
                                    style: TextStyle(
                                        fontSize: 8, color: Color(0xffCB9200)),
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
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Text(
                    'No Orders',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
        ),
        SizedBox(
          height: 20,
        ),
        Divider(
          color: textColor,
        ),
        SizedBox(
          height: 20,
        ),
        DrawBackButton(
          color: Color(0xffAE0001),
          onPressed: () {
            Navigator.of(context).pushNamed(HomeScreen.id);
          },
        )
      ],
    );
  }
}
