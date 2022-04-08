import 'dart:convert';

import '../../domain/entities/orderitem.dart';

class OrderItemModel extends OrderItem {
  OrderItemModel({
    required String orderId,
    required String customerId,
    required String restaurantId,
    required DateTime orderDate,
    required int totalAmount,
    required int ratingGiven,
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
    return OrderItemModel(
      orderId: json['orderId'],
      customerId: json['customerId'],
      restaurantId: json['restaurantId'],
      orderDate: DateTime.parse(json['orderDate']),
      totalAmount: json['totalAmount'],
      ratingGiven: json['ratingGiven'],
      status: json['status'],
      order: json['order'],
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
