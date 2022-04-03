import 'package:fake_story/bloc/cubit/user_cubit.dart';
import 'package:fake_story/bloc/states/user_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: ((context, state) {
        if (state is UserLoadingState) {
          return const Text("Loading...");
        }
        if (state is UserLoadedState) {
          return const Text("User Data Taken");
        }
        if (state is UserErrorState) {
          return Text("User Data Not Taken:${state.errorMesage}");
        }
        return const Center();
      }),
    );
  }
}
