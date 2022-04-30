import 'package:dartz/dartz.dart';
import 'package:food_ordering_app/features/admin/order/data/models/orderitem_model.dart';

import '../../../../../core/error/failures.dart';
import '../../../menu/data/models/menuitem_model.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderItemModel>>> getOrders(
      List<String> orderIds);
  Future<Either<Failure, List<MenuItemModel>>> getItemDetails(
      List<String> itemIds, String restaurantId);
}
