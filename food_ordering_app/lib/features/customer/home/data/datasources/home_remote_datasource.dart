import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_ordering_app/core/error/exceptions.dart';
import 'package:food_ordering_app/features/admin/menu/data/models/menuitem_model.dart';

import '../../../../../cache/restaurantIds.dart';
import '../models/orderitem_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<MenuItemModel>> getOrdersR(String restaurantId);
  Future<List<MenuItemModel>> getOrdersC(String category);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<MenuItemModel>> getOrdersR(String restaurantId) async {
    List<MenuItemModel> orders = [];
    try {
      await FirebaseFirestore.instance
          .collection("restaurants")
          .doc(restaurantId)
          .collection("menu")
          .get()
          .then((value) {
        print(value.docs.length);
        value.docs.forEach((element) {
          orders.add(MenuItemModel.fromJson(element.data()));
        });
      });
      return orders;
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<List<MenuItemModel>> getOrdersC(String category) async {
    List<MenuItemModel> orders = [];

    List<String> restaurantIds = getRestaurantIds();
    try {
      for (var element in restaurantIds) {
        await FirebaseFirestore.instance
            .collection("restaurants")
            .doc(element)
            .collection("menu")
            .get()
            .then((value) {
          value.docs.forEach((element1) {
            if (element1.data().isNotEmpty &&
                element1.data()["category"] == category) {
              print(1);
              orders.add(MenuItemModel.fromJson(element1.data()));
            }
          });
        });
      }
      return orders;
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
