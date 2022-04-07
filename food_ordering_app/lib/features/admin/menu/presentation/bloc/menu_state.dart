part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}

class ItemAdded extends MenuState {}

class Loading extends MenuState {}

class Error extends MenuEvent {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}

class MenuLoaded extends MenuState {
  final List<MenuItem> menuItems;

  MenuLoaded({required this.menuItems});

  @override
  List<Object> get props => [menuItems];
}
