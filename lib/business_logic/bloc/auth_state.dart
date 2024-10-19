part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthInProgressState extends AuthState {}

class AuthLoggingInProgressState extends AuthState {}

class AuthRegisteringProgressState extends AuthState {}

class AuthResgisteringSuccess extends AuthState {}

// class AuthNotActivatedState extends AuthState {}

// class AuthActivateLoadingState extends AuthState {}

class AuthTraderSuccessState extends AuthState {
  // final String token;

  // AuthSuccessState(this.token);
}

class AuthBrokerSuccessState extends AuthState {
  // final String token;

  // AuthSuccessState(this.token);
}

class AuthLoginErrorState extends AuthState {
  final String? error;
  const AuthLoginErrorState(this.error);
}

class AuthFailureState extends AuthState {
  final String errorMessage;

  const AuthFailureState(this.errorMessage);
}
