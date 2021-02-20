import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/models/restaurant.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';

class ChangeAccountDataScreen extends StatefulWidget {
  static String id = 'ChangeAccountDataScreen';
  @override
  _ChangeAccountDataScreenState createState() =>
      _ChangeAccountDataScreenState();
}

class _ChangeAccountDataScreenState extends State<ChangeAccountDataScreen> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  // String managerName,email,restaurantNumber,restaurantAddress;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Restaurant userRestaurant = ModalRoute.of(context).settings.arguments;

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
                  '${userRestaurant.managerName}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                )),
            Positioned(
                top: 130,
                left: 5,
                child: Container(
                  height: 80,
                  width: 80,
                  child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          userRestaurant.personImageUrl,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      )),
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
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
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
                                    initialValue:
                                        '${userRestaurant.managerName}',
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            top: -15, bottom: 3, left: 10)
                                        //labelText: 'Hi'
                                        ),
                                    onSaved: (value) {
                                      userRestaurant.managerName = value;
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
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Row(
                      children: [
                        Container(
                            width: 300,
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(color: textColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Text(translator.translate('e-mail')),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: '${userRestaurant.email}',
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            top: -15, bottom: 3, left: 10)),
                                    onSaved: (value) {
                                      userRestaurant.email = value;
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
                        const EdgeInsets.only(left: 10, bottom: 10, right: 40),
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
                                    .translate('Restaurant Number :')),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: '${userRestaurant.phone}',
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            top: -10, bottom: 3, left: 5)),
                                    keyboardType: TextInputType.number,
                                    onSaved: (value) {
                                      userRestaurant.phone = value;
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
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Row(
                      children: [
                        Container(
                            width: 290,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: textColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Text(translator
                                    .translate('Restaurant Address :')),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: '${userRestaurant.address}',
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            top: -10, bottom: 3, left: 5)),
                                    onSaved: (value) {
                                      userRestaurant.address = value;
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

                  // Done button
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 200, right: 50, top: 50),
                    child: Container(
                      width: 80,
                      height: 35,
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
                            setState(() {
                              isLoading = true;
                            });
                            await FirebaseFirestore.instance
                                .collection('vendors')
                                .doc(userRestaurant.restaurantId)
                                .update({
                              'manager name': userRestaurant.managerName,
                              'email': userRestaurant.email,
                              'phone': userRestaurant.phone,
                              'address': userRestaurant.address,
                            });
                            setState(() {
                              isLoading = false;
                            });
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Edited Successfully')));
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                bottom: 10,
                right: 20,
                child: Image.asset(
                  'assets/images/fooddelivery2.png',
                  height: 80,
                  width: 80,
                )),
            Positioned(
                bottom: -220,
                left: -150,
                child: Image.asset(
                  'assets/images/bottom-left.png',
                  height: 330,
                  width: 330,
                )),
          ],
        ),
      ),
    );
  }
}
