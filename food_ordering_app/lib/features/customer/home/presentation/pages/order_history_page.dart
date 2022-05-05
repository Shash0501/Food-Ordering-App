import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/features/customer/home/presentation/widgets/ordercard_customer.dart';

import '../../../../admin/order/presentation/bloc/order_bloc.dart';

class OrderHistoryPage extends StatefulWidget {
  String userId;
  OrderHistoryPage({required this.userId});
  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  late Stream<QuerySnapshot> stream;
  List<String> orderIds = [];
  @override
  void initState() {
    print("called the initstate");
    stream = FirebaseFirestore.instance
        .collection("customer")
        .doc(widget.userId)
        .collection("orders")
        .snapshots();
    stream.listen((QuerySnapshot snapshot) {
      List<String> LorderIds = snapshot.docs.map((DocumentSnapshot doc) {
        return doc.id.trim();
      }).toList();

      print(orderIds);
      if (mounted) {
        BlocProvider.of<OrderBloc>(context)
            .add(LoadOrders(orderIds: LorderIds));
      }
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
        appBar: AppBar(
          title: Text("Order History"),
        ),
        body: BlocConsumer<OrderBloc, OrderState>(
          listener: (context, state) {},
          builder: (context, state) {
            print(state);

            if (state is Loading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is OrdersLoaded) {
              print(state.orders.length);
              return ListView.builder(
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    print(index);
                    return OrderCardC(
                      order: state.orders[index],
                      orderIds: orderIds,
                    );
                  });
            } else {
              // WidgetsBinding.instance!.addPostFrameCallback((_) {
              //   BlocProvider.of<OrderBloc>(context)
              //       .add(LoadOrders(orderIds: orderIds));
              // });
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
