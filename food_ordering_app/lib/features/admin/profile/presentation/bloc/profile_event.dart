part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfile extends ProfileEvent {
  final String restaurantId;

  LoadProfile({required this.restaurantId});

  @override
  List<Object> get props => [restaurantId];
}
