import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/datasources/order_remote_datasource.dart';
import '../../data/models/orderitem_model.dart';
import '../../data/respositories/order_Repository_impl.dart';
import '../../domain/usecases/getorders.dart' as go;

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderEvent>((event, emit) async {
      if (event is LoadOrders) {
        emit(Loading());
        go.GetOrders getOrders = go.GetOrders(
            OrderRepositoryImpl(remoteDataSource: OrderRemoteDataSourceImpl()));
        try {
          final result = await getOrders(go.Params(orderIds: event.orderIds));
          result.fold(
            (failure) => {print("Failure")},
            (orders) => emit(OrdersLoaded(orders: orders)),
          );
        } catch (e) {
          print(e);
        }
      }
    });
  }
}
