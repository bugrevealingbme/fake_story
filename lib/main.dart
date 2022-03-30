import 'package:fake_story/bloc/cubit/login_cubit.dart';
import 'package:fake_story/bloc/repository/login_repository.dart';
import 'package:fake_story/screens/auth_screen.dart';
import 'package:fake_story/screens/home.dart';
import 'package:fake_story/screens/login_screen.dart';
import 'package:fake_story/utils/app_constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // status bar color
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(LoginDaoRepository()))
      ],
      child: MaterialApp(
        title: 'Fake Story',
        theme: ThemeData(
          primarySwatch: MaterialColor(0xffBB1FD5, Constants.color),
        ),
        home: const AuthPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
