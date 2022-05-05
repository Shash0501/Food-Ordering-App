import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/features/admin/menu/data/models/menuitem_model.dart';
import 'package:food_ordering_app/features/customer/home/presentation/pages/order_history_page.dart';
import 'dart:developer' as developer;
import '../../../../admin/order/data/models/orderitem_model.dart';
import '../../../../admin/order/presentation/bloc/order_bloc.dart';
import '../../../../admin/order/presentation/widgets/order_details.dart';
import '../../../../admin/order/presentation/widgets/order_item.dart';
import '../../../../admin/order/presentation/widgets/order_summary.dart';
// import '../../data/models/orderitem_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SingleOrderPageC extends StatefulWidget {
  OrderItemModel orderItem;
  SingleOrderPageC({Key? key, required this.orderItem}) : super(key: key);

  @override
  State<SingleOrderPageC> createState() => _SingleOrderPageCState();
}

class _SingleOrderPageCState extends State<SingleOrderPageC> {
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => OrderHistoryPage(
                  userId: FirebaseAuth.instance.currentUser!.email.toString(),
                )));
        return false;
      },
      child: SafeArea(
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text("Please rate your order!",
                                style: TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 1,
                                )),
                          ),
                        ),
                        Center(
                          child: RatingBar.builder(
                            initialRating: widget.orderItem.ratingGiven!,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) async {
                              dynamic previousRating =
                                  widget.orderItem.ratingGiven;
                              double restaurantRating = 0;
                              int restaurantRatingCount = 0;
                              previousRating = await FirebaseFirestore.instance
                                  .collection("orders")
                                  .doc(widget.orderItem.orderId)
                                  .get()
                                  .then(
                                      (value) => value.data()!["ratingGiven"]);
                              await FirebaseFirestore.instance
                                  .collection('restaurants')
                                  .doc(widget.orderItem.restaurantId)
                                  .get()
                                  .then((value) {
                                restaurantRating =
                                    value.data()!['rating'].toDouble();
                                restaurantRatingCount =
                                    value.data()!['nratings'];
                              });
                              await FirebaseFirestore.instance
                                  .collection('orders')
                                  .doc(widget.orderItem.orderId)
                                  .update({
                                'ratingGiven': rating,
                              });
                              double newRating = (previousRating == 0)
                                  ? (restaurantRating * restaurantRatingCount +
                                          rating) /
                                      (restaurantRatingCount + 1)
                                  : (restaurantRating * restaurantRatingCount -
                                          previousRating +
                                          rating) /
                                      (restaurantRatingCount);
                              int newRatingCount = (previousRating == 0)
                                  ? restaurantRatingCount + 1
                                  : restaurantRatingCount;
                              await FirebaseFirestore.instance
                                  .collection('restaurants')
                                  .doc(widget.orderItem.restaurantId)
                                  .update({
                                'rating': newRating,
                                'nratings': newRatingCount,
                              });
                            },
                          ),
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
      ),
    );
  }
}
