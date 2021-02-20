import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/models/meal.dart';
import 'package:fooddelivery/providers/restaurant_item.dart';
import 'package:fooddelivery/screens/view_restaurant_info.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  static String id = 'AddProduct';
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isLoading = false;
  String dropdownValue = translator.translate("Fast food");
  Meal meal = Meal();
  File _image;

  final picker = ImagePicker();

  String name, components, price, category;

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
    final id = ModalRoute.of(context).settings.arguments;
    final restaurants = Provider.of<RestaurantItem>(context).restaurants;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: -30,
              left: -50,
              child: Image.asset(
                'assets/images/ba.png',
                width: 300,
                height: 300,
              )),
          ModalProgressHUD(
            inAsyncCall: isLoading,
            child: SingleChildScrollView(
              child: Form(
                key: globalKey,
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
                        child: _image == null
                            ? GestureDetector(
                                onTap: getImage,
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/addImage.png',
                                    height: 50,
                                    width: 50,
                                    color: Colors.black,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                height: 250,
                                width: 250,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(
                                        image: FileImage(
                                          _image,
                                        ),
                                        //alignment: Alignment.center,
                                        fit: BoxFit.cover)),
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 200, top: 20),
                      child: Container(
                          width: 100,
                          height: 40,
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 20,
                            elevation: 16,
                            style: TextStyle(color: Colors.black),
                            underline: Container(
                              height: 1,
                              color: secondaryColor,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            items: <String>[
                              translator.translate("Fast food"),
                              translator.translate("Soft drinks"),
                              translator.translate("Appetizer"),
                              translator.translate("Best seller"),
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 180),
                      child: Container(
                        width: 150,
                        height: 40,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintStyle:
                                TextStyle(fontSize: 20, color: primaryColor),
                            hintText: translator.translate('name'),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Product Name';
                            }
                          },
                          onSaved: (value) {
                            name = value;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 180),
                      child: Container(
                        width: 160,
                        child: TextFormField(
                          maxLines: 2,
                          decoration: InputDecoration(
                            hintStyle:
                                TextStyle(fontSize: 11, color: textColor),
                            hintText: translator.translate('Ingredients'),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Product components';
                            }
                          },
                          onSaved: (value) {
                            components = value;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 200),
                      child: Container(
                        width: 140,
                        height: 30,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 20, color: Color(0xffCB9200)),
                            hintText: translator.translate('Price (00.00)'),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Product Price';
                            }
                          },
                          onSaved: (value) {
                            price = value;
                          },
                        ),
                      ),
                    ),
                    Divider(
                      color: textColor,
                      indent: 15,
                      endIndent: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: Row(
                        children: [
                          Container(
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
                                    if (globalKey.currentState.validate()) {
                                      globalKey.currentState.save();
                                      print(id);

                                      try {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await uploadFile();
                                        final ref = FirebaseStorage.instance
                                            .ref()
                                            .child(
                                                'images/${basename(_image.path)}}');
                                        var url = await ref.getDownloadURL();
                                        print('url: $url');
                                        print(id);
                                        await FirebaseFirestore.instance
                                            .collection('products')
                                            .add({
                                          'restaurant id':
                                              restaurants[0].restaurantId,
                                          'name': name,
                                          'price': price,
                                          'category':
                                              dropdownValue.toLowerCase(),
                                          'components': components,
                                          'image url': url,
                                        });
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                content:
                                                    Text('Add Successfully')));
                                        setState(() {
                                          globalKey.currentState.reset();
                                          _image = null;
                                        });
                                      } catch (e) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                content:
                                                    Text('An error occured')));
                                      }
                                    }
                                  },
                                  child: Text(
                                    translator.translate('More'),
                                    style: TextStyle(
                                      color: secondaryColor,
                                    ),
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(translator.translate('or')),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
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
                                    if (globalKey.currentState.validate()) {
                                      globalKey.currentState.save();
                                      setState(() {
                                        isLoading = true;
                                      });
                                      try {
                                        await uploadFile();
                                        final ref = FirebaseStorage.instance
                                            .ref()
                                            .child(
                                                'images/${basename(_image.path)}}');
                                        var url = await ref.getDownloadURL();
                                        print('url: $url');
                                        print(restaurants[0].restaurantId);
                                        await FirebaseFirestore.instance
                                            .collection('products')
                                            .add({
                                          'restaurant id':
                                              restaurants[0].restaurantId,
                                          'name': name,
                                          'price': price,
                                          'category':
                                              dropdownValue.toLowerCase(),
                                          'components': components,
                                          'image url': url,
                                        });
                                        setState(() {
                                          isLoading = false;
                                        });

                                        Navigator.of(context).popAndPushNamed(
                                            ViewRestaurantInformation.id);
                                      } catch (e) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                content:
                                                    Text('An error occurred')));
                                      }
                                    }
                                  },
                                  child: Text(
                                    translator.translate('Done'),
                                    style: TextStyle(color: secondaryColor),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 300,
            left: 10,
            child: Material(
              color: Colors.transparent,
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
          ),
        ],
      ),
    );
  }
}
