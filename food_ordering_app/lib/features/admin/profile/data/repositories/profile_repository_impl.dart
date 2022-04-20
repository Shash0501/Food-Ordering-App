import 'package:dartz/dartz.dart';
import 'package:food_ordering_app/core/error/failures.dart';
import 'package:food_ordering_app/features/admin/order/data/models/orderitem_model.dart';
import 'package:food_ordering_app/features/admin/profile/data/models/profile_model.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, RestaurantProfileModel>> loadProfile(
      String restaurantId) async {
    try {
      final result = await remoteDataSource.loadProfile(restaurantId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
