import 'package:flutter/cupertino.dart';
import 'package:fooddelivery/models/restaurant.dart';

class RestaurantItem extends ChangeNotifier {
  List<Restaurant> restaurants = [];

  addRestaurant(Restaurant restaurant) {
    restaurants.add(restaurant);
    notifyListeners();
  }

  Restaurant getRestaurant(String restaurantEmail) {
    return restaurants
        .firstWhere((element) => element.email == restaurantEmail);
  }
}
