import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/features/admin/order/presentation/pages/order_page.dart';
import 'package:food_ordering_app/features/customer/home/presentation/pages/order_history_page.dart';

import '../../data/models/orderitem_model.dart';
import '../pages/single_order_page.dart';

class OrderCard extends StatefulWidget {
  String restaurantId;
  OrderItemModel order;
  OrderCard({Key? key, required this.order, required this.restaurantId})
      : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
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
  Widget build(BuildContext context) {
    Map orderStatusColors = {
      'Pending': Color.fromARGB(255, 97, 97, 97),
      'Accepted': Colors.blueAccent,
      'Declined': Colors.red,
      'Ready': Colors.orange,
      'Delivered': Colors.green
    };

    Map dropDownorderStatusColors = {
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
                  builder: (context) => SingleOrderPage(
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
                      '${orderListing.orderDate.toDate().toString().substring(0, 16)}'),
                ],
              ),
            ),
          ),
          Row(
            children: [
              if (orderStatus != 'Declined' && orderStatus != 'Pending')
                DropdownButton<String>(
                  value: orderStatus,
                  onChanged: (String? newValue) {
                    setState(() {
                      print(orderStatus);
                      orderStatus = newValue!;
                      print(orderStatus);

                      FirebaseFirestore.instance
                          .collection('orders')
                          .doc(widget.order.orderId)
                          .update({'status': newValue});

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderPage(
                                    restaurantId: widget.restaurantId,
                                  )));
                    });
                  },
                  items: dropDownorderStatusColors.keys
                      .toList()
                      .sublist(dropDownorderStatusColors.keys
                          .toList()
                          .indexOf(orderStatus))
                      .map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: SizedBox(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: dropDownorderStatusColors['${value}'],
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                              child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text(
                                  '${value}',
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
                        ));
                  }).toList(),
                )
              else
                SizedBox(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: orderStatusColors['${orderStatus}'],
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          '${orderStatus}',
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
              // SizedBox(
              //   child: DecoratedBox(
              //     decoration: BoxDecoration(
              //         color: orderStatusColors['${orderStatus}'],
              //         borderRadius: BorderRadius.circular(5)),
              //     child: Padding(
              //       padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
              //       child: Padding(
              //         padding: EdgeInsets.all(2.0),
              //         child: Text(
              //           '${orderStatus}',
              //           style: TextStyle(
              //             fontSize: 15,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.white,
              //             letterSpacing: 1.5,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
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
              'Total Bill: ${1.38 * widget.order.totalAmount}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 20,
              ),
            ),
          ),
          if (orderStatus == 'Pending')
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: () {
                    orders
                        .doc(orderListing.orderId)
                        .update({'status': 'Accepted'})
                        .then((value) => print("Yay"))
                        .catchError((e) => print(e));

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderPage(
                                  restaurantId: widget.restaurantId,
                                )));
                  },
                  child: Text('ACCEPT', style: TextStyle(letterSpacing: 1.5)),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {},
                  child: Text('DECLINE', style: TextStyle(letterSpacing: 1.5)),
                )
              ],
            )
          else
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
