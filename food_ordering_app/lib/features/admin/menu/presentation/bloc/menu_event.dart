part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class AddItem extends MenuEvent {
  final String itemName;
  final String category;
  final int price;
  final bool isVeg;
  final bool isAvailable;
  final String restaurantId;

  AddItem(
      {required this.itemName,
      required this.category,
      required this.price,
      required this.isVeg,
      required this.isAvailable,
      required this.restaurantId});

  @override
  List<Object> get props =>
      [itemName, category, price, isVeg, isAvailable, restaurantId];
}
