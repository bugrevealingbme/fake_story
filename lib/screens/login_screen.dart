import 'package:fake_story/bloc/cubit/login_cubit.dart';
import 'package:fake_story/bloc/states/login_states.dart';
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
    context.read<LoginCubit>().getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: ((context, state) {
        if (state is LoginLoadingState) {
          return const Text("Loading...");
        }
        if (state is LoginLoadedState) {
          return const Text("User Data Taken");
        }
        if (state is LoginErrorState) {
          return Text("User Data Not Taken:${state.errorMesage}");
        }
        return const Center();
      }),
    );
  }
}
