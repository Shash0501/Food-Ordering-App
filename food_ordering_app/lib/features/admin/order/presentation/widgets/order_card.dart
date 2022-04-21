import 'package:flutter/material.dart';

import '../../data/models/orderitem_model.dart';

class OrderCard extends StatefulWidget {
  OrderItemModel order;
  OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(widget.order.totalAmount.toString()),
        ),
        title: Text(widget.order.orderId),
        subtitle: Text(widget.order.orderDate.toString()),
      ),
    );
  }
}
