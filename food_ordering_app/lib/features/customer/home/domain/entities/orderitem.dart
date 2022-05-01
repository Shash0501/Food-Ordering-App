import 'package:cloud_firestore/cloud_firestore.dart';
import "package:equatable/equatable.dart";

class OrderItem extends Equatable {
  String orderId;
  String customerId;
  String restaurantId;
  Timestamp orderDate;
  double totalAmount;
  double? ratingGiven;
  String status;
  List<Map<String, dynamic>> order;
  int pincode;
  String address;

  OrderItem(
      {required this.orderId,
      required this.customerId,
      required this.restaurantId,
      required this.orderDate,
      required this.totalAmount,
      required this.ratingGiven,
      required this.status,
      required this.order,
      required this.pincode,
      required this.address});

  @override
  List<Object> get props => [
        orderId,
        customerId,
        restaurantId,
        orderDate,
        totalAmount,
        status,
        order,
        pincode,
        address
      ];
}
