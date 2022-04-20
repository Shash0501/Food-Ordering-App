import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:food_ordering_app/features/admin/order/data/models/orderitem_model.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../data/models/profile_model.dart';
import '../repositories/profile_repository.dart';

class LoadProfile implements UseCase<RestaurantProfileModel, Params> {
  final ProfileRepository repository;

  LoadProfile(this.repository);

  @override
  Future<Either<Failure, RestaurantProfileModel>> call(Params params) async {
    return await repository.loadProfile(
      params.restaurantId,
    );
  }
}

class Params extends Equatable {
  final String restaurantId;

  const Params({required this.restaurantId});

  @override
  List<Object> get props => [restaurantId];
}
