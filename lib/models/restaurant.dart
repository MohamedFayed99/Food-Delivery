import 'package:fooddelivery/models/meal.dart';

class Restaurant {
  String restaurantId;
  String managerName;
  String email;
  String phone;
  String password;
  String restaurantName;
  String address;
  String natureOfFood;
  String deliveryPrice;
  String deliveryTime;
  String imageUrl;
  String personImageUrl;
  List<Meal> meals;
  String subscriptionTerm;
  String payMethod;

  Restaurant({
    this.restaurantId,
    this.managerName,
    this.email,
    this.phone,
    this.password,
    this.restaurantName,
    this.address,
    this.natureOfFood,
    this.deliveryPrice,
    this.deliveryTime,
    this.imageUrl,
    this.personImageUrl,
    this.meals,
    this.subscriptionTerm,
    this.payMethod,
  });
}
