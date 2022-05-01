import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:googleapis/artifactregistry/v1.dart';

import '../../../../../core/error/failures.dart';
// usecase
import '../../../../../core/usecases/usecase.dart';
// models
import '../../data/models/menuitem_model.dart';
// repository
import '../../data/models/orderitem_model.dart';
import '../entities/orderitem.dart';
import '../repositories/homerepository.dart';

class placeOrder implements UseCase<dynamic, Params> {
  final HomeRepository repository;

  placeOrder({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(Params params) async {
    return await repository.placeOrder(
      params.order,
    );
  }
}

class Params extends Equatable {
  final OrderItemModel order;

  const Params({required this.order});

  @override
  List<Object> get props => [order];
}
