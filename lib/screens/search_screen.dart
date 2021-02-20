import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/constants.dart';
import 'package:fooddelivery/models/restaurant.dart';
import 'package:fooddelivery/screens/view_restaurant_products.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class SearchScreen extends StatefulWidget {
  static String id = 'SearchScreen';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchValue;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey.shade300,
            toolbarHeight: 200,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Container(
                decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromRGBO(130, 130, 130, 0.31)),
                child: TextField(
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: translator.translate("Search for restaurants"),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: CircleAvatar(
                        child: Icon(
                          Icons.tune,
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.white70,
                      ),
                    ),
                    suffixIcon: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.black,
                        )),
                    hintStyle: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,

                      color: Color.fromRGBO(130, 130, 130, 0.31),

                      // TextAlign.center
                    ),
                  ),
                  maxLines: 1,
                  onChanged: (val) {
                    setState(() {
                      searchValue = val;
                    });
                  },
                ),
              ),
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: (searchValue != "" && searchValue != null)
                ? FirebaseFirestore.instance
                    .collection('vendors')
                    .where("restaurant name", isEqualTo: searchValue)
                    .snapshots()
                : FirebaseFirestore.instance.collection('vendors').snapshots(),
            builder: (context, snapshot) {
              return (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.connectionState == ConnectionState.none)
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot res = snapshot.data.docs[index];
                        Restaurant newRestaurant = Restaurant(
                            managerName: res['manager name'],
                            address: res['address'],
                            deliveryPrice: res['delivery price'],
                            deliveryTime: res['delivery time'],
                            email: res['email'],
                            restaurantId: res['id'],
                            natureOfFood: res['nature of food'],
                            payMethod: res['payment method'],
                            password: res['password'],
                            personImageUrl: res['person image url'],
                            phone: res['phone'],
                            imageUrl: res['restaurant image url'],
                            restaurantName: res['restaurant name'],
                            subscriptionTerm: res['subscription term']);
                        return InkWell(
                          child: Card(
                            child: Row(
                              children: <Widget>[
                                Image.network(
                                  res['restaurant image url'],
                                  width: 150,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  res['restaurant name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                ViewRestaurantProducts.id,
                                arguments: newRestaurant);
                          },
                        );
                      },
                    );
            },
          ),
        ),
        Positioned(
          top: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Container(
                  width: 100,
                  padding: EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      Text(
                        translator.translate('Back'),
                        style: TextStyle(
                          inherit: false,
                          color: primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                width: 30,
              ),
              Image.asset(
                'assets/images/t.png',
                height: 40,
                width: 30,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: Text(
                  translator.translate('Fast food'),
                  style: TextStyle(
                      color: Color(0xffAE0001), fontSize: 20, inherit: false),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            top: 20,
            right: 0,
            child: Image.asset(
              'assets/images/fooddelivery.png',
              width: 70,
              height: 70,
            )),
        Positioned(
            top: 50,
            left: 115,
            child: Material(
              color: Colors.transparent,
              child: Text(
                'fooddelivery',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
            )),
      ],
    );
  }
}
