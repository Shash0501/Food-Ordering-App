import 'package:dartz/dartz.dart';
import 'package:food_ordering_app/core/error/failures.dart';
import 'package:food_ordering_app/features/admin/order/data/models/orderitem_model.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
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
      dynamic result = remoteDataSource.getOrders(orderIds);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
