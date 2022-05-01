import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/cache/order.dart';
// import 'package:food_ordering_app/features/admin/order/data/models/orderitem_model.dart';
import 'package:food_ordering_app/features/customer/home/presentation/bloc/homepage_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/menuitem_model.dart';
import '../../data/models/orderitem_model.dart';
import '../widgets/counter.dart';
import "package:uuid/uuid.dart";

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // var box = Hive.box<CurrentOrder>("currentOrder");
  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.airplane_ticket),
            onPressed: () {
              var box = Hive.box<CurrentOrder>("currentOrder");
              List<dynamic> itemIds =
                  Hive.box<CurrentOrder>("currentOrder").keys.toList();
              String restaurantId = box.get(itemIds[0])!.restaurantId;

              OrderItemModel order = OrderItemModel(
                  orderId: uuid.v1(),
                  customerId:
                      FirebaseAuth.instance.currentUser!.email.toString(),
                  restaurantId: restaurantId,
                  orderDate: DateTime.now(),
                  totalAmount: totalAmount(),
                  ratingGiven: 0,
                  status: "Pending",
                  order: getOrderList(),
                  pincode: 314122,
                  address: "asdasdasd asdvhv a jsvdj hasdjb");

              BlocProvider.of<HomepageBloc>(context)
                  .add(PlaceOrderEvent(order: order));
              box.clear();
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<Box>(
          valueListenable: Hive.box<CurrentOrder>("currentOrder").listenable(),
          builder: (buildContext, box, _) {
            List<dynamic> itemIds =
                Hive.box<CurrentOrder>("currentOrder").keys.toList();
            print(box.length);
            return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  CurrentOrder currentOrder = box.get(itemIds[index])!;
                  MenuItemModel m = MenuItemModel(
                      category: currentOrder.category,
                      itemName: currentOrder.itemName,
                      price: currentOrder.price,
                      description: currentOrder.description,
                      isAvailable: currentOrder.isAvailable,
                      isVeg: currentOrder.isVeg,
                      itemId: currentOrder.itemId,
                      restaurantId: currentOrder.restaurantId);
                  return Card(
                    child: ListTile(
                      tileColor: Colors.amber,
                      title: Text(currentOrder.itemName),
                      subtitle: Text(currentOrder.restaurantId.substring(0, 4)),
                      trailing: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                        child: CounterWidget(
                          menuItem: m,
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}

List<Map<String, dynamic>> getOrderList() {
  List<Map<String, dynamic>> orderList = [];
  List<dynamic> itemIds = Hive.box<CurrentOrder>("currentOrder").keys.toList();
  for (int i = 0; i < itemIds.length; i++) {
    CurrentOrder currentOrder =
        Hive.box<CurrentOrder>("currentOrder").get(itemIds[i])!;
    Map<String, dynamic> order = {
      "itemId": currentOrder.itemId,
      "itemName": currentOrder.itemName,
      'description': currentOrder.description,
      "price": currentOrder.price,
      "quantity": currentOrder.quantity,
      "restaurantId": currentOrder.restaurantId,
      "category": currentOrder.category,
    };
    orderList.add(order);
  }
  return orderList;
}

double totalAmount() {
  double total = 0;
  List<dynamic> itemIds = Hive.box<CurrentOrder>("currentOrder").keys.toList();
  for (int i = 0; i < itemIds.length; i++) {
    CurrentOrder currentOrder =
        Hive.box<CurrentOrder>("currentOrder").get(itemIds[i])!;
    total = total + currentOrder.price * currentOrder.quantity;
  }
  return total;
}
