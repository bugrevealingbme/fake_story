import 'dart:math';

import 'package:fake_story/bloc/repository/user_repository.dart';
import 'package:fake_story/bloc/states/user_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class UserCubit extends Cubit<UserState> {
  UserRepository loginRepository;
  UserCubit(this.loginRepository) : super(UserInitState());

  Future<void> getCurrentUser(String token) async {
    var logger = Logger();
    try {
      logger.i("emit state is init");
      emit(UserLoadingState());
      logger.i("emit state is loading");
      var currentUser = await loginRepository.getCurrentUser(token);
      logger.i("emit state is loaded");
      emit(UserLoadedState(currentUser));
    } catch (e) {
      logger.i("emit state is error::$e");
      emit(UserErrorState(e.toString()));
    }
  }

  Future<void> createUser(String username, String password, String email,
      String? firstName, String? lastname) async {
    var logger = Logger();
    try {
      logger.i("emit state is init");
      emit(UserLoadingState());
      logger.i("emit state is loading");
      var createdUser = await loginRepository.register(
          username, password, email, firstName, lastname);
      logger.i("emit state is createdUser");
      emit(UserCreatedState(createdUser!));
    } catch (e) {
      logger.i("emit state is error::$e");
      emit(UserErrorState(e.toString()));
    }
  }

  Future<void> createToken(String username, String password) async {
    var logger = Logger();
    try {
      logger.i("emit state token is init");
      emit(UserLoadingState());
      logger.i("emit token state is loading");
      var accessToken =
          await loginRepository.getAccessToken(username, password);
      logger.i("emit token state is token created");
      emit(AccesTokenCreatedState(accessToken));
    } catch (e) {
      logger.i("emit token state is error::$e");
      emit(UserErrorState(e.toString()));
    }
  }
}
