import 'package:flutter/material.dart';
import 'package:food_ordering_app/cache/order.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/models/menuitem_model.dart';
import '../widgets/counter.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var box = Hive.box<CurrentOrder>("currentOrder");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<CurrentOrder>("currentOrder").listenable(),
          builder: (buildContext, box_, b) {
            print("hello");
            return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  CurrentOrder currentOrder = box.getAt(index)!;
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
