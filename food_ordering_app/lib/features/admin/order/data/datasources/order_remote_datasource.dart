import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_ordering_app/core/error/exceptions.dart';

import '../models/orderitem_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderItemModel>> getOrders(List<String> orderIds);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  @override
  Future<List<OrderItemModel>> getOrders(List<String> orderIds) async {
    try {
      List<OrderItemModel> orders = [];
      // ignore: avoid_function_literals_in_foreach_calls
      orderIds.forEach((orderId) async {
        await FirebaseFirestore.instance
            .collection("orders")
            .doc(orderId)
            .get()
            .then((value) {
          orders.add(OrderItemModel.fromJson(value.data()!));
        });
        print(orderId);
      });
      return orders;
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
