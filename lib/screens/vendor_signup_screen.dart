import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/models/restaurant.dart';
import 'package:fooddelivery/screens/vendor_info_screen.dart';
import 'package:fooddelivery/widgets/custom_text_field.dart';
import 'package:fooddelivery/widgets/draw_back_icon.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class VendorSignUpScreen extends StatefulWidget {
  static String id = 'VendorSignUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<VendorSignUpScreen> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Restaurant restaurant = Restaurant();
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
                bottom: -220,
                left: -150,
                child: Image.asset(
                  'assets/images/bottom-left.png',
                  height: 330,
                  width: 330,
                )),
            Form(
              key: globalKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Image.asset(
                      'assets/images/fooddelivery.png',
                      height: 60,
                      width: 60,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      translator.translate('Vendor account'),
                      style: TextStyle(color: textColor, fontSize: 16),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 65),
                      child: Row(
                        children: [
                          Container(
                            width: 240,
                            child: CustomTextField(
                              hint: translator.translate('user name'),
                              onClicked: (value) {
                                restaurant.managerName = value;
                              },
                            ),
                          ),
                          Expanded(
                            child: Image.asset(
                              'assets/images/organic-food.png',
                              height: 25,
                              width: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 65),
                      child: Row(
                        children: [
                          Container(
                            width: 240,
                            child: CustomTextField(
                              hint: translator.translate('e-mail'),
                              onClicked: (value) {
                                restaurant.email = value;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          Expanded(
                            child: Image.asset(
                              'assets/images/organic-food.png',
                              height: 25,
                              width: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 65),
                      child: Row(
                        children: [
                          Container(
                            width: 240,
                            child: CustomTextField(
                              hint: translator.translate('phone number'),
                              onClicked: (value) {
                                restaurant.phone = value;
                              },
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          Expanded(
                            child: Image.asset(
                              'assets/images/organic-food.png',
                              height: 25,
                              width: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 65),
                      child: Row(
                        children: [
                          Container(
                            width: 240,
                            child: CustomTextField(
                              hint: translator.translate('password'),
                              onClicked: (value) {
                                restaurant.password = value;
                              },
                            ),
                          ),
                          Expanded(
                            child: Image.asset(
                              'assets/images/organic-food.png',
                              height: 25,
                              width: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 65),
                      child: Row(
                        children: [
                          Container(
                            width: 240,
                            child: CustomTextField(
                              hint: translator.translate('confirm password'),
                            ),
                          ),
                          Expanded(
                            child: Image.asset(
                              'assets/images/organic-food.png',
                              height: 25,
                              width: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 65),
                      child: Row(
                        children: [
                          Container(
                            width: 240,
                            child: CustomTextField(
                              hint: translator.translate('restaurant name?'),
                              onClicked: (value) {
                                restaurant.restaurantName = value;
                              },
                            ),
                          ),
                          Expanded(
                            child: Image.asset(
                              'assets/images/organic-food.png',
                              height: 25,
                              width: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 65),
                      child: Row(
                        children: [
                          Container(
                            width: 240,
                            child: CustomTextField(
                              hint: translator.translate('Restaurant Address'),
                              onClicked: (value) {
                                restaurant.address = value;
                              },
                            ),
                          ),
                          Expanded(
                            child: Image.asset(
                              'assets/images/organic-food.png',
                              height: 25,
                              width: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 65),
                      child: Row(
                        children: [
                          Container(
                            width: 240,
                            child: CustomTextField(
                              hint: translator.translate('nature of food?'),
                              onClicked: (value) {
                                restaurant.natureOfFood = value;
                              },
                              //maxLines: 3,
                            ),
                          ),
                          Expanded(
                            child: Image.asset(
                              'assets/images/organic-food.png',
                              height: 25,
                              width: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 200),
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
                                if (globalKey.currentState.validate()) {
                                  globalKey.currentState.save();
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    print(restaurant.email);
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: restaurant.email.trim(),
                                            password:
                                                restaurant.password.trim());
                                    Navigator.of(context).popAndPushNamed(
                                        VendorInfoScreen.id,
                                        arguments: restaurant);

                                    setState(() {
                                      isLoading = false;
                                    });
                                  } catch (e) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(e.message),
                                    ));
                                  }
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              child: Text(
                                translator.translate('Done'),
                                style: TextStyle(color: Color(0xffFDC83E)),
                              )),
                        ),
                      ),
                    ),

                    // put the image here (bottom-left image)
                  ],
                ),
              ),
            ),
            DrawBackButton(
              color: textColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
