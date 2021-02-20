import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/widgets/custom_text_field.dart';
import 'package:fooddelivery/widgets/draw_back_icon.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static String id = 'ForgetPasswordScreen';

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String email;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
            Form(
              key: globalKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    // this space for fooddelivery image
                    Image.asset(
                      'assets/images/fooddelivery2.png',
                      height: 130,
                      width: 130,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 50),
                      child: Container(
                        height: 40,
                        child: CustomTextField(
                          hint: translator.translate('e-mail or phone'),
                          onClicked: (value) {
                            email = value;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
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
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                          email: email.trim());
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          'check your email to reset password')));
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              child: Text(
                                translator.translate('Send'),
                                style: TextStyle(color: Color(0xffFDC83E)),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // put the bottom-right image here
            Positioned(
                bottom: -150,
                right: -200,
                child: Image.asset(
                  'assets/images/bottom-right.png',
                  height: 305,
                  width: 330,
                )),

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
