import 'package:dartz/dartz.dart';
import 'package:food_ordering_app/core/error/failures.dart';
import 'package:food_ordering_app/features/customer/home/data/models/orderitem_model.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../admin/menu/data/models/menuitem_model.dart';
import '../../domain/repositories/homerepository.dart';
import '../datasources/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<MenuItemModel>>> getOrdersR(
      String restaurantId) async {
    try {
      final orders = await remoteDataSource.getOrdersR(restaurantId);

      return Right(orders);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MenuItemModel>>> getOrdersC(
      String category) async {
    try {
      final orders = await remoteDataSource.getOrdersC(category);
      return Right(orders);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
