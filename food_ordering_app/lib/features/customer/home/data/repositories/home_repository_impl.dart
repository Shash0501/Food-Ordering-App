import 'package:dartz/dartz.dart';
import 'package:food_ordering_app/core/error/failures.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/repositories/homerepository.dart';
import '../datasources/home_remote_datasource.dart';
import '../models/menuitem_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<MenuItemModel>>> getMenuR(
      String restaurantId) async {
    try {
      final orders = await remoteDataSource.getMenuR(restaurantId);

      return Right(orders);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MenuItemModel>>> getMenu(String category) async {
    try {
      final orders = await remoteDataSource.getMenu(category);
      return Right(orders);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
