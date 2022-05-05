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

class PlaceOrderEvent extends HomepageEvent {
  final OrderItemModel order;

  const PlaceOrderEvent({required this.order});

  @override
  List<Object> get props => [order];
}


class LoadProfile extends HomepageEvent{
  final String userId;
  const LoadProfile({required this.userId});
  @override
  List<Object> get props => [userId];
  
}