import 'package:flutter/cupertino.dart';
import 'package:fooddelivery/models/meal.dart';

class CartItem extends ChangeNotifier {
  List<Meal> meals = [];

  addProduct(Meal meal) {
    meals.add(meal);
    notifyListeners();
  }

  deleteProduct(Meal meal) {
    meals.remove(meal);
    notifyListeners();
  }
}
