import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../data/models/menuitem_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<MenuItemModel>>> getOrdersR(String restaurantId);
  Future<Either<Failure, List<MenuItemModel>>> getOrdersC(String category);
}
