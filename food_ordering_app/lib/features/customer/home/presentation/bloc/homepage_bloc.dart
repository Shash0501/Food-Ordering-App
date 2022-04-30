import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_ordering_app/cache/restaurantIds.dart';
import 'package:food_ordering_app/features/customer/home/data/repositories/home_repository_impl.dart';

import '../../data/datasources/home_remote_datasource.dart';
import '../../domain/usecases/getmenubyrestaurants.dart' as gmr;
import '../../domain/usecases/getmenubycategory.dart' as gmc;
part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(HomepageInitial()) {
    on<HomepageEvent>((event, emit) async {
      if (event is CacheRestaurantIds) {
        cacheRestaurantIds();
      } else if (event is RestaurantMenu) {
        gmr.getOrdersR GetOrdersR = gmr.getOrdersR(
            repository: HomeRepositoryImpl(
                remoteDataSource: HomeRemoteDataSourceImpl()));

        await GetOrdersR.call(gmr.Params(restaurantId: event.restaurantId))
            .then((value) {
          print(value);
        });
      } else if (event is CategoryMenu) {
        gmc.getOrdersC GetOrdersC = gmc.getOrdersC(
            repository: HomeRepositoryImpl(
                remoteDataSource: HomeRemoteDataSourceImpl()));

        await GetOrdersC.call(gmc.Params(category: event.category))
            .then((value) {
          print(value);
        });
      }
    });
  }
}
