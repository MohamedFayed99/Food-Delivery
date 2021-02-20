import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/models/user_information.dart';
import 'package:fooddelivery/providers/user_item.dart';
import 'package:fooddelivery/screens/forget_password_screen.dart';
import 'package:fooddelivery/screens/geolocation.dart';
import 'package:fooddelivery/screens/home_screen.dart';
import 'package:fooddelivery/screens/vendor_profile_screen.dart';
import 'package:fooddelivery/widgets/custom_text_field.dart';
import 'package:fooddelivery/widgets/draw_back_icon.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VendorLoginScreen extends StatefulWidget {
  static String id = 'VendorLoginScreen';

  @override
  _VendorLoginScreenState createState() => _VendorLoginScreenState();
}

class _VendorLoginScreenState extends State<VendorLoginScreen> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String email, password;
  bool isLoading = false;
  bool typing = false;
  bool keepMeLoggedIn = false;

  static final FacebookLogin facebookSignIn = new FacebookLogin();
  String _message = 'Log in/out by pressing the buttons below.';

  Future<Null> _login() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        _showMessage('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        final AuthCredential credential =
            FacebookAuthProvider.getCredential(result.accessToken.token);
        final User user =
            (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        print('signed in ' + user.displayName);
        return user;
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
    keepMeLoggedIn = false;
    Navigator.of(context).pushNamed(HomeScreen.id);
    print("token: ${result.errorMessage}");
  }

  Future<Null> _logOut() async {
    await facebookSignIn.logOut();
    _showMessage('Logged out.');
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  void keepUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('KeepMeLoggedIn', keepMeLoggedIn);
  }

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
          //put the image here(top-left image)
          Positioned(
              top: -150,
              left: -200,
              child: Image.asset(
                'assets/images/top-left.png',
                height: 330,
                width: 330,
              )),

          Positioned(
              top: 20,
              right: 20,
              child: Image.asset(
                'assets/images/food-on-plate.png',
                height: 70,
                width: 70,
              )),
          Form(
            key: globalKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    typing
                        ? 'assets/images/fooddelivery2.png'
                        : 'assets/images/fooddelivery.png',
                    height: 180,
                    width: 170,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CustomTextField(
                        hint: translator.translate('e-mail or phone'),
                        onClicked: (value) {
                          email = value;
                        },
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              typing = true;
                            });
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Checkbox(
                            checkColor: secondaryColor,
                            activeColor: primaryColor,
                            value: keepMeLoggedIn,
                            onChanged: (value) {
                              setState(() {
                                keepMeLoggedIn = value;
                              });
                            }),
                        Text(
                          'Remember me',
                          style: TextStyle(color: textColor),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CustomTextField(
                        hint: translator.translate('password'),
                        onClicked: (value) {
                          password = value;
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
                  ),
                  SizedBox(
                    height: 10,
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
                                final result = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: email.trim(),
                                        password: password.trim());
                                print(result.user.email);
                                final user = await FirebaseFirestore.instance
                                    .collection('vendors')
                                    .doc(result.user.uid)
                                    .get();
                                var userData = user.data();

                                if (userData != null) {
                                  Provider.of<UserItem>(context, listen: false)
                                          .userInformation =
                                      UserInformation(
                                          name: userData['name'],
                                          address: userData['address'],
                                          phone: userData['phone'],
                                          email: userData['email'],
                                          password: userData['password']);
                                }

                                print('user Data ${user.data()}');

                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.of(context).popAndPushNamed(
                                    HomeProfileScreen.id,
                                    arguments: email.trim());
                              } catch (e) {
                                setState(() {
                                  isLoading = false;
                                });
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(e.message),
                                ));
                              }
                            }
                            if (keepMeLoggedIn == true) {
                              keepUserLoggedIn();
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: Text(
                            translator.translate('Login'),
                            style: TextStyle(color: Color(0xffFDC83E)),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(Geo.id);
                        },
                        child: Text(
                          translator.translate('Create an account?'),
                          style: TextStyle(
                            color: Color(0xff707070),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // edit this to forget password screen , test only
                          Navigator.of(context)
                              .pushNamed(ForgetPasswordScreen.id);
                        },
                        child: Text(
                          translator.translate('Forgot your password ?'),
                          style: TextStyle(
                            color: Color(0xff707070),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      // first divider from the left
//                            Divider(
//                              color: Colors.black,
//                              thickness: 1,
//                              height: 10,
//                              indent: 20,
//                              endIndent: 55,
//                            ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 20, right: 20),
//                         child: Container(
//                           height: 1,
//                           width: 50,
//                           color: Colors.black,
//                         ),
//                       ),
//                       Text(
//                         translator.translate('Or register with your account'),
//                         style: TextStyle(
//                           color: Color(0xff707070),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 14),
//                         child: Container(
//                           height: 1,
//                           width: 50,
//                           color: Colors.black,
//                         ),
//                       ),
//                    second divider
//                      Divider(
//                        color: Colors.black,
//                        thickness: 1,
//                        height: 10,
//                        indent: 20,
//                        endIndent: width-200,
//                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // GestureDetector(
                      //   onTap: _login,
                      //   child: DrawLogo(
                      //     text: 'Facebook',
                      //     logoImagePath: 'assets/images/face_logo.png',
                      //   ),
                      // ),
                      // GestureDetector(
                      //   onTap: () {
                      //     // register with Gmail
                      //   },
                      //   child: DrawLogo(
                      //     text: 'gmail',
                      //     logoImagePath: 'assets/images/gmail_logo.png',
                      //   ),
                      // ),
                      // GestureDetector(
                      //   onTap: () {
                      //     // register with Email
                      //   },
                      //   child: DrawLogo(
                      //     text: 'email',
                      //     logoImagePath: 'assets/images/email_logo.png',
                      //   ),
                      // )
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
              bottom: -150,
              right: -200,
              child: Image.asset(
                'assets/images/bottom-right.png',
                height: 305,
                width: 330,
              )),
          DrawBackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ));
  }
}
