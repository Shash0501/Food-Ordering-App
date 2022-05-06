import 'package:flutter/material.dart';

import '../../../menu/data/models/menuitem_model.dart';

class ExpandedRow extends StatelessWidget {
  final dynamic leftChild;
  final dynamic rightChild;

  const ExpandedRow(
      {Key? key, required this.leftChild, required this.rightChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2.5, 0, 2.5),
      child: Row(
        children: [
          Expanded(child: leftChild),
          rightChild,
        ],
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  final dynamic orderItems;
  final List<MenuItemModel> itemdetails;
  const OrderSummary(
      {Key? key, required this.orderItems, required this.itemdetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalItemPrice = calculateTotal();
    final promoDiscount = 100;
    final tax = 0.18 * totalItemPrice;
    final deliveryCharge = 0.20 * totalItemPrice;

    return Column(
      children: [
        ExpandedRow(
          leftChild: const Text('Item Total', style: TextStyle(fontSize: 15)),
          rightChild: Text('₹$totalItemPrice'),
        ),
        ExpandedRow(
          leftChild: const Text('Promo - (YUMMY)',
              style: TextStyle(fontSize: 15, color: Colors.blue)),
          rightChild: Text(
            'You Saved ₹$promoDiscount',
            style: const TextStyle(color: Colors.blue),
          ),
        ),
        ExpandedRow(
          leftChild: Text('Taxes',
              style: TextStyle(fontSize: 15, color: Colors.grey[500])),
          rightChild: Text('₹$tax', style: TextStyle(color: Colors.grey[500])),
        ),
        ExpandedRow(
          leftChild: Text('Delivery Charge',
              style: TextStyle(fontSize: 15, color: Colors.grey[500])),
          rightChild: Text(
            '₹$deliveryCharge',
            style: TextStyle(color: Colors.grey[500]),
          ),
        ),
        Divider(
          color: Colors.grey[400],
          height: 10,
        ),
        ExpandedRow(
          leftChild: Text('Grand Total', style: TextStyle(fontSize: 20)),
          rightChild: Text(
            '₹${deliveryCharge + tax - promoDiscount + totalItemPrice}',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Divider(
          color: Colors.grey[400],
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 35,
            child: DecoratedBox(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ExpandedRow(
                    leftChild: const Text(
                      "Your total savings",
                      style: TextStyle(color: Colors.blueAccent, fontSize: 15),
                    ),
                    rightChild: Text('₹ ${promoDiscount}',
                        style: const TextStyle(
                            color: Colors.blueAccent, fontSize: 15)),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromARGB(255, 176, 230, 255),
                border: const Border(
                  left: BorderSide(color: Colors.blue),
                  bottom: BorderSide(color: Colors.blue),
                  top: BorderSide(color: Colors.blue),
                  right: BorderSide(color: Colors.blue),
                ),
              ),
            ),
          ),
        ),
        const Divider(
          height: 20,
        )
      ],
    );
  }

  double calculateTotal() {
    double itemTotal = 0;
    for (int i = 0; i < orderItems.length; i++) {
      itemTotal += orderItems[i]["quantity"] * itemdetails[i].price;
    }

    return itemTotal;
  }
}
