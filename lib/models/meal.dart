
class Meal{
  String restaurantId;
   String name;
   String description;
   String price;
   String category;
   int quantity;
   var mealImage;
   bool onGoing = false;
   bool onCompleted = false;
   String specialRequest ='';

  Meal({
    this.restaurantId,
    this.name,
    this.description,
    this.price,
    this.category,
    this.quantity,
    this.mealImage,
    this.onGoing,
    this.onCompleted,
    this.specialRequest,
  });
}