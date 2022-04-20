import 'package:dartz/dartz.dart';
import 'package:food_ordering_app/features/admin/profile/data/models/profile_model.dart';

import '../../../../../core/error/failures.dart';

abstract class ProfileRepository {
  Future<Either<Failure, RestaurantProfileModel>> loadProfile(
      String restaurantId);
}
