part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final RestaurantProfileModel profile;

  ProfileLoaded({required this.profile});

  @override
  List<Object> get props => [profile];
}

class Loading extends ProfileState {}
