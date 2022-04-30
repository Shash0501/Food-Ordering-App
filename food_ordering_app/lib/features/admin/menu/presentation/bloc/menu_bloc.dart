import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_ordering_app/features/admin/menu/data/datasources/menu_remote_datasource.dart';
import 'package:food_ordering_app/features/admin/menu/data/respositories/menu_repository_impl.dart';
import 'package:googleapis/artifactregistry/v1.dart';
import 'package:googleapis/compute/v1.dart';

// importing the usecases
import '../../domain/entities/menuitem.dart';
import '../../domain/usecases/load_menu.dart' as LM;
import '../../domain/usecases/edit_item.dart' as EI;

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuInitial()) {
    on<MenuEvent>((event, emit) async {
      if (event is AddItem) {
        MenuRemoteDataSource dataSource = MenuRemoteDataSourceImpl();
        await dataSource.addItem(
            event.restaurantId,
            event.itemName,
            event.category,
            event.price,
            event.isVeg,
            event.isAvailable,
            event.description,
            event.itemId);
        emit(MenuInitial());

        emit(ItemAdded());
      } else if (event is EditItem) {
        emit(Loading());

        EI.EditItem editItem = EI.EditItem(
            MenuRepositoryImpl(remoteDataSource: MenuRemoteDataSourceImpl()));
        try {
          final result = await editItem(EI.Params(
              restaurantId: event.restaurantId,
              itemId: event.itemId,
              itemName: event.itemName,
              category: event.category,
              price: event.price,
              isVeg: event.isVeg,
              isAvailable: event.isAvailable,
              description: event.description));
          result.fold(
            (failure) => {print("Failure")},
            (bool) {
              emit(ItemEdited());
            },
          );
        } catch (e) {
          print(e);
        }
      } else if (event is LoadMenu) {
        emit(Loading());
        LM.LoadMenu loadMenu = LM.LoadMenu(
            MenuRepositoryImpl(remoteDataSource: MenuRemoteDataSourceImpl()));

        try {
          final result =
              await loadMenu(LM.Params(restaurantId: event.restaurantId));
          result.fold(
            (failure) => {print("Failure")},
            (menuItems) {
              emit(MenuLoaded(menuItems: menuItems));
            },
          );
        } catch (e) {
          print(e);
        }
      }
    });
  }
}
