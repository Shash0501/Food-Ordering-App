import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/features/admin/menu/data/models/menuitem_model.dart';
import 'dart:developer' as developer;
import '../../data/models/orderitem_model.dart';
import '../bloc/order_bloc.dart';

// Widgets
import '../widgets/order_details.dart';
import '../widgets/order_item.dart';
import '../widgets/order_summary.dart';

class SingleOrderPage extends StatefulWidget {
  OrderItemModel orderItem;
  SingleOrderPage({Key? key, required this.orderItem}) : super(key: key);

  @override
  State<SingleOrderPage> createState() => _SingleOrderPageState();
}

class _SingleOrderPageState extends State<SingleOrderPage> {
  @override
  void initState() {
    print("executing initstate");
    List<String> itemIds = [];
    for (var element in widget.orderItem.order) {
      itemIds.add(element["itemId"]);
    }
    BlocProvider.of<OrderBloc>(context).add(LoadItemDetails(
        itemId: itemIds, restaurantId: widget.orderItem.restaurantId));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.orderItem.order);
    return SafeArea(
      child: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is OrderInitial) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              List<String> itemIds = [];
              for (var element in widget.orderItem.order) {
                itemIds.add(element["itemId"]);
              }
              BlocProvider.of<OrderBloc>(context).add(LoadItemDetails(
                  itemId: itemIds,
                  restaurantId: widget.orderItem.restaurantId));
            });
            return const Center(child: CircularProgressIndicator());
          }
          if (state is OrderItemLoaded) {
            developer.log('Printing The Orders', name: 'OrderItemLoaded');
            print(state.order);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.redAccent,
                title: const Text(
                  'Single Order Page',
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        ' Order Summary',
                        style: TextStyle(
                          fontSize: 27,
                          letterSpacing: 1.3,
                        ),
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(
                          widget.orderItem.restaurantId.trim(),
                          style: const TextStyle(
                            fontSize: 20,
                            letterSpacing: 1.5,
                          ),
                        ),
                        subtitle: Text(widget.orderItem.address,
                            style: const TextStyle(
                              color: Colors.grey,
                            )),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 10,
                      ),
                      const Text(
                        'Your Order',
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Divider(
                        color: Colors.grey[300],
                        height: 10,
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.orderItem.order.length,
                          itemBuilder: (context, index) {
                            return OrderItem(
                              // item: widget.orderItem.order[index],
                              item: state.order[index],
                              quantity: widget.orderItem.order[index]
                                  ["quantity"],
                            );
                          }),
                      OrderSummary(
                          orderItems: widget.orderItem.order,
                          itemdetails: state.order),
                      OrderDetails(
                        orderItem: widget.orderItem,
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
