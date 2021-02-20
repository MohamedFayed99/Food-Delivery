import 'package:flutter/material.dart';
import 'package:fooddelivery/models/restaurant.dart';
import 'package:fooddelivery/providers/restaurant_item.dart';
import 'package:fooddelivery/screens/add_product.dart';
import 'package:fooddelivery/screens/home_screen.dart';
import 'package:fooddelivery/screens/vendor_info_screen.dart';
import 'package:fooddelivery/widgets/draw_offers.dart';
import 'package:fooddelivery/widgets/smooth_star_rating.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ViewRestaurantInformation extends StatefulWidget {
  static String id = 'ViewRestaurantInformation';
  @override
  _ViewRestaurantInformationState createState() =>
      _ViewRestaurantInformationState();
}

class _ViewRestaurantInformationState extends State<ViewRestaurantInformation> {
  final GlobalKey _menuKey = new GlobalKey();
  bool showOffers = true;
  String popValue = 'Best seller';
  void _showPopupMenu() async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(15, 420, 200, 400),
      items: [
        PopupMenuItem<String>(
          child: const Text('Best seller'),
          value: 'Best seller',
        ),
        PopupMenuItem<String>(
          child: const Text('Best offer'),
          value: 'Best offer',
        ),
        PopupMenuItem<String>(
          child: const Text('Discounts'),
          value: 'Discounts',
        ),
      ],
      elevation: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final restaurants = Provider.of<RestaurantItem>(context).restaurants;
    Restaurant restaurant = restaurants.first;
    print(restaurants);

    final button = new PopupMenuButton(
      itemBuilder: (_) => <PopupMenuItem<String>>[
        new PopupMenuItem<String>(
            child: const Text('Best seller'), value: 'Best seller'),
        new PopupMenuItem<String>(
            child: const Text('Best offer'), value: 'Best offer'),
        new PopupMenuItem<String>(
            child: const Text('Discounts'), value: 'Discounts'),
      ],
    );
    final tile = new ListTile(
        title: new Text('Doge or lion?'),
        trailing: button,
        onTap: () {
          // This is a hack because _PopupMenuButtonState is private.
          dynamic state = _menuKey.currentState;
          state.showButtonMenu();
        });

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: -90,
              right: -160,
              child: Image.asset(
                'assets/images/ellipse.png',
                width: 300,
                height: 290,
              )),
          Positioned(
              top: 120,
              right: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(VendorInfoScreen.id);
                  },
                  child: Image.network(
                    restaurant.personImageUrl,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
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
                      height: 400,
                      width: 400,
                    ),
                    Container(
                      height: 400,
                      width: 400,
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
          Positioned(
              bottom: -225,
              left: -150,
              child: Image.asset(
                'assets/images/red-ellipse.png',
                height: 330,
                width: 330,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    translator.translate('Restaurant information'),
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
                              '${restaurant.restaurantName}',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 100),
                            child: Text(
                              '${restaurant.natureOfFood}',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xffE19B11)),
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
                    translator.translate(
                        '( Delivery ${restaurant.deliveryPrice} EGP )'),
                    style: TextStyle(fontSize: 12, color: textColor),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    translator
                        .translate('During ${restaurant.deliveryTime} minutes'),
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
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100,
                  ),
                  InkWell(
                      onTap: _showPopupMenu,
                      child: Image.asset(
                        'assets/images/addIcon.png',
                        width: 20,
                        height: 20,
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    translator.translate('Offers'),
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  SmoothStarRating(
                    starCount: 5,
                    color: Colors.red,
                    allowHalfRating: true,
                    rating: 5,
                    size: 12,
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: Container(
                    height: 130,
                    child: DrawOffers(
                      resId: restaurant.restaurantId,
                    )),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 170, top: 20, bottom: 40),
                  child: Container(
                    height: 40,
                    width: 170,
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
                            translator.translate('Add new products'),
                            style: TextStyle(
                              color: Color(0xffFDC83E),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            AddProduct.id,
                          );
                        }),
                  ),
                ),
              )
            ],
          ),
          Positioned(
              bottom: 15,
              left: 40,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).popAndPushNamed(HomeScreen.id);
                },
                child: Image.asset(
                  'assets/images/home.png',
                  width: 50,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
