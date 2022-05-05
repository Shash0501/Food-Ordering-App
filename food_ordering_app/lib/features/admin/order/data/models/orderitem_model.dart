import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

import '../../../../customer/home/domain/entities/orderitem.dart';

class OrderItemModel extends OrderItem {
  OrderItemModel({
    required String orderId,
    required String customerId,
    required String restaurantId,
    required Timestamp orderDate,
    required double totalAmount,
    required double? ratingGiven,
    required String status,
    required List<Map<String, dynamic>> order,
    required int pincode,
    required String address,
  }) : super(
          orderId: orderId,
          customerId: customerId,
          restaurantId: restaurantId,
          orderDate: orderDate,
          totalAmount: totalAmount,
          ratingGiven: ratingGiven,
          status: status,
          order: order,
          pincode: pincode,
          address: address,
        );
  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> order = [];
    json['order'].forEach((element) {
      order.add(element);
    });

    Timestamp a = json["orderDate"];
    developer.log(
        '${DateTime.fromMicrosecondsSinceEpoch(a.microsecondsSinceEpoch)}',
        name: 'On orderItemModelCreate');

    return OrderItemModel(
      orderId: json['orderId'],
      customerId: json['customerId'],
      restaurantId: json['restaurantId'],
      orderDate: json['orderDate'],
      totalAmount: json['totalAmount'].toDouble(),
      ratingGiven: json['ratingGiven'].toDouble(),
      status: json['status'],
      order: order,
      pincode: json['pincode'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'customerId': customerId,
      'restaurantId': restaurantId,
      'orderDate': orderDate.toDate().toIso8601String(),
      'totalAmount': totalAmount,
      'ratingGiven': ratingGiven,
      'status': status,
      'order': order,
      'pincode': pincode,
      'address': address,
    };
  }
}
