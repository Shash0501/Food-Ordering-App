import 'package:flutter/material.dart';
import 'package:food_ordering_app/cache/order.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/models/menuitem_model.dart';

class CounterWidget extends StatefulWidget {
  MenuItemModel menuItem;
  CounterWidget({Key? key, required this.menuItem}) : super(key: key);

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  var box = Hive.box<CurrentOrder>("currentOrder");
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MenuItemModel MI = widget.menuItem;
    return Container(
        height: 40,
        width: 110,
        decoration: BoxDecoration(color: Colors.blue),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if (box.get(MI.itemId) != null) {
                    CurrentOrder currentOrder = box.get(MI.itemId)!;
                    if (currentOrder.quantity > 1) {
                      CurrentOrder newCurrentOrder = CurrentOrder(
                          itemId: widget.menuItem.itemId,
                          quantity: currentOrder.quantity - 1,
                          order: {
                            'itemName': widget.menuItem.itemName,
                            'category': MI.category,
                            'price': MI.price,
                            'isVeg': MI.isVeg,
                            'isAvailable': MI.isAvailable,
                            'description': MI.description,
                            'itemId': MI.itemId
                          },
                          category: widget.menuItem.category,
                          price: widget.menuItem.price,
                          isVeg: widget.menuItem.isVeg,
                          isAvailable: widget.menuItem.isAvailable,
                          description: widget.menuItem.description,
                          restaurantId: widget.menuItem.restaurantId,
                          itemName: widget.menuItem.itemName);
                      box.put(MI.itemId, newCurrentOrder);
                    } else {
                      print("deleting item");
                      box.delete(MI.itemId);
                    }
                  }
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: ValueListenableBuilder<Box>(
                  valueListenable: box.listenable(),
                  builder: (buildContext, box, _) {
                    return Text(box.get(MI.itemId)?.quantity.toString() ?? "0");
                  }),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  if (box.get(MI.itemId) == null) {
                    CurrentOrder currentOrder = CurrentOrder(
                        itemId: widget.menuItem.itemId,
                        quantity: 1,
                        order: {
                          'itemName': widget.menuItem.itemName,
                          'category': MI.category,
                          'price': MI.price,
                          'isVeg': MI.isVeg,
                          'isAvailable': MI.isAvailable,
                          'description': MI.description,
                          'itemId': MI.itemId
                        },
                        category: widget.menuItem.category,
                        price: widget.menuItem.price,
                        isVeg: widget.menuItem.isVeg,
                        isAvailable: widget.menuItem.isAvailable,
                        description: widget.menuItem.description,
                        restaurantId: widget.menuItem.restaurantId,
                        itemName: widget.menuItem.itemName);
                    box.put(widget.menuItem.itemId, currentOrder);
                  } else {
                    CurrentOrder currentOrder = box.get(MI.itemId)!;

                    CurrentOrder newCurrentOrder = CurrentOrder(
                        itemId: widget.menuItem.itemId,
                        quantity: currentOrder.quantity + 1,
                        order: {
                          'itemName': widget.menuItem.itemName,
                          'category': MI.category,
                          'price': MI.price,
                          'isVeg': MI.isVeg,
                          'isAvailable': MI.isAvailable,
                          'description': MI.description,
                          'itemId': MI.itemId
                        },
                        category: widget.menuItem.category,
                        price: widget.menuItem.price,
                        isVeg: widget.menuItem.isVeg,
                        isAvailable: widget.menuItem.isAvailable,
                        description: widget.menuItem.description,
                        restaurantId: widget.menuItem.restaurantId,
                        itemName: widget.menuItem.itemName);
                    box.put(MI.itemId, newCurrentOrder);
                  }
                });
              },
            ),
          ],
        ));
  }
}
