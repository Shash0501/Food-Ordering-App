import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/orderitem_model.dart';
import '../bloc/order_bloc.dart';

class SingleOrderPage extends StatefulWidget {
  OrderItemModel orderItem;
  SingleOrderPage({Key? key, required this.orderItem}) : super(key: key);

  @override
  State<SingleOrderPage> createState() => _SingleOrderPageState();
}

class _SingleOrderPageState extends State<SingleOrderPage> {
  @override
  void initState() {
    List<String> itemIds = [];
    for (var element in widget.orderItem.order) {
      itemIds.add(element["itemId"]);
    }
    BlocProvider.of<OrderBloc>(context).add(LoadItemDetails(
        itemId: itemIds, restaurantId: widget.orderItem.restaurantId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is OrderInitial) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is OrderItemLoaded) {
          print("Printing the orders");
          print(state.order);
          return Scaffold(
              appBar: AppBar(
                title: Text("Order Details"),
              ),
              body: CircularProgressIndicator());
        }
        return Scaffold(
            appBar: AppBar(
              title: const Text('Single Order Page'),
            ),
            body: Column(
              children: [
                Text('Order ID: ${widget.orderItem.orderId}'),
                Text('Customer ID: ${widget.orderItem.customerId}'),
                Text('Restaurant ID: ${widget.orderItem.restaurantId}'),
                Text('Order Date: ${widget.orderItem.orderDate.day} '),
                Text('Total Amount: ${widget.orderItem.totalAmount}'),
                Text('Rating Given: ${widget.orderItem.ratingGiven}'),
                Text('Status: ${widget.orderItem.status}'),
                Text('Address: ${widget.orderItem.address} '),
                Text('Order: ${widget.orderItem.order}'),
              ],
            ));
      },
    );
  }
}
