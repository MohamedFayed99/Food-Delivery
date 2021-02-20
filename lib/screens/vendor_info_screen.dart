import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/models/restaurant.dart';
import 'package:fooddelivery/screens/add_restaurant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path/path.dart';

class VendorInfoScreen extends StatefulWidget {
  static String id = 'VendorInfoScreen';
  @override
  _VendorInfoScreenState createState() => _VendorInfoScreenState();
}

class _VendorInfoScreenState extends State<VendorInfoScreen> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool showEditIcon = true;
  File image;
  File personImage;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
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

  Future<void> uploadRestaurantImage() async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('images/${basename(image.path)}}')
          .putFile(image);
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> uploadPersonImage() async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('images/${basename(personImage.path)}}')
          .putFile(personImage);
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Restaurant restaurant = ModalRoute.of(context).settings.arguments;
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

            Positioned(
                top: 200,
                left: 80,
                child: Text(
                  '${restaurant.managerName}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                )),
            Positioned(
                top: 180,
                right: 10,
                child: Text(
                  '${restaurant.restaurantName}',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                )),
            Form(
              key: globalKey,
              child: ListView(
                padding: EdgeInsets.only(top: 0),
                children: [
                  SizedBox(
                    height: 250,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                    child: Row(
                      children: [
                        Container(
                            width: 250,
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(color: textColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Text(translator.translate('manager Name')),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: '${restaurant.managerName}',
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            top: -15, bottom: 3, left: 10)
                                        //labelText: 'Hi'
                                        ),
                                    onSaved: (value) {
                                      restaurant.managerName = value;
                                    },
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          'assets/images/editIcon.png',
                          width: 25,
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                    child: Row(
                      children: [
                        Container(
                            width: 250,
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(color: textColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Text(translator.translate("e-mail") + " : "),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: '${restaurant.email}',
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            top: -15, bottom: 3, left: 10)),
                                    onSaved: (value) {
                                      restaurant.email = value;
                                    },
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          'assets/images/editIcon.png',
                          width: 25,
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                    child: Row(
                      children: [
                        Container(
                            height: 35,
                            width: 275,
                            decoration: BoxDecoration(
                                border: Border.all(color: textColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Text(translator
                                    .translate('Restaurant Number : ')),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: '${restaurant.phone}',
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.number,
                                    onSaved: (value) {
                                      restaurant.phone = value;
                                    },
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          'assets/images/editIcon.png',
                          width: 25,
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                    child: Row(
                      children: [
                        Container(
                            width: 290,
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(color: textColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Text(
                                    translator.translate("Restaurant Address") +
                                        ' : '),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: '${restaurant.address}',
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    onSaved: (value) {
                                      restaurant.address = value;
                                    },
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          'assets/images/editIcon.png',
                          width: 25,
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 320,
                          //height: 25,
                          decoration: BoxDecoration(
                              border: Border.all(color: textColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Text(translator.translate("nature of food")),
                              Expanded(
                                child: TextFormField(
                                  initialValue: '${restaurant.natureOfFood}',
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  onSaved: (value) {
                                    restaurant.natureOfFood = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            'assets/images/editIcon.png',
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                    child: Container(
                      width: 320,
                      //height: 25,
                      decoration: BoxDecoration(
                          border: Border.all(color: textColor),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Text(translator.translate('Subscription term : ')),
                          Expanded(
                            child: TextFormField(
                              initialValue:
                                  'Subscription term : Only one month 16/10/2020 to 16/11/2020',
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              onSaved: (value) {
                                restaurant.subscriptionTerm = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 250,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(color: textColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Text(translator.translate("Payment method") +
                                  ' : '),
                              Expanded(
                                child: TextFormField(
                                  initialValue: 'Visa',
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  onSaved: (value) {
                                    restaurant.payMethod = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          'assets/images/editIcon.png',
                          width: 25,
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 230,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(color: textColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Text(translator.translate("Code") + ' : '),
                              Expanded(
                                child: TextFormField(
                                  initialValue: '123456789123456',
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          'assets/images/editIcon.png',
                          width: 25,
                          height: 25,
                        ),
                      ],
                    ),
                  ),

                  // Done button
                  Padding(
                    padding: const EdgeInsets.only(left: 200, right: 50),
                    child: Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          )),
                      child: Builder(
                        builder: (context) => FlatButton(
                          child: Text(
                            translator.translate('Done'),
                            style: TextStyle(color: secondaryColor),
                          ),
                          onPressed: () async {
                            globalKey.currentState.save();

                            if (personImage == null || image == null) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('No Images Selected')));
                            } else {
                              setState(() {
                                isLoading = true;
                              });
                              await uploadRestaurantImage();
                              final restaurantImageRef = FirebaseStorage
                                  .instance
                                  .ref()
                                  .child('images/${basename(image.path)}}');
                              var restaurantImageUrl =
                                  await restaurantImageRef.getDownloadURL();
                              restaurant.imageUrl = restaurantImageUrl;

                              await uploadPersonImage();
                              final personImageRef = FirebaseStorage.instance
                                  .ref()
                                  .child(
                                      'images/${basename(personImage.path)}}');
                              var personImageUrl =
                                  await personImageRef.getDownloadURL();
                              restaurant.personImageUrl = personImageUrl;

                              setState(() {
                                isLoading = false;
                              });
                            }
                            setState(() {
                              isLoading = false;
                            });
                            Scaffold.of(context)
                                .showSnackBar(SnackBar(content: Text('Done')));
                            Navigator.of(context).popAndPushNamed(
                                AddRestaurantScreen.id,
                                arguments: restaurant);
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                bottom: -220,
                left: -150,
                child: Image.asset(
                  'assets/images/bottom-left.png',
                  height: 330,
                  width: 330,
                )),
            Positioned(
                bottom: 5,
                right: 20,
                child: Image.asset(
                  'assets/images/fooddelivery2.png',
                  height: 70,
                  width: 70,
                )),
            // restaurant image
            Positioned(
              top: 30,
              child: Container(
                height: 140,
                width: 360,
                decoration: BoxDecoration(
                  border: Border.all(color: textColor),
                ),
                child: image == null
                    ? Center(
                        child: InkWell(
                            onTap: getImage,
                            child: Image.asset(
                              'assets/images/addImage.png',
                              height: 50,
                              width: 50,
                            )),
                      )
                    : Image.file(
                        image,
                        height: 140,
                        width: 360,
                        fit: BoxFit.cover,
                      ),
              ),
            ),

            // person image
            Positioned(
                top: 130,
                left: 5,
                child: Container(
                  height: 80,
                  width: 80,
                  child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: personImage == null
                          ? InkWell(
                              onTap: getPersonImage,
                              child: Image.asset(
                                'assets/images/addImage.png',
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                personImage,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            )),
                )),
          ],
        ),
      ),
    );
  }
}
