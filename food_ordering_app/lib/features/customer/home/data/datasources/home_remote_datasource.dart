import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ordering_app/core/error/exceptions.dart';

import '../../../../../cache/restaurantIds.dart';
import '../../domain/entities/orderitem.dart';
import '../models/menuitem_model.dart';
import '../models/orderitem_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<MenuItemModel>> getMenuR(String restaurantId);
  Future<List<MenuItemModel>> getMenu(String category);
  Future<bool> placeOrder(OrderItemModel order);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<MenuItemModel>> getMenuR(String restaurantId) async {
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
          orders.add(MenuItemModel.fromJson(element.data(), restaurantId));
        });
      });
      return orders;
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<List<MenuItemModel>> getMenu(String category) async {
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
            // ?? Here I have omitted the condition for category
            // ?? This will return all the items of all the restaurants
            if (element1.data().isNotEmpty) {
              orders.add(MenuItemModel.fromJson(element1.data(), element));
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

  @override
  Future<bool> placeOrder(OrderItemModel order) async {
    try {
      // Setting data in the collection order
      FirebaseFirestore.instance
          .collection("orders")
          .doc(order.orderId)
          .set(order.toJson());

      String email = FirebaseAuth.instance.currentUser!.email!;
      // Setting data in the collection restaurant
      FirebaseFirestore.instance
          .collection("restaurants")
          .doc(order.restaurantId)
          .collection("orders")
          .doc(order.orderId)
          .set({});

      // Setting data in the collection customer
      FirebaseFirestore.instance
          .collection("customer")
          .doc(email)
          .collection("orders")
          .doc(order.orderId)
          .set({});
      print("Order was succefull");
      return true;
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
