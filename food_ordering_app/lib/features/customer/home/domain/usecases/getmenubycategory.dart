import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:googleapis/artifactregistry/v1.dart';

import '../../../../../core/error/failures.dart';
// usecase
import '../../../../../core/usecases/usecase.dart';
// models
import '../../data/models/menuitem_model.dart';
// repository
import '../repositories/homerepository.dart';

class getOrdersC implements UseCase<List<MenuItemModel>, Params> {
  final HomeRepository repository;

  getOrdersC({required this.repository});

  @override
  Future<Either<Failure, List<MenuItemModel>>> call(Params params) async {
    return await repository.getOrdersC(
      params.category,
    );
  }
}

class Params extends Equatable {
  final String category;

  const Params({required this.category});

  @override
  List<Object> get props => [category];
}
