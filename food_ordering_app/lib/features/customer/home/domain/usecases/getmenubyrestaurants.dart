import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../data/models/menuitem_model.dart';
import '../repositories/homerepository.dart';

class getMenuR implements UseCase<List<MenuItemModel>, Params> {
  final HomeRepository repository;

  getMenuR({required this.repository});

  @override
  Future<Either<Failure, List<MenuItemModel>>> call(Params params) async {
    return await repository.getMenuR(
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
