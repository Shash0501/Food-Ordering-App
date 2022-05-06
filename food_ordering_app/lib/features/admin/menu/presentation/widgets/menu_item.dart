import 'package:flutter/material.dart';
import 'package:food_ordering_app/features/admin/menu/presentation/pages/edit_item_page.dart';
import 'dart:math';

class MenuItemCard extends StatefulWidget {
  final String restaurantId;
  final String itemId;
  final String itemName;
  final String category;
  final int price;
  final bool isVeg;
  final bool isAvailable;
  final String description;
  MenuItemCard(
      {required this.restaurantId,
      required this.itemId,
      required this.itemName,
      required this.category,
      required this.price,
      required this.isVeg,
      required this.isAvailable,
      required this.description});

  @override
  State<MenuItemCard> createState() => _MenuItemCardState();
}

class _MenuItemCardState extends State<MenuItemCard> {
  get url => null;

  @override
  Widget build(BuildContext context) {
    Random r = Random();
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                width: 110,
                height: 110,
                child: Image.network((url[r.nextInt(url.length)])),
              ),
            ],
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.only(top: 10, left: 8, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.itemName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                // TODO add description
                Text(
                  widget.description,
                  style: TextStyle(color: Colors.black, height: 1.5),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Text(
                      "\₹",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      widget.price.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditItemPage(
                              restaurantId: widget.restaurantId,
                              itemId: widget.itemId,
                              itemName: widget.itemName,
                              itemPrice: widget.price,
                              itemCategory: widget.category,
                              isVeg: widget.isVeg,
                              isAvailable: widget.isAvailable,
                              description: widget.description,
                            )));
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
