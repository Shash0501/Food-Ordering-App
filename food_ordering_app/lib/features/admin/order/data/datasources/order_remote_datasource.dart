import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_ordering_app/core/error/exceptions.dart';
import 'package:food_ordering_app/features/admin/menu/data/models/menuitem_model.dart';

import '../models/orderitem_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderItemModel>> getOrders(List<String> orderIds);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  @override
  Future<List<OrderItemModel>> getOrders(List<String> orderIds) async {
    List<OrderItemModel> orders = [];
    List<OrderItemModel> a = [];
    try {
      for (var element in orderIds) {
        await FirebaseFirestore.instance
            .collection("orders")
            .doc(element)
            .get()
            .then((value) {
          print(value.data());
          orders.add(OrderItemModel.fromJson(value.data()!));
        });
      }
      return orders;
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
