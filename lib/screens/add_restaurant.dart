import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:fooddelivery/models/restaurant.dart';
import 'package:fooddelivery/screens/add_restaurant2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:path/path.dart';

import '../constants.dart';

class AddRestaurantScreen extends StatefulWidget {
  static String id = 'AddRestaurantScreen';
  @override
  _AddRestaurantScreenState createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String dPrice, dTime, food_neature;
  bool showImagesInContainer = false;
  File _image;
  File personImage;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

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

  Future<void> uploadFile() async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('images/${basename(_image.path)}}')
          .putFile(_image);
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    Restaurant restaurant = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
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
                    restaurant.imageUrl == null
                        ? Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 60, top: 120),
                              child: InkWell(
                                child: Image.asset(
                                  'assets/images/addImage.png',
                                  height: 70,
                                  width: 70,
                                ),
                                onTap: getImage,
                              ),
                            ),
                          )
                        : Container(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 265,
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
              Form(
                key: globalKey,
                child: Container(
                  //height: 50,
                  width: 360,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 90,
                      ),
                      Container(
                        width: 100,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText:
                                translator.translate('( Delivery price )'),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: textColor,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Delivery price?';
                            }
                          },
                          onSaved: (value) {
                            restaurant.deliveryPrice = value;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 100,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: translator.translate('Delivery time'),
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: textColor,
                              )),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Delivery time?';
                            }
                          },
                          onSaved: (value) {
                            restaurant.deliveryTime = value;
                          },
                        ),
                      ),
                      Image.asset(
                        'assets/images/motorcycle.png',
                        height: 25,
                        width: 25,
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: textColor,
              ),
              //SizedBox(height: 5,),
              Text(
                translator.translate('Definition of products'),
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xffEBAC08),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(top: 0),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showImagesInContainer = true;
                              food_neature = food_neature + "grill";
                            });
                          },
                          child: Container(
                              width: 150,
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: textColor),
                              ),
                              child: showImagesInContainer == true
                                  ? Center(
                                      child: Image.asset(
                                        'assets/images/grill.png',
                                        height: 45,
                                        width: 130,
                                      ),
                                    )
                                  : Container()),
                        ),
                        GestureDetector(
                            onTap: () {
                              {
                                setState(() {
                                  showImagesInContainer = true;

                                  food_neature = food_neature + "_fastFood";
                                });
                              }
                            },
                            child: Container(
                                width: 150,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.red.shade300,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: textColor),
                                ),
                                child: showImagesInContainer == true
                                    ? Center(
                                        child: Image.asset(
                                          'assets/images/fastFood.png',
                                          height: 45,
                                          width: 130,
                                        ),
                                      )
                                    : Container()),
                            onTapCancel: () {
                              {
                                setState(() {
                                  showImagesInContainer = false;
                                });
                              }
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: Container(
                            width: 80,
                            height: 25,
                            child: Text(
                              translator.translate("Grill"),
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xffAE0001)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 80,
                          ),
                          child: Container(
                            height: 30,
                            child: Text(
                              translator.translate("Fast food"),
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xffAE0001)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                            onTap: () {
                              {
                                setState(() {
                                  food_neature = food_neature + "_sandwich";
                                  showImagesInContainer = true;
                                });
                              }
                            },
                            child: Container(
                                width: 150,
                                height: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: textColor),
                                ),
                                child: showImagesInContainer == true
                                    ? Center(
                                        child: Image.asset(
                                          'assets/images/sandwich.png',
                                          height: 45,
                                          width: 130,
                                        ),
                                      )
                                    : Container()),
                            onTapCancel: () {
                              {
                                setState(() {
                                  showImagesInContainer = false;
                                });
                              }
                            }),
                        GestureDetector(
                            onTap: () {
                              {
                                setState(() {
                                  food_neature = food_neature + "_softDrinks";
                                  showImagesInContainer = true;
                                });
                              }
                            },
                            child: Container(
                                width: 150,
                                height: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: textColor),
                                ),
                                child: showImagesInContainer == true
                                    ? Center(
                                        child: Image.asset(
                                          'assets/images/softDrinks.png',
                                          height: 45,
                                          width: 130,
                                        ),
                                      )
                                    : Container()),
                            onTapCancel: () {
                              {
                                setState(() {
                                  showImagesInContainer = false;
                                });
                              }
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            height: 25,
                            child: Text(
                              translator.translate("Sandwich"),
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xffAE0001)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Container(
                            height: 30,
                            child: Text(
                              translator.translate("Soft drinks"),
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xffAE0001)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          {
                            setState(() {
                              food_neature = "_Anther Products";
                              showImagesInContainer = true;
                            });
                          }
                        },
                        child: Container(
                            width: 150,
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: textColor),
                            ),
                            child: showImagesInContainer == true
                                ? Center(
                                    child: Image.asset(
                                      'assets/images/product.png',
                                      height: 45,
                                      width: 130,
                                    ),
                                  )
                                : Container()),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 25,
                        child: Text(
                          translator.translate("Anther products"),
                          style:
                              TextStyle(fontSize: 20, color: Color(0xffAE0001)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 250),
                child: Container(
                  width: 100,
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
                        onPressed: () async {
                          if (restaurant.imageUrl == null) {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('No Images Selected')));
                          } else if (globalKey.currentState.validate()) {
                            globalKey.currentState.save();
                            Navigator.of(context).popAndPushNamed(
                                AddRestaurant2.id,
                                arguments: restaurant);
                          }
                        },
                        child: Text(
                          translator.translate('Next'),
                          style: TextStyle(color: secondaryColor),
                        )),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
