import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../admin/menu/data/models/menuitem_model.dart';
import '../../data/models/orderitem_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<MenuItemModel>>> getOrdersR(String restaurantId);
  Future<Either<Failure, List<MenuItemModel>>> getOrdersC(String category);
}
