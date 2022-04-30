import 'package:dartz/dartz.dart';
import 'package:food_ordering_app/core/error/failures.dart';
import 'package:food_ordering_app/features/admin/order/data/models/orderitem_model.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../menu/data/models/menuitem_model.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_datasource.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<OrderItemModel>>> getOrders(
      List<String> orderIds) async {
    try {
      dynamic result = await remoteDataSource.getOrders(orderIds);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MenuItemModel>>> getItemDetails(
      List<String> itemIds, String restaurantId) async {
    try {
      print("Getting the item details");
      dynamic result =
          await remoteDataSource.getItemDetails(itemIds, restaurantId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
