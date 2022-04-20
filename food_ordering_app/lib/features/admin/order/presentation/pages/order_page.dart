import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/features/admin/order/data/models/orderitem_model.dart';
import 'package:googleapis/compute/v1.dart';

import '../bloc/order_bloc.dart';

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
    stream = FirebaseFirestore.instance
        .collection("restaurants")
        .doc(widget.restaurantId)
        .collection("orders")
        .snapshots();
    stream.listen((QuerySnapshot snapshot) {
      List<String> orderIds = snapshot.docs.map((DocumentSnapshot doc) {
        return doc.id;
      }).toList();
      print(orderIds);
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
    return Scaffold(
        appBar: AppBar(title: Text("Orders")),
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrdersLoaded) {
              print(state.orders.length);
              return ListView.builder(
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    print(state.orders[index]);
                    return ListTile(
                      title: Text(state.orders[index].orderId),
                      subtitle: Text(state.orders[index].status),
                      onTap: () {},
                    );
                  });
            }
            return Container();
          },
        ));
  }
}
