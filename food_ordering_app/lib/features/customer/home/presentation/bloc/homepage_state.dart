part of 'homepage_bloc.dart';

abstract class HomepageState extends Equatable {
  const HomepageState();

  @override
  List<Object> get props => [];
}

class HomepageInitial extends HomepageState {}

class MenuLoaded extends HomepageState {
  final List<MenuItemModel> menu;

  const MenuLoaded({required this.menu});

  @override
  List<Object> get props => [menu];
}

class Loading extends HomepageState {}


class DataCachedSuccesfully extends HomepageState{}