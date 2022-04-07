part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class AuthenticationInitial extends SignInState {}

class AuthenticationSuccess extends SignInState {
  bool isAdmin;
  String? restaurantId;
  AuthenticationSuccess({required this.restaurantId, required this.isAdmin});
}

class AuthenticationFailure extends SignInState {}

class AuthenticationLoading extends SignInState {}

class AuthenticationLogout extends SignInState {}
