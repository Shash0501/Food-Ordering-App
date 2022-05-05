import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/features/admin/profile/data/models/profile_model.dart';
import 'package:food_ordering_app/features/customer/home/presentation/pages/order_history_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../cache/order.dart';
import '../../../../../core/config/constants.dart';
import '../../data/models/menuitem_model.dart';
import '../bloc/homepage_bloc.dart';
import '../widgets/counter.dart';
import 'cart_page.dart';

class CreateOrderPage extends StatefulWidget {
  RestaurantProfileModel restaurantProfile;
  CreateOrderPage({Key? key, required this.restaurantProfile})
      : super(key: key);

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  ValueNotifier selectedC = ValueNotifier(0);
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<HomepageBloc>(context)
        .add(RestaurantMenu(widget.restaurantProfile.restaurantId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          child: Column(
            // crossAxisSize: CrossAxisSize.min,
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
                              widget.restaurantProfile.restaurantName,
                              style: TextStyle(
                                fontSize: 20,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.restaurantProfile.email,
                              style: TextStyle(color: Colors.grey),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, right: 30),
                              child: Text(
                                widget.restaurantProfile.address,
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
                                  '${widget.restaurantProfile.rating}★',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
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
                                  '${widget.restaurantProfile.nratings} Ratings',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 9,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: const BorderRadius.only(
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
              const Divider(
                height: 20,
                color: Colors.grey,
              ),
              Container(
                height: 25,
                child: ValueListenableBuilder(
                    valueListenable: selectedC,
                    builder: (context, value, _) {
                      print(value);
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: FilterButton(
                              label: categories[index],
                              onTap: () {
                                setState(() {
                                  selectedC.value = index;
                                });
                              },
                              isSelected: value == index,
                            ),
                          );
                        },
                      );
                    }),
              ),
              const Divider(
                height: 20,
                color: Colors.grey,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Recommended',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
              BlocConsumer<HomepageBloc, HomepageState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is MenuLoaded) {
                    if (state.menu.length == 0)
                      return Center(
                        child: Text('No Items Available'),
                      );
                    return ValueListenableBuilder(
                        valueListenable: selectedC,
                        builder: (context, value, _) {
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.menu.length,
                              itemBuilder: (context, index) {
                                if (true) {
                                  if (value == 0) {
                                    return CustomisableMenuItem(
                                      menuItem: MenuItemModel(
                                        category: state.menu[index].category,
                                        isAvailable:
                                            state.menu[index].isAvailable,
                                        itemId: state.menu[index].itemId,
                                        itemName: state.menu[index].itemName,
                                        description:
                                            state.menu[index].description,
                                        isVeg: state.menu[index].isVeg,
                                        price: state.menu[index].price,
                                        restaurantId:
                                            state.menu[index].restaurantId,
                                      ),
                                    );
                                  } else if (categories[value as int]
                                          .toString()
                                          .toLowerCase() ==
                                      state.menu[index].category
                                          .toLowerCase()) {
                                    return CustomisableMenuItem(
                                      menuItem: MenuItemModel(
                                        category: state.menu[index].category,
                                        isAvailable:
                                            state.menu[index].isAvailable,
                                        itemId: state.menu[index].itemId,
                                        itemName: state.menu[index].itemName,
                                        description:
                                            state.menu[index].description,
                                        isVeg: state.menu[index].isVeg,
                                        price: state.menu[index].price,
                                        restaurantId:
                                            state.menu[index].restaurantId,
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                } else {
                                  return Container();
                                }
                              });
                        });
                  } else if (state is Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    print("Loading");
                    return Center(
                      child: Text(""),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        floatingActionButton: Container(
          child: FittedBox(
            child: Stack(
              alignment: Alignment(1.4, -1.5),
              children: [
                FloatingActionButton(
                  // Your actual Fab
                  onPressed: () async {
                    await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CartPage()));
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OrderHistoryPage(
                            userId: FirebaseAuth.instance.currentUser!.email
                                .toString())));
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Colors.deepOrange,
                ),
                ValueListenableBuilder<Box>(
                    valueListenable:
                        Hive.box<CurrentOrder>("currentOrder").listenable(),
                    builder: (buildContext, box, _) {
                      if (box.length == 0) return Container();

                      return Container(
                        // This is your Badge
                        child: Center(
                          // Here you can put whatever content you want inside your Badge
                          child: Text(box.length.toString(),
                              style: TextStyle(color: Colors.white)),
                        ),
                        padding: const EdgeInsets.all(8),
                        constraints:
                            const BoxConstraints(minHeight: 32, minWidth: 32),
                        decoration: BoxDecoration(
                          // This controls the shadow
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 5,
                                color: Colors.black.withAlpha(50))
                          ],
                          borderRadius: BorderRadius.circular(16),
                          color:
                              Colors.blue, // This would be color of the Badge
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),

        // floatingActionButton: FloatingActionButton(
        //     heroTag: 2,
        //     child: Icon(Icons.bakery_dining_rounded),
        //     onPressed: () {
        //       Navigator.of(context)
        //           .push(MaterialPageRoute(builder: (context) => CartPage()));
        //     }),
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
  late bool isAvailable;

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
    isAvailable = widget.menuItem.isAvailable;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListTile(
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
                  CounterWidget(
                    menuItem: widget.menuItem,
                    isAvailable: widget.menuItem.isAvailable,
                  )
                ],
              ),
              Divider(
                color: Colors.grey,
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FilterButton extends StatefulWidget {
  final String label;
  final dynamic onTap;
  final bool isSelected;
  const FilterButton(
      {Key? key,
      required this.label,
      required this.onTap,
      required this.isSelected})
      : super(key: key);

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: widget.isSelected ? Colors.white : Colors.grey[200],
        side: BorderSide(
            width: widget.isSelected ? 1.5 : 0.7,
            color: widget.isSelected
                ? Colors.redAccent
                : Colors.grey[600]!), //border width and color
        shape: RoundedRectangleBorder(
            //to set border radius to button
            borderRadius: BorderRadius.circular(5)),
      ),
      child: Text(
        widget.label,
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 15,
          fontWeight: FontWeight.w400,
          letterSpacing: 1,
        ),
      ),
      onPressed: widget.onTap,
    );
  }
}
