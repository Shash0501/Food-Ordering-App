import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ordering_app/core/error/exceptions.dart';
import 'package:food_ordering_app/features/admin/menu/data/models/menuitem_model.dart';

abstract class MenuRemoteDataSource {
  Future<bool> addItem(
      String restaurantId,
      String itemName,
      String category,
      int price,
      bool isVeg,
      bool isAvailable,
      String description,
      String itemId);
  Future<dynamic> getMenu(String restaurantId);
  Future<bool> editItem(
      String restaurantId,
      String itemName,
      String category,
      int price,
      bool isVeg,
      bool isAvailable,
      String description,
      String itemId);
}

class MenuRemoteDataSourceImpl implements MenuRemoteDataSource {
  @override
  Future<bool> addItem(
      String restaurantId,
      String itemName,
      String category,
      int price,
      bool isVeg,
      bool isAvailable,
      String description,
      String itemId) async {
    MenuItemModel menuItemModel = MenuItemModel(
      itemName: itemName,
      category: category,
      price: price,
      isVeg: isVeg,
      isAvailable: isAvailable,
      description: description,
      itemId: itemId,
    );
    Map<String, dynamic> itemJson = (menuItemModel.toJson());
    String isveg = isVeg ? 'Vegetarian' : 'Non-Vegetarian';
    try {
      await FirebaseFirestore.instance
          .collection("restaurants")
          .doc(restaurantId)
          .collection("menu")
          .doc(itemId)
          .set(itemJson);
      print("Item added");
      await FirebaseFirestore.instance
          .collection("restaurants")
          .doc(restaurantId)
          .collection("menu")
          .get()
          .then((value) => {
                (value.docs.forEach((element) {
                  print(element.data());
                }))
              });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future getMenu(String restaurantId) async {
    List<MenuItemModel> menu = [];
    try {
      await FirebaseFirestore.instance
          .collection("restaurants")
          .doc(restaurantId)
          .collection("menu")
          .get()
          .then((value) => {
                (value.docs.forEach((element) {
                  menu.add(MenuItemModel.fromJson(element.data()));
                }))
              });
      return menu;
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<bool> editItem(
      String restaurantId,
      String itemName,
      String category,
      int price,
      bool isVeg,
      bool isAvailable,
      String description,
      String itemId) async {
    MenuItemModel menuItemModel = MenuItemModel(
      itemName: itemName,
      category: category,
      price: price,
      isVeg: isVeg,
      isAvailable: isAvailable,
      description: description,
      itemId: itemId,
    );
    Map<String, dynamic> itemJson = (menuItemModel.toJson());
    String isveg = isVeg ? 'Vegetarian' : 'Non-Vegetarian';
    print(itemId);
    try {
      await FirebaseFirestore.instance
          .collection("restaurants")
          .doc(restaurantId)
          .collection("menu")
          .doc(itemId)
          .set(itemJson);
      print("Item edited");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
