import 'package:flutter/material.dart';

import '../../data/models/orderitem_model.dart';

class OrderDetails extends StatelessWidget {
  final OrderItemModel orderItem;

  const OrderDetails({Key? key, required this.orderItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Details',
          style: TextStyle(fontSize: 20),
        ),
        OrderDetailItem(
            parameter: "Order Number", value: orderItem.orderId.toString()),
        const OrderDetailItem(parameter: "Payment", value: "Paid : Using UPI"),
        OrderDetailItem(
            parameter: "Date", value: orderItem.orderDate.toDate().toString())
      ],
    );
  }
}

class OrderDetailItem extends StatelessWidget {
  final String parameter;
  final String value;

  const OrderDetailItem(
      {Key? key, required this.parameter, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            parameter,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          Text(value),
        ],
      ),
    );
  }
}
