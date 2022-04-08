import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:food_ordering_app/features/admin/order/data/models/orderitem_model.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../repositories/order_repository.dart';

class GetOrders implements UseCase<List<OrderItemModel>, Params> {
  final OrderRepository repository;

  GetOrders(this.repository);

  @override
  Future<Either<Failure, List<OrderItemModel>>> call(Params params) async {
    return await repository.getOrders(
      params.orderIds,
    );
  }
}

class Params extends Equatable {
  final List<String> orderIds;

  const Params({required this.orderIds});

  @override
  List<Object> get props => [orderIds];
}
