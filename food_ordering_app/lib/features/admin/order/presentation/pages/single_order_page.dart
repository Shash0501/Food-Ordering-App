import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is OrderInitial) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is OrderItemLoaded) {
          print("Printing the orders");
          print(state.order);
          return Scaffold(
              appBar: AppBar(
                title: Text("Order Details"),
              ),
              body: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Single Order Page'),
          ),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' Order Summary',
                    style: TextStyle(
                      fontSize: 27,
                      letterSpacing: 1.3,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      widget.orderItem.restaurantId.trim(),
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1.5,
                      ),
                    ),
                    subtitle: Text(widget.orderItem.address,
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 10,
                  ),
                  Text(
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
                      shrinkWrap: true,
                      itemCount: widget.orderItem.order.length,
                      itemBuilder: (context, index) {
                        return OrderItem(
                          item: widget.orderItem.order[index],
                        );
                      }),
                  OrderSummary(orderItems: widget.orderItem.order),
                  OrderDetails(
                    orderItem: widget.orderItem,
                  )
                ],
              ),
            ),
          ),

          // body: Column(
          //   children: [
          //     Text('Order ID: ${widget.orderItem.orderId}'),
          //     Text('Customer ID: ${widget.orderItem.customerId}'),
          //     Text('Restaurant ID: ${widget.orderItem.restaurantId}'),
          //     Text('Order Date: ${widget.orderItem.orderDate.day} '),
          //     Text('Total Amount: ${widget.orderItem.totalAmount}'),
          //     Text('Rating Given: ${widget.orderItem.ratingGiven}'),
          //     Text('Status: ${widget.orderItem.status}'),
          //     Text('Address: ${widget.orderItem.address} '),
          //     Text('Order: ${widget.orderItem.order}'),
          //   ],
          // ),
        );
      },
    );
  }
}

class OrderItem extends StatelessWidget {
  final dynamic item;
  OrderItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Row(
        children: [
          Image.network(
            'https://www.pikpng.com/pngl/m/210-2108039_veg-logo-png-veg-symbol-clipart.png',
            width: 20,
            height: 20,
          ),
          SizedBox(
            width: 25,
          ),
          Text(
            '${item['itemId']}',
            style: TextStyle(
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
          Text("Quantity: ${item['quantity']}"),
          SizedBox(
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
                      child: Center(child: Text("${item['quantity']}")),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromARGB(255, 175, 216, 176),
                        border: Border(
                          left: BorderSide(color: Colors.green),
                          bottom: BorderSide(color: Colors.green),
                          top: BorderSide(color: Colors.green),
                          right: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    " X ₹${item['price']}",
                    style: TextStyle(
                      letterSpacing: 2,
                      wordSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            Text('₹${item['quantity'] * item['price']}')
          ]),
          Divider(
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
  const OrderSummary({Key? key, required this.orderItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalItemPrice = calculateTotal();
    final promoDiscount = 0;
    final tax = 0.18 * totalItemPrice;
    final deliveryCharge = 0.20 * totalItemPrice;

    return Column(
      children: [
        ExpandedRow(
          leftChild: Text('Item Total', style: TextStyle(fontSize: 15)),
          rightChild: Text('₹$totalItemPrice'),
        ),
        ExpandedRow(
          leftChild: Text('Promo - (YUMMY)',
              style: TextStyle(fontSize: 15, color: Colors.blue[800])),
          rightChild: Text(
            'You Saved ₹$promoDiscount',
            style: TextStyle(color: Colors.blue[800]),
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
            height: 30,
            child: DecoratedBox(
              child: Center(
                child: ExpandedRow(
                  leftChild: Text(
                    "Your total savings",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 15),
                  ),
                  rightChild: Text('₹ ${promoDiscount}',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 15)),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromARGB(255, 176, 230, 255),
                border: Border(
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
    orderItems.forEach((e) {
      itemTotal += e['quantity'] * e['price'];
    });
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
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
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
  final dynamic orderItem;

  const OrderDetails({Key? key, required this.orderItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Details',
          style: TextStyle(fontSize: 20),
        ),
        OrderDetailItem(parameter: "Order Number", value: "1922"),
        OrderDetailItem(parameter: "Payment", value: "Paid : Using UPI"),
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
