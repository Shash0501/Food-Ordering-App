import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:food_ordering_app/features/admin/menu/data/models/menuitem_model.dart';
import 'package:food_ordering_app/features/admin/menu/domain/repositories/menu_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';

class EditItem implements UseCase<bool, Params> {
  final MenuRepository repository;

  EditItem(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.editItem(
        params.restaurantId,
        params.itemName,
        params.category,
        params.price,
        params.isVeg,
        params.isAvailable,
        params.description,
        params.itemId);
  }
}

class Params extends Equatable {
  final String itemName;
  final String category;
  final int price;
  final bool isVeg;
  final bool isAvailable;
  final String restaurantId;
  final String description;
  final String itemId;
  const Params({
    required this.itemName,
    required this.category,
    required this.price,
    required this.isVeg,
    required this.isAvailable,
    required this.restaurantId,
    required this.description,
    required this.itemId,
  });

  @override
  List<Object> get props => [
        restaurantId,
        itemId,
        itemName,
        category,
        price,
        isVeg,
        isAvailable,
        description
      ];
}
