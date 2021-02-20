import 'package:flutter/material.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/widgets/user_onCompleted_orders.dart';
import 'package:fooddelivery/widgets/user_onGoing_orders.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class UserOrdersScreen extends StatefulWidget {
  static String id = 'OrdersScreen';

  @override
  _UserOrdersScreenState createState() => _UserOrdersScreenState();
}

class _UserOrdersScreenState extends State<UserOrdersScreen> {
  int tabBarIndex = 1;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: TabBar(
              indicatorColor: Colors.black54,
              onTap: (index) {
                tabBarIndex = index;
              },
              tabs: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Container(
                    child: Text(
                      translator.translate('Completed'),
                      style: TextStyle(fontSize: 18, color: textColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 15,
                  ),
                  child: Container(
                    child: Text(
                      translator.translate('Ongoing'),
                      style: TextStyle(fontSize: 18, color: textColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/images/background.png',
              height: height,
              width: width,
              fit: BoxFit.cover,
            ),
            Positioned(
                bottom: 10,
                right: 20,
                child: Image.asset(
                  'assets/images/fooddelivery2.png',
                  height: 80,
                  width: 80,
                )),
            TabBarView(
              children: [
                UserOnCompletedOrders(),
                UserOngoingOrders(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
