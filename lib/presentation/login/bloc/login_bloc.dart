import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_app/domain/model/model.dart';
import 'package:first_app/domain/usecase/login_usecase.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _useCase;

  LoginBloc(this._useCase) : super(LoginInitial()) {
    on<LoadUiEvent>(
      (event, emit) => emit(
        LoginUiInitial(),
      ),
    );

    on<LoginApiCallEvent>((event, emit) async {
      emit(LoginLoadingState('Please Wait...'));
      final response =
          await _useCase.execute(LoginUseCaseInput("paras", "123456"));
      response.fold((failure) => emit(LoginErrorState(failure.message)),
          (auth) {
        emit(LoginLoadedState(auth));
      });
    });
  }
}
