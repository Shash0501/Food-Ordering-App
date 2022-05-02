import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_ordering_app/cache/restaurantIds.dart';
import 'package:food_ordering_app/features/customer/home/data/repositories/home_repository_impl.dart';

import '../../data/datasources/home_remote_datasource.dart';
import '../../data/models/menuitem_model.dart';
import '../../data/models/orderitem_model.dart';
import '../../domain/usecases/getmenubyrestaurants.dart' as gmr;
import '../../domain/usecases/getmenu.dart' as gmc;
import '../../domain/usecases/placeorder.dart' as po;
part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(HomepageInitial()) {
    on<HomepageEvent>((event, emit) async {
      if (event is CacheRestaurantIds) {
        emit(Loading());
        await cacheRestaurantIds();
        emit(DataCachedSuccesfully());
      } else if (event is RestaurantMenu) {
        gmr.getMenuR GetMenuR = gmr.getMenuR(
            repository: HomeRepositoryImpl(
                remoteDataSource: HomeRemoteDataSourceImpl()));

        await GetMenuR.call(gmr.Params(restaurantId: event.restaurantId))
            .then((value) {
          print("Getting restaurant menu");
          print(value);
          value.fold(
              (failure) => emit(Error(message: "Error in laoding the menu")),
              (menu) => {print(menu.length), emit(MenuLoaded(menu: menu))});
        });
      } else if (event is Menu) {
        emit(Loading());
        // await cacheRestaurantIds();

        gmc.getMenu GetMenu = gmc.getMenu(
            repository: HomeRepositoryImpl(
                remoteDataSource: HomeRemoteDataSourceImpl()));
        // ?? Here I am sending random value for category as before this function was implementerd for
        // ?? getting menu by category.
        // ?? but in the remote datasource layer I have omitted  the category checking
        await GetMenu.call(gmc.Params(category: "A")).then((value) {
          print(value);
          value.fold((failure) => print(failure),
              (value) => emit(MenuLoaded(menu: value)));
        });
      } else if (event is PlaceOrderEvent) {
        po.placeOrder placeOrder = po.placeOrder(
            repository: HomeRepositoryImpl(
                remoteDataSource: HomeRemoteDataSourceImpl()));

        await placeOrder.call(po.Params(order: event.order)).then((value) {
          print(value);
          value.fold(
              (failure) => print(failure), (value) => print("order placed"));
        });
      }
    });
  }
}
