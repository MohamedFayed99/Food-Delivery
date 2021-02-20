
class Order{
  String orderId;
  String restaurantId;
  String mealName;
  String mealImage;
  String specialRequest;
  int quantity;
  double totalPrice = 00.00;
  String userName;
  String userPhone;
  String userAddress;
  var time;
  bool onGoing = true;
  bool onCompleted = false;

  Order({
    this.orderId, 
    this.restaurantId,
    this.mealName,
    this.mealImage,
    this.specialRequest,
    this.quantity,
    this.totalPrice,
    this.userName,
    this.userPhone,
    this.userAddress,
    this.time,
    this.onGoing,
    this.onCompleted,

  });
}