part of 'homepage_bloc.dart';

abstract class HomepageEvent extends Equatable {
  const HomepageEvent();

  @override
  List<Object> get props => [];
}

class CacheRestaurantIds extends HomepageEvent {}

class RestaurantMenu extends HomepageEvent {
  final String restaurantId;

  RestaurantMenu(this.restaurantId);

  @override
  List<Object> get props => [restaurantId];
}

class CategoryMenu extends HomepageEvent {
  final String category;

  CategoryMenu(this.category);

  @override
  List<Object> get props => [category];
}

class Menu extends HomepageEvent {}
