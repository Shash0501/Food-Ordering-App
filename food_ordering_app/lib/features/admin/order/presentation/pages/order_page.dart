import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/features/admin/order/data/models/orderitem_model.dart';
import 'package:googleapis/compute/v1.dart';

import '../bloc/order_bloc.dart';
import '../widgets/order_card.dart';

class OrderPage extends StatefulWidget {
  String restaurantId;
  OrderPage({required this.restaurantId});
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late Stream<QuerySnapshot> stream;

  @override
  void initState() {
    print("Connecting to firebase Stream");
    stream = FirebaseFirestore.instance
        .collection("restaurants")
        .doc(widget.restaurantId)
        .collection("orders")
        .snapshots();
    stream.listen((QuerySnapshot snapshot) {
      List<String> orderIds = snapshot.docs.map((DocumentSnapshot doc) {
        return doc.id.trim();
      }).toList();
      BlocProvider.of<OrderBloc>(context).add(LoadOrders(orderIds: orderIds));
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrdersLoaded) {
          return ListView.builder(
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                return OrderCard(order: state.orders[index]);
              });
        } else if (state is Loading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: Text("No Orders"));
        }
      },
    ));
  }
}
