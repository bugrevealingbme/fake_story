import 'dart:math';

import 'package:fake_story/bloc/repository/login_repository.dart';
import 'package:fake_story/bloc/states/login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginRepository loginRepository;
  LoginCubit(this.loginRepository) : super(LoginInitState());

  Future<void> getCurrentUser() async {
    var logger = Logger();
    try {
      logger.i("emit state is init");
      emit(LoginLoadingState());
      logger.i("emit state is loading");
      var currentUser = await loginRepository.getCurrentUser();
      logger.i("emit state is loaded");
      emit(LoginLoadedState(currentUser));
    } catch (e) {
      logger.i("emit state is error");
      emit(LoginErrorState(e.toString()));
    }
  }
}
