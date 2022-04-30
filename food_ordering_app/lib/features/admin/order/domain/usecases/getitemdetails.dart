import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:food_ordering_app/features/admin/order/data/models/orderitem_model.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../menu/data/models/menuitem_model.dart';
import '../repositories/order_repository.dart';

class GetItemDetails implements UseCase<List<MenuItemModel>, Params> {
  final OrderRepository repository;

  GetItemDetails(this.repository);

  @override
  Future<Either<Failure, List<MenuItemModel>>> call(Params params) async {
    return await repository.getItemDetails(
      params.itemId,
      params.restaurantId,
    );
  }
}

class Params extends Equatable {
  final List<String> itemId;
  final String restaurantId;
  const Params({required this.itemId, required this.restaurantId});

  @override
  List<Object> get props => [itemId, restaurantId];
}
