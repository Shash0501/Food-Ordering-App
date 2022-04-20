import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/orderitem.dart';

class OrderItemModel extends OrderItem {
  OrderItemModel({
    required String orderId,
    required String customerId,
    required String restaurantId,
    required DateTime orderDate,
    required int totalAmount,
    required double? ratingGiven,
    required String status,
    required List<Map<String, dynamic>> order,
  }) : super(
          orderId: orderId,
          customerId: customerId,
          restaurantId: restaurantId,
          orderDate: orderDate,
          totalAmount: totalAmount,
          ratingGiven: ratingGiven,
          status: status,
          order: order,
        );
  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    print(json['order']);
    print(json['order'].runtimeType);
    List<Map<String, dynamic>> order = [];
    json['order'].forEach((element) {
      order.add(element);
    });

    Timestamp a = json["orderDate"];

    return OrderItemModel(
      orderId: json['orderId'],
      customerId: json['customerId'],
      restaurantId: json['restaurantId'],
      orderDate: DateTime.fromMicrosecondsSinceEpoch(a.microsecondsSinceEpoch),
      totalAmount: json['totalAmount'],
      ratingGiven: json['ratingGiven'],
      status: json['status'],
      order: order,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'customerId': customerId,
      'restaurantId': restaurantId,
      'orderDate': orderDate.toIso8601String(),
      'totalAmount': totalAmount,
      'ratingGiven': ratingGiven,
      'status': status,
      'order': order,
    };
  }
}
