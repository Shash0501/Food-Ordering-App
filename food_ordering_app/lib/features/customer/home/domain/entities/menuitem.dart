import "package:equatable/equatable.dart";

class MenuItem extends Equatable {
  String itemName;
  String category;
  int price;
  bool isVeg;
  bool isAvailable;
  String description;
  String itemId;
  String restaurantId;
  MenuItem(
      {required this.itemName,
      required this.category,
      required this.price,
      required this.isVeg,
      required this.isAvailable,
      required this.description,
      required this.itemId,
      required this.restaurantId});

  @override
  List<Object> get props => [
        itemName,
        category,
        price,
        isVeg,
        isAvailable,
        description,
        itemId,
        restaurantId
      ];
}
