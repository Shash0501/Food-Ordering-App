part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends SignInEvent {}

class AuthenticationLoggedIn extends SignInEvent {}

class AuthenticationLogOut extends SignInEvent {}

class CheckIsAdmin extends SignInEvent {}
