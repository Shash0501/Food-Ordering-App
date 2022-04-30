part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class LoadOrders extends OrderEvent {
  List<String> orderIds;
  LoadOrders({required this.orderIds});

  @override
  List<Object> get props => [orderIds];
}

class LoadItemDetails extends OrderEvent {
  List<String> itemId;
  String restaurantId;
  LoadItemDetails({required this.itemId, required this.restaurantId});

  @override
  List<Object> get props => [itemId];
}
