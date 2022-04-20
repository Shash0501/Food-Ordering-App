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
      // ignore: avoid_function_literals_in_foreach_calls
      await FirebaseFirestore.instance.collection("orders").get().then((value) {
        value.docs.forEach((doc) {
          if (orderIds.contains(doc.id)) {
            orders.add(OrderItemModel.fromJson(doc.data()));
            print(doc.data());
          }
        });
      });
      // orderIds.forEach((orderId) async {
      //   a = await FirebaseFirestore.instance
      //       .collection("orders")
      //       .get()
      //       .then((value) {
      //     value.docs.forEach((doc) {
      //       if (doc.id == orderId) {
      //         print("lknasd");
      //         orders.add(OrderItemModel.fromJson(doc.data()));
      //       }
      //     });
      //     return orders;
      //   });
      // });
      print("Retuening");
      return orders;
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
