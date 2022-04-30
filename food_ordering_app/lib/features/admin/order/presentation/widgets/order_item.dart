import 'package:flutter/material.dart';

import '../../../menu/data/models/menuitem_model.dart';

class OrderItem extends StatelessWidget {
  final MenuItemModel item;
  final int quantity;
  OrderItem({Key? key, required this.item, required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Row(
        children: [
          Image.network(
            'https://www.pikpng.com/pngl/m/210-2108039_veg-logo-png-veg-symbol-clipart.png',
            width: 20,
            height: 20,
          ),
          const SizedBox(
            width: 25,
          ),
          Text(
            item.itemName,
            style: const TextStyle(
              wordSpacing: 3,
              letterSpacing: 1.5,
              fontSize: 15,
            ),
          )
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO chaneg this
          Text("Quantity: ${quantity}"),
          const SizedBox(
            height: 5,
          ),
          Row(children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 23,
                    height: 23,
                    child: DecoratedBox(
                      child: Center(child: Text("${quantity}")),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromARGB(255, 175, 216, 176),
                        border: const Border(
                          left: BorderSide(color: Colors.green),
                          bottom: BorderSide(color: Colors.green),
                          top: BorderSide(color: Colors.green),
                          right: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    " X ₹${item.price}",
                    style: const TextStyle(
                      letterSpacing: 2,
                      wordSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            Text('₹${quantity * item.price}')
          ]),
          const Divider(
            color: Colors.grey,
            height: 10,
          ),
        ],
      ),
    );
  }
}
