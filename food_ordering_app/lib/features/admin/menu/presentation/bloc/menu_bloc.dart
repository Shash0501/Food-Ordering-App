import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_ordering_app/features/admin/menu/data/datasources/menu_remote_datasource.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuInitial()) {
    on<MenuEvent>((event, emit) async {
      if (event is AddItem) {
        MenuRemoteDataSource dataSource = MenuRemoteDataSourceImpl();
        await dataSource.addItem(event.restaurantId, event.itemName,
            event.category, event.price, event.isVeg, event.isAvailable);
        emit(MenuInitial());

        emit(ItemAdded());
      }
    });
  }
}
