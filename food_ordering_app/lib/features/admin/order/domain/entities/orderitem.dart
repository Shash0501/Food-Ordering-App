import "package:equatable/equatable.dart";

class OrderItem extends Equatable {
  String orderId;
  String customerId;
  String restaurantId;
  DateTime orderDate;
  int totalAmount;
  double? ratingGiven;
  String status;
  List<Map<String, dynamic>> order;

  OrderItem(
      {required this.orderId,
      required this.customerId,
      required this.restaurantId,
      required this.orderDate,
      required this.totalAmount,
      required this.ratingGiven,
      required this.status,
      required this.order});

  @override
  List<Object> get props => [
        orderId,
        customerId,
        restaurantId,
        orderDate,
        totalAmount,
        status,
        order
      ];
}
