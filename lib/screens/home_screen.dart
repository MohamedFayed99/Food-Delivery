import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/models/restaurant.dart';
import 'package:fooddelivery/screens/home1.dart';
import 'package:fooddelivery/screens/search_screen.dart';
import 'package:fooddelivery/screens/user_orders_screen.dart';
import 'package:fooddelivery/widgets/slider_item.dart';
import 'package:fooddelivery/widgets/view_all_restaurant.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool onDrawerClicked = false;
  @override
  final TextEditingController _searchControl = new TextEditingController();

  Restaurant searchRest;

  int _current = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      height: isCurrentPage ? 16.0 : 14,
      width: isCurrentPage ? 16.0 : 14.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.black : Colors.grey[500],
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map> foods = [
      {"img": "assets/food1.jpg", "name": "Fruit Salad"},
      {"img": "assets/food2.jpg", "name": "Fruit Salad"},
      {"img": "assets/food3.jpg", "name": "Hamburger"},
      {"img": "assets/food4.jpg", "name": "Fruit Salad"},
      {"img": "assets/food5.jpg", "name": "Hamburger"},
      {"img": "assets/food6.jpg", "name": "Steak"},
      {"img": "assets/food7.jpg", "name": "Pizza"},
      {"img": "assets/food8.jpg", "name": "Asparagus"},
      {"img": "assets/food9.jpg", "name": "Salad"},
      {"img": "assets/food10.jpg", "name": "Pizza"},
      {"img": "assets/food11.jpg", "name": "Pizza"},
      {"img": "assets/food12.jpg", "name": "Salad"},
    ];
    String name = "";
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Scaffold(
              body: SafeArea(
                child: Stack(children: [
                  Image.asset(
                    'assets/images/background.png',
                    height: height,
                    width: width,
                    fit: BoxFit.cover,
                  ),
                  Opacity(
                    opacity: onDrawerClicked ? .5 : 1,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/fooddelivery2.png',
                                height: 50,
                                width: 50,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Container(
                            decoration: BoxDecoration(
                                // color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                color: Color.fromRGBO(130, 130, 130, 0.31)),
                            child: TextField(
                              onTap: () {
                                Navigator.of(context)
                                    .popAndPushNamed(SearchScreen.id);
                              },
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                hintText: translator
                                    .translate("Search for restaurants"),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: CircleAvatar(
                                    child: Icon(
                                      Icons.tune,
                                      color: Colors.black,
                                    ),
                                    backgroundColor: Colors.white70,
                                  ),
                                ),
                                suffixIcon: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Icon(
                                      Icons.search,
                                      size: 30,
                                      color: Colors.black,
                                    )),
                                hintStyle: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,

                                  color: Color.fromRGBO(130, 130, 130, 0.31),

                                  // TextAlign.center
                                ),
                              ),
                              maxLines: 1,
                              controller: _searchControl,
                              onChanged: (val) {
                                setState(() {
                                  name = val;
                                });
                              },
                            ),
                          ),
                        ),
                        CarouselSlider(
                            items: map<Widget>(
                              foods,
                              (index, i) {
                                Map food = foods[index];
                                return SliderItem(
                                  img: food['img'],
                                  isFav: false,
                                  name: food['name'],
                                  rating: 5.0,
                                  raters: 23,
                                );
                              },
                            ).toList(),
                            options: CarouselOptions(
                              height: height * 0.2,
                              autoPlay: true,
                              autoPlayCurve: Curves.easeInToLinear,

                              //viewportFraction: 1.0,
                            )),
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < 4; i++)
                              i == 0
                                  ? _buildPageIndicator(true)
                                  : _buildPageIndicator(false),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 24, 0, 0),
                          child: Text(
                            translator.translate("Best Offers"),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromRGBO(203, 146, 0, 1),
                            ),
                          ),
                        ),
                        CarouselSlider(
                            items: map<Widget>(
                              foods,
                              (index, i) {
                                Map food = foods[index];
                                return SliderItem2(
                                  img: food['img'],
                                  isFav: false,
                                  name: food['name'],
                                  rating: 5.0,
                                  raters: 23,
                                );
                              },
                            ).toList(),
                            options: CarouselOptions(
                              enlargeCenterPage: true,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,

                              height: height * 0.18,
                              //viewportFraction: 1.0,
                            )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 20, 0, 0),
                          child: Text(
                            translator.translate("All restaurants"),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromRGBO(203, 146, 0, 1),
                            ),
                          ),
                        ),
                        ViewAllRestaurants(),
                      ],
                    ),
                  ),
                  onDrawerClicked == false
                      ? Positioned(
                          top: 350,
                          left: 10,
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.of(context).popAndPushNamed(HomeScreen.id);
                            },
                            child: Image.asset(
                              'assets/images/top.png',
                              width: 40,
                              height: 40,
                            ),
                          ))
                      : SizedBox(),
                  Positioned(
                      top: 400,
                      left: 10,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            onDrawerClicked = true;
                          });
                        },
                        child: Image.asset(
                          'assets/images/drawer.png',
                          width: 40,
                          height: 40,
                        ),
                      )),
                  onDrawerClicked
                      ? Positioned(
                          top: 335,
                          left: 40,
                          child: Container(
                            height: 150,
                            child: Column(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.person,
                                      size: 40,
                                      color: Colors.black,
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        void keepUserLoggedIn() async {
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          preferences.setBool(
                                              'KeepMeLoggedIn', false);
                                        }
                                      });
                                      Navigator.of(context).pushNamed(Home1.id);
                                    }),
                                Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed(UserOrdersScreen.id);
                                          setState(() {
                                            onDrawerClicked = false;
                                          });
                                        },
                                        child: Image.asset(
                                          'assets/images/res.png',
                                          width: 50,
                                          height: 50,
                                        ))),
                                IconButton(
                                    icon: Icon(
                                      Icons.home,
                                      size: 40,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        onDrawerClicked = false;
                                      });
                                      //Navigator.pop(context);
                                    }),
                              ],
                            ),
                          ),
                        )
                      : SizedBox()
                ]),
              ),
            );
          }
        });
  }
}
