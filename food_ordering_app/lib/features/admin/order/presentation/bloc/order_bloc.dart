import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../menu/data/models/menuitem_model.dart';
import '../../data/datasources/order_remote_datasource.dart';
import '../../data/models/orderitem_model.dart';
import '../../data/respositories/order_Repository_impl.dart';
import '../../domain/usecases/getorders.dart' as go;
import '../../domain/usecases/getitemdetails.dart' as gi;
part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderEvent>((event, emit) async {
      if (event is LoadOrders) {
        emit(Loading());

        List<String> orderIds = [];
        go.GetOrders getOrders = go.GetOrders(
            OrderRepositoryImpl(remoteDataSource: OrderRemoteDataSourceImpl()));
        try {
          final result = await getOrders(go.Params(orderIds: event.orderIds));
          result.fold(
            (failure) => {print("Failure - 100")},
            (orders) =>
                {print("Success - 200"), emit(OrdersLoaded(orders: orders))},
          );
        } catch (e) {
          print(e);
        }
      } else if (event is LoadItemDetails) {
        emit(Loading());
        gi.GetItemDetails getItemDetails = gi.GetItemDetails(
            OrderRepositoryImpl(remoteDataSource: OrderRemoteDataSourceImpl()));
        // go.GetOrderItem getOrderItem = go.GetOrderItem(
        //     OrderRepositoryImpl(remoteDataSource: OrderRemoteDataSourceImpl()));
        try {
          final result = await getItemDetails(gi.Params(
              itemId: event.itemId, restaurantId: event.restaurantId));
          result.fold(
            (failure) => {print("Failure")},
            (order) => emit(OrderItemLoaded(order: order)),
          );
        } catch (e) {
          print(e);
        }
      }
    });
  }
}
