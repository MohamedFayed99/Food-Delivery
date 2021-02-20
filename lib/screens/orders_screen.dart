import 'package:flutter/material.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/widgets/onCompleted_orders.dart';
import 'package:fooddelivery/widgets/onGoing_orders.dart';

class OrdersScreen extends StatefulWidget {
  static String id = 'OrdersScreen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
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
                      'Completed',
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
                      'Ongoing',
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
                OnCompletedOrders(),
                OngoingOrders(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
