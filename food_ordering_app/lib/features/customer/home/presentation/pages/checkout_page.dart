import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/features/admin/menu/data/models/menuitem_model.dart';
import 'package:food_ordering_app/features/customer/home/data/models/orderitem_model.dart';
import 'package:hive/hive.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:uuid/uuid.dart';

import '../../../../../cache/order.dart';
import '../../../../admin/order/presentation/widgets/order_item.dart';
import '../../../../admin/order/presentation/widgets/order_summary.dart';
import '../bloc/homepage_bloc.dart';
import 'cart_page.dart';

class CheckoutPage extends StatefulWidget {
  OrderItemModel orderItem;
  CheckoutPage({Key? key, required this.orderItem}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  var uuid = Uuid();
  var isFinished = false;
  @override
  Widget build(BuildContext context) {
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
                'In your Cart',
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
                      item: MenuItemModel(
                        category: "Dessert",
                        price: 230,
                        isVeg: true,
                        description: 'Khalo Be',
                        itemId: 'Yo',
                        itemName: 'Ice Cream',
                        isAvailable: true,
                      ),
                      quantity: widget.orderItem.order[index]["quantity"],
                    );
                  }),
              OrderSummary(
                orderItems: widget.orderItem.order,
                itemdetails: [
                  MenuItemModel(
                    category: "Dessert",
                    price: 230,
                    isVeg: true,
                    description: 'Khalo Be',
                    itemId: 'Yo',
                    itemName: 'Ice Cream',
                    isAvailable: true,
                  ),
                  MenuItemModel(
                    category: "Dessert",
                    price: 230,
                    isVeg: true,
                    description: 'Khalo Be',
                    itemId: 'Yo',
                    itemName: 'Ice Cream',
                    isAvailable: true,
                  ),
                  MenuItemModel(
                    category: "Dessert",
                    price: 230,
                    isVeg: true,
                    description: 'Khalo Be',
                    itemId: 'Yo',
                    itemName: 'Ice Cream',
                    isAvailable: true,
                  )
                ],
              ),
              Divider(
                height: 10,
              ),
              Divider(
                height: 10,
                color: Colors.transparent,
              ),
              UserDetails(),
              Center(
                child: SwipeableButtonView(
                  buttonText: "SLIDE TO CONFIRM",
                  buttonWidget: Container(
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                    ),
                  ),
                  activeColor: Color(0xff3398F6),
                  isFinished: isFinished,
                  onWaitingProcess: () {
                    Future.delayed(Duration(seconds: 2), () {
                      setState(() {
                        isFinished = true;
                      });
                    });
                  },
                  onFinish: () {
                    var box = Hive.box<CurrentOrder>("currentOrder");
                    List<dynamic> itemIds =
                        Hive.box<CurrentOrder>("currentOrder").keys.toList();
                    String restaurantId = box.get(itemIds[0])!.restaurantId;

                    OrderItemModel order = OrderItemModel(
                        orderId: uuid.v1(),
                        customerId:
                            FirebaseAuth.instance.currentUser!.email.toString(),
                        restaurantId: restaurantId,
                        orderDate: Timestamp.now(),
                        totalAmount: totalAmount(),
                        ratingGiven: 2,
                        status: "Pending",
                        order: getOrderList(),
                        pincode: 314122,
                        address: "Abhi Daala Just");

                    BlocProvider.of<HomepageBloc>(context)
                        .add(PlaceOrderEvent(order: order));
                    box.clear();

                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your details',
          style: TextStyle(
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: TextFormField(
        //     decoration: const InputDecoration(labelText: "Name"),
        //     // The validator receives the text that the user has entered.
        //     validator: (value) {
        //       if (value == null || value.isEmpty) {
        //         return 'Please enter some text';
        //       }
        //       return null;
        //     },
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: TextFormField(
        //     decoration: const InputDecoration(labelText: "Phone Number"),
        //     // The validator receives the text that the user has entered.
        //     validator: (value) {
        //       if (value == null || value.isEmpty) {
        //         return 'Please enter some text';
        //       }
        //       return null;
        //     },
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(labelText: "Address"),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(labelText: "Pincode"),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
