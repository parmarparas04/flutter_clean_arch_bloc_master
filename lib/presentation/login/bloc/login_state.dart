part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginUiInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {
  final String loadingStatus;
  final IconData? icon;

  LoginLoadingState(
    this.loadingStatus, {
    this.icon,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        loadingStatus,
        icon,
      ];
}

class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class LoginLoadedState extends LoginState {
  final Authentication auth;

  LoginLoadedState(this.auth);
  @override
  // TODO: implement props
  List<Object?> get props => [auth];
}
