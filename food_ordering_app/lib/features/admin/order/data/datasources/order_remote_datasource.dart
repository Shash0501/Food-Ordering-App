import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_ordering_app/core/error/exceptions.dart';
import 'package:food_ordering_app/features/admin/menu/data/models/menuitem_model.dart';

import '../models/orderitem_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderItemModel>> getOrders(List<String> orderIds);
  Future<List<MenuItemModel>> getItemDetails(
      List<String> itemIds, String restaurantId);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  @override
  Future<List<OrderItemModel>> getOrders(List<String> orderIds) async {
    List<OrderItemModel> orders = [];
    try {
      for (var element in orderIds) {
        await FirebaseFirestore.instance
            .collection("orders")
            .doc(element)
            .get()
            .then((value) {
          orders.add(OrderItemModel.fromJson(value.data()!));
        });
      }
      return orders;
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<List<MenuItemModel>> getItemDetails(
      List<String> itemIds, String restaurantId) async {
    List<MenuItemModel> orderItem = [];
    try {
      for (var element in itemIds) {
        await FirebaseFirestore.instance
            .collection("restaurants")
            .doc(restaurantId)
            .collection("menu")
            .doc(element)
            .get()
            .then((value) {
          print("item details");
          print(value.data());
          orderItem.add(MenuItemModel.fromJson(value.data()!));
        });
      }
      return orderItem;
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
