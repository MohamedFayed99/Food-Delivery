import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/screens/home_screen.dart';
import 'package:fooddelivery/screens/user_login_screen.dart';
import 'package:fooddelivery/screens/vendor_login.dart';
import 'package:fooddelivery/widgets/draw_logo_with_text.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home1 extends StatefulWidget {
  static String id = 'Home1Screen';

  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  String _message = 'Log in/out by pressing the buttons below.';

  bool isLoading = false;
  bool keepMeLoggedIn = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User> loginWithFacebook() async {
    final facebookLogin = FacebookLogin();
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;

    final FacebookLoginResult result = await facebookLogin.logIn(['email']);

    User user;
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
            FacebookAuthProvider.credential(result.accessToken.token);
        user =
            (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        print('signed in ' + user.displayName);
        FirebaseFirestore.instance.collection('users').add({
          'name': user.displayName,
          'email': user.email,
          'phone': user.phoneNumber ?? '',
          'is user': true,
        });
        keepMeLoggedIn = true;
        keepUserLoggedIn();
        print('keep me : $keepMeLoggedIn');
        print('done');

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

    print("Error message : ${result.errorMessage}");

    return user;
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  Future<User> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final authResult = await _auth.signInWithCredential(credential);
    final newUser = authResult.user;
    assert(!newUser.isAnonymous);
    assert(await newUser.getIdToken() != null);
    User currentUser = _auth.currentUser;
    assert(newUser.uid == currentUser.uid);

    print("User Name: ${newUser.displayName}");
    print("User Email ${newUser.email}");

    FirebaseFirestore.instance.collection('users').add({
      'name': newUser.displayName,
      'email': newUser.email,
      'phone': newUser.phoneNumber ?? '',
      'is user': true,
    });
    print('done');
    keepMeLoggedIn = true;
    keepUserLoggedIn();

    return newUser;
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

          // edit this photo
          Positioned(
              top: -150,
              left: -200,
              child: Image.asset(
                'assets/images/top-left.png',
                height: 330,
                width: 330,
              )),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                OutlineButton(
                  onPressed: () {
                    translator.setNewLanguage(
                      context,
                      newLanguage:
                          translator.currentLanguage == 'ar' ? 'en' : 'ar',
                      remember: true,
                      restart: true,
                    );
//                  setState(() {
//                    translator.currentLanguage == 'ar';
//                  });
                  },
                  child: Text((translator.currentLanguage == 'ar')
                      ? 'English'
                      : 'عربى'),
                ),
                Image.asset(
                  'assets/images/fooddelivery.png',
                  height: 180,
                  width: 170,
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 80, right: 80),
                            child: Image.asset(
                              'assets/images/food-on-plate.png',
                              height: 70,
                              width: 70,
                            )),
                        Image.asset(
                          'assets/images/cooker.png',
                          height: 50,
                          width: 50,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 35),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(LoginScreen.id);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: primaryColor),
                              height: height * .055,
                              width: width * .4,
                              child: Center(
                                child: Text(
                                  translator.translate('User'),
                                  style: TextStyle(
                                      color: secondaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(VendorLoginScreen.id);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: primaryColor),
                            height: height * .055,
                            width: width * .4,
                            child: Center(
                              child: Text(
                                translator.translate('Vendor'),
                                style: TextStyle(
                                    color: secondaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          height: 1,
                          width: 50,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          height: 1,
                          width: 50,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 50, top: 5, left: 10, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isLoading = true;
                              });
                              loginWithFacebook().then((result) {
                                if (result != null) {
                                  setState(() {
                                    isLoading = false;
                                  });

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return HomeScreen();
                                      },
                                    ),
                                  );
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            },
                            child: DrawLogo(
                              text: 'Facebook',
                              logoImagePath: 'assets/images/face_logo.png',
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isLoading = true;
                              });
                              signInWithGoogle().then((result) {
                                if (result != null) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return HomeScreen();
                                      },
                                    ),
                                  );
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            },
                            child: DrawLogo(
                              text: 'gmail',
                              logoImagePath: 'assets/images/gmail_logo.png',
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              //edit this to login screen
                              Navigator.of(context).pushNamed(LoginScreen.id);
                            },
                            child: DrawLogo(
                              text: 'email',
                              logoImagePath: 'assets/images/email_logo.png',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // edit this photo
          Positioned(
              bottom: -150,
              right: -200,
              child: Image.asset(
                'assets/images/bottom-right.png',
                height: 320,
                width: 330,
              )),
        ],
      ),
    ));
  }
}
