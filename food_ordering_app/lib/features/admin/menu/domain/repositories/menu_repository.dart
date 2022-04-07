import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../data/models/menuitem_model.dart';

abstract class MenuRepository {
  Future<Either<Failure, List<MenuItemModel>>> getMenu(String restaurantId);
  Future<Either<Failure, bool>> addItem(
      String restaurantId,
      String itemName,
      String category,
      int price,
      bool isVeg,
      bool isAvailable,
      String description,
      String itemId);
  // Future<Either<Failure, List<Article>>> fetchCategoryArticles({
  //   required int page,
  //   required int categoryId,
  //   required bool refreshStatus,
  // });

  // Future<Either<Failure, List<Article>>> fetchRelatedArticles(
  //     {required int articleId, required int categoryId});

  // Future<Either<Failure, List<Tag>>> fetchTags({required Article article});

  // Future<Either<Failure, List<Article>>> fetchFeaturedArticles(
  //     {required bool refreshStatus});

  // Future<Either<Failure, List<Article>>> fetchLatestArticles(
  //     {required bool refreshStatus, required int page});

  // Future<Either<Failure, List<Article>>> fetchArticles(
  //     {required int page,
  //     required bool refreshStatus,
  //     required String url,
  //     required int cacheDuration,
  //     required String pageName,
  //     required String? catId});

  // Future<Either<Failure, Article>> fetchArticle({
  //   required String articleSlug,
  // });
}
