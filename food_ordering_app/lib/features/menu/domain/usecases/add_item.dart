// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';

// import '../../../../core/error/failures.dart';
// import '../../../../core/usecases/usecase.dart';

// class AddItem implements UseCase<Article, Params> {
//   final ArticlesRepository repository;

//   AddItem(this.repository);

//   @override
//   Future<Either<Failure, Article>> call(Params params) async {
//     return await repository.AddItem(
//       articleSlug: params.articleSlug,
//     );
//   }
// }

// class Params extends Equatable {
//   final String articleSlug;

//   const Params({
//     required this.articleSlug
//   });

//   @override
//   List<Object> get props => [
//     articleSlug
//   ];
// }
