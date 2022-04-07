import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:food_ordering_app/features/admin/menu/data/models/menuitem_model.dart';
import 'package:food_ordering_app/features/admin/menu/domain/repositories/menu_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';

class LoadMenu implements UseCase<List<MenuItemModel>, Params> {
  final MenuRepository repository;

  LoadMenu(this.repository);

  @override
  Future<Either<Failure, List<MenuItemModel>>> call(Params params) async {
    return await repository.getMenu(
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
