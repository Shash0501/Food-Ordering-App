import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/features/admin/menu/data/models/menuitem_model.dart';

import '../../data/models/orderitem_model.dart';
import '../bloc/order_bloc.dart';

class SingleOrderPage extends StatefulWidget {
  OrderItemModel orderItem;
  SingleOrderPage({Key? key, required this.orderItem}) : super(key: key);

  @override
  State<SingleOrderPage> createState() => _SingleOrderPageState();
}

class _SingleOrderPageState extends State<SingleOrderPage> {
  @override
  void initState() {
    List<String> itemIds = [];
    for (var element in widget.orderItem.order) {
      itemIds.add(element["itemId"]);
    }
    BlocProvider.of<OrderBloc>(context).add(LoadItemDetails(
        itemId: itemIds, restaurantId: widget.orderItem.restaurantId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.orderItem.order);
    return SafeArea(
      child: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is OrderInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is OrderItemLoaded) {
            print("Printing the orders");
            print(state.order);
            // return Scaffold(
            //     appBar: AppBar(
            //       title: Text("Order Details"),
            //     ),
            //     body: const CircularProgressIndicator());
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
    );
  }
}

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

class OrderSummary extends StatelessWidget {
  final dynamic orderItems;
  final List<MenuItemModel> itemdetails;
  const OrderSummary(
      {Key? key, required this.orderItems, required this.itemdetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalItemPrice = calculateTotal();
    final promoDiscount = 0;
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
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 15)),
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
        Divider(
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

class OrderDetails extends StatelessWidget {
  final OrderItemModel orderItem;

  const OrderDetails({Key? key, required this.orderItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Details',
          style: TextStyle(fontSize: 20),
        ),
        OrderDetailItem(
            parameter: "Order Number", value: orderItem.orderId.toString()),
        const OrderDetailItem(parameter: "Payment", value: "Paid : Using UPI"),
        OrderDetailItem(
            parameter: "Date", value: orderItem.orderDate.toString())
      ],
    );
  }
}

class OrderDetailItem extends StatelessWidget {
  final String parameter;
  final String value;

  const OrderDetailItem(
      {Key? key, required this.parameter, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            parameter,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          Text(value),
        ],
      ),
    );
  }
}
