import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../admin/order/data/models/orderitem_model.dart';
import '../../../../admin/order/presentation/bloc/order_bloc.dart';
import '../pages/single_order_page_customer.dart';

// import '../../data/models/orderitem_model.dart';

class OrderCardC extends StatefulWidget {
  OrderItemModel order;
  List<String> orderIds;
  OrderCardC({Key? key, required this.order, required this.orderIds})
      : super(key: key);

  @override
  State<OrderCardC> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCardC> {
  late CollectionReference orders;
  double totalAmount = 0;
  String? orderStatus;
  late OrderItemModel orderListing;

  @override
  void initState() {
    orders = FirebaseFirestore.instance.collection('orders');
    orderListing = widget.order;
    developer.log(orderListing.toString(), name: 'On Menu Load');
    totalAmount = 365.3;
    orderStatus = orderListing.status;
    super.initState();
  }

  @override
  void dispose() {
    print("runnig dispose");
    BlocProvider.of<OrderBloc>(context)
        .add(LoadOrders(orderIds: widget.orderIds));

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(orderListing.orderDate.toDate());
    Map orderStatusColors = {
      'Pending': Color.fromARGB(255, 97, 97, 97),
      'Accepted': Colors.blueAccent,
      'Declined': Colors.red,
      'Ready': Colors.orange,
      'Delivered': Colors.green
    };

    Map dropDownorderStatusColors = {
      'Pending': Color.fromARGB(255, 97, 97, 97),
      'Accepted': Colors.blueAccent,
      'Ready': Colors.orange,
      'Delivered': Colors.green
    };

    return Card(
        child: ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => SingleOrderPageC(
                        orderItem: orderListing,
                      )));
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
              child: Row(
                children: [
                  Expanded(
                      child:
                          Text('ID: ${orderListing.orderId.substring(0, 8)}')),
                  Text(
                      '${orderListing.orderDate.toDate().toString().substring(0, 19)}')
                ],
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color:
                          dropDownorderStatusColors['${widget.order.status}'],
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        '${widget.order.status}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: orderListing.order.length,
              itemBuilder: (context, index) {
                dynamic orderItem = orderListing.order[index];
                return ListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  title: Text(
                      '${orderItem['quantity']} x ${orderItem['itemName']}',
                      style: TextStyle(letterSpacing: 2)),
                );
              }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Total Bill: ${widget.order.totalAmount}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text((orderStatus != 'Pending'
                    ? 'The order has been $orderStatus'
                    : 'The order is $orderStatus'))),
          )
        ],
      ),
    ));
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Choose Order Status'),
    actions: [
      Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Accepted'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Accepted'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Accepted'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Accepted'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Accepted'),
            ),
          ],
        ),
      ),
    ],
  );
}
