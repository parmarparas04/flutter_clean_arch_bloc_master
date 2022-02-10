part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoadUiEvent extends LoginEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginApiCallEvent extends LoginEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
