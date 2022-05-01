import 'dart:math';

import 'package:flutter/material.dart';

import '../../data/models/menuitem_model.dart';
import '../widgets/counter.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({Key? key}) : super(key: key);

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Red Rock',
                              style: TextStyle(
                                fontSize: 20,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Burger, Fastfood, Apples',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, right: 30),
                              child: Text(
                                'T5 901 Rps Savana Omegle High street nitk surthkal in sex in the beach',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 40,
                            width: 65,
                            child: DecoratedBox(
                              child: Center(
                                child: Text(
                                  '3.4★',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                                color: Colors.green[600],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: 65,
                            child: DecoratedBox(
                              child: Center(
                                child: Text(
                                  '3405 Ratings',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 9,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 10,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Recommended',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return CustomisableMenuItem(
                      menuItem: MenuItemModel(
                          category: 'Dessert',
                          isAvailable: true,
                          itemId: "21343",
                          itemName: "Ice Cream",
                          description:
                              "A dessert that will make your ass go wooo when you eat it ",
                          isVeg: true,
                          price: 300,
                          restaurantId: "hksdhfg"),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomisableMenuItem extends StatefulWidget {
  MenuItemModel menuItem;

  CustomisableMenuItem({Key? key, required this.menuItem}) : super(key: key);

  @override
  State<CustomisableMenuItem> createState() => _CustomisableMenuItemState();
}

class _CustomisableMenuItemState extends State<CustomisableMenuItem> {
  String itemName = '';
  String itemCategory = '';
  var price;
  var rating;
  var isVeg;
  final String nonVegImgPath =
      'https://www.vhv.rs/dpng/d/437-4370761_non-veg-icon-non-veg-logo-png-transparent.png';
  final String vegImgPath =
      'https://www.pikpng.com/pngl/m/210-2108039_veg-logo-png-veg-symbol-clipart.png';
  @override
  void initState() {
    itemName = widget.menuItem.itemName;
    itemCategory = widget.menuItem.category;
    price = widget.menuItem.price;
    isVeg = widget.menuItem.isVeg;
    rating = Random().nextInt(10) / 10;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  isVeg ? vegImgPath : nonVegImgPath,
                  height: 20,
                  width: 20,
                ),
                Text(
                  '${itemName}',
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "$itemCategory",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "₹ $price",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 115,
                  child: Image.network(
                      'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YnVyZ2VyfGVufDB8fDB8fA%3D%3D&w=1000&q=80'),
                )),
          )
        ],
      ),
      subtitle: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.menuItem.description,
                    )
                  ],
                ),
              ),
              CounterWidget(menuItem: widget.menuItem)
            ],
          ),
          Divider(
            color: Colors.grey,
            height: 10,
          ),
        ],
      ),
    );
  }
}
