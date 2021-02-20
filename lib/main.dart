import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/providers/cart_item.dart';
import 'package:fooddelivery/providers/restaurant_item.dart';
import 'package:fooddelivery/providers/user_item.dart';
import 'package:fooddelivery/screens/add_product.dart';
import 'package:fooddelivery/screens/add_restaurant.dart';
import 'package:fooddelivery/screens/add_restaurant2.dart';
import 'package:fooddelivery/screens/change_account_data_screen.dart';
import 'package:fooddelivery/screens/current_address_screen.dart';
import 'package:fooddelivery/screens/forget_password_screen.dart';
import 'package:fooddelivery/screens/geolocation.dart';
import 'package:fooddelivery/screens/home1.dart';
import 'package:fooddelivery/screens/home_screen.dart';
import 'package:fooddelivery/screens/location_screen.dart';
import 'package:fooddelivery/screens/map.dart';
import 'package:fooddelivery/screens/product_info_screen.dart';
import 'package:fooddelivery/screens/search_screen.dart';
import 'package:fooddelivery/screens/searching.dart';
import 'package:fooddelivery/screens/splash_screen.dart';
import 'package:fooddelivery/screens/user_login_screen.dart';
import 'package:fooddelivery/screens/user_order_confirmation_screen.dart';
import 'package:fooddelivery/screens/user_order_details_screen.dart';
import 'package:fooddelivery/screens/user_order_progress_screen.dart';
import 'package:fooddelivery/screens/user_orders_screen.dart';
import 'package:fooddelivery/screens/user_signup_screen.dart';
import 'package:fooddelivery/screens/vendor_info_screen.dart';
import 'package:fooddelivery/screens/vendor_login.dart';
import 'package:fooddelivery/screens/vendor_order_details_screen.dart';
import 'package:fooddelivery/screens/vendor_orders_screen.dart';
import 'package:fooddelivery/screens/vendor_profile_screen.dart';
import 'package:fooddelivery/screens/vendor_signup_screen.dart';
import 'package:fooddelivery/screens/view_restaurant_info.dart';
import 'package:fooddelivery/screens/view_restaurant_information2.dart';
import 'package:fooddelivery/screens/view_restaurant_products.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await translator.init(
    localeDefault: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/locale',
    apiKeyGoogle: '<Key>', // NOT YET TESTED
  );
  await Firebase.initializeApp();
  runApp(LocalizedApp(child: MyApp()));
}

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            isUserLoggedIn = snapshot.data.getBool('KeepMeLoggedIn') ?? false;

            return MultiProvider(
              providers: [
                ChangeNotifierProvider<CartItem>(
                  create: (context) => CartItem(),
                ),
                ChangeNotifierProvider<RestaurantItem>(
                  create: (context) => RestaurantItem(),
                ),
                ChangeNotifierProvider<UserItem>(
                  create: (context) => UserItem(),
                ),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: translator.delegates,
                locale: translator.locale,
                supportedLocales: translator.locals(),
                initialRoute: isUserLoggedIn ? HomeScreen.id : Home1.id,
                routes: {
                  SplashScreen.id: (context) => SplashScreen(),
                  Home1.id: (context) => Home1(),
                  LoginScreen.id: (context) => LoginScreen(),
                  VendorLoginScreen.id: (context) => VendorLoginScreen(),
                  SignUpScreen.id: (context) => SignUpScreen(),
                  ForgetPasswordScreen.id: (context) => ForgetPasswordScreen(),
                  HomeScreen.id: (context) => HomeScreen(),
                  VendorSignUpScreen.id: (context) => VendorSignUpScreen(),
                  HomeProfileScreen.id: (context) => HomeProfileScreen(),
                  UserOrdersScreen.id: (context) => UserOrdersScreen(),
                  UserOrderProgressScreen.id: (context) =>
                      UserOrderProgressScreen(),
                  AddRestaurantScreen.id: (context) => AddRestaurantScreen(),
                  AddRestaurant2.id: (context) => AddRestaurant2(),
                  ViewRestaurantInformation.id: (context) =>
                      ViewRestaurantInformation(),
                  AddProduct.id: (context) => AddProduct(),
                  ViewRestaurantProducts.id: (context) =>
                      ViewRestaurantProducts(),
                  SearchScreen.id: (context) => SearchScreen(),
                  ProductInfoScreen.id: (context) => ProductInfoScreen(),
                  UserOrderConfirmationScreen.id: (context) =>
                      UserOrderConfirmationScreen(),
                  VendorInfoScreen.id: (context) => VendorInfoScreen(),
                  ViewRestaurantInformation2.id: (context) =>
                      ViewRestaurantInformation2(),
                  CloudFirestoreSearch.id: (context) => CloudFirestoreSearch(),
                  CurrentAddressScreen.id: (context) => CurrentAddressScreen(),
                  ChangeAccountDataScreen.id: (context) =>
                      ChangeAccountDataScreen(),
                  VendorOrdersScreen.id: (context) => VendorOrdersScreen(),
                  VendorOrderDetailsScreen.id: (context) =>
                      VendorOrderDetailsScreen(),
                  UserOrderDetailsScreen.id: (context) =>
                      UserOrderDetailsScreen(),
                  LocationScreen.id: (context) => LocationScreen(),
                  Map.id: (context) => Map(),
                  Geo.id: (context) => Geo(),
                },
              ),
            );
          }
        });
  }
}
