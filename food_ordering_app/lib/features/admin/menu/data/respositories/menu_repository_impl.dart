import 'package:dartz/dartz.dart';
import 'package:food_ordering_app/core/error/failures.dart';
import 'package:food_ordering_app/features/admin/menu/data/models/menuitem_model.dart';
import 'package:food_ordering_app/features/admin/menu/domain/repositories/menu_repository.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../datasources/menu_remote_datasource.dart';

class MenuRepositoryImpl implements MenuRepository {
  final MenuRemoteDataSource remoteDataSource;

  MenuRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<MenuItemModel>>> getMenu(
      String restaurantId) async {
    try {
      final result = await remoteDataSource.getMenu(restaurantId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> addItem(
      String restaurantId,
      String itemName,
      String category,
      int price,
      bool isVeg,
      bool isAvailable,
      String description,
      String itemId) async {
    try {
      final result = await remoteDataSource.addItem(
        restaurantId,
        itemName,
        category,
        price,
        isVeg,
        isAvailable,
        description,
        itemId,
      );
      print("Printing the reposiroty resutls");
      print(result);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
