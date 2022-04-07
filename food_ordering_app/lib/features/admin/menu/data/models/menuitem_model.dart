import 'dart:convert';

import '../../domain/entities/menuitem.dart';

class MenuItemModel extends MenuItem {
  MenuItemModel({
    required String itemName,
    required String category,
    required int price,
    required bool isVeg,
    required bool isAvailable,
    required String description,
    required String itemId,
  }) : super(
          itemName: itemName,
          category: category,
          price: price,
          isVeg: isVeg,
          isAvailable: isAvailable,
          description: description,
          itemId: itemId,
        );

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      itemName: json['itemName'],
      category: json['category'],
      price: json['price'],
      isVeg: json['isVeg'],
      isAvailable: json['isAvailable'],
      description: json['description'],
      itemId: json['itemId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'category': category,
      'price': price,
      'isVeg': isVeg,
      'isAvailable': isAvailable,
      'description': description,
      'itemId': itemId,
    };
  }
}
