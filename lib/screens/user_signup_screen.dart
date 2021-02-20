import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/screens/map.dart';
import 'package:fooddelivery/widgets/custom_text_field.dart';
import 'package:fooddelivery/widgets/draw_back_icon.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'SignupScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isUser = false;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String email, password, name, phone;
  bool isLoading = false;
  bool typing = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                      height: 100,
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
                      translator.translate('User account'),
                      style: TextStyle(color: textColor, fontSize: 16),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 65),
                      child: Row(
                        children: [
                          Container(
                            //height: 40,
                            width: 240,
                            child: CustomTextField(
                              hint: translator.translate('user2'),
                              onClicked: (value) {
                                name = value;
                              },
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    typing = true;
                                  });
                                }
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
                      height: 10,
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
                                email = value;
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
                      height: 10,
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
                                phone = value;
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
                      height: 10,
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
                                password = value;
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
                      height: 10,
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
                      height: 30,
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
                                  isUser = true;
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    final result = await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: email.trim(),
                                            password: password.trim());
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(result.user.uid)
                                        .set({
                                      'name': name,
                                      'email': email,
                                      'phone': phone,
                                      'password': password,
                                      'is user': isUser
                                    });
                                    print(result.user.email);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.of(context)
                                        .popAndPushNamed(Map.id);
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
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
