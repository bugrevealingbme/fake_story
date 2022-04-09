import 'dart:io';

import 'package:fake_story/api/api_calls/detail_page_calls.dart';
import 'package:fake_story/bloc/cubit/user_cubit.dart';
import 'package:fake_story/bloc/repository/user_repository.dart';
import 'package:fake_story/screens/auth_screen.dart';
import 'package:fake_story/screens/home.dart';
import 'package:fake_story/screens/login_screen.dart';
import 'package:fake_story/screens/splash_screen.dart';
import 'package:fake_story/utils/app_constans.dart';
import 'package:fake_story/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() async {
  var data=await DetailPageCalls.userProfileUpdate({"profileimage":"http://enesakoluk.ml/1"});
  print(data);

 
 
   
  
  runApp(const MyApp());
 
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    
    print(Platform.localeName);
    getLocale().then((locale) {
      setState(() {
        print("Preference Revoked ${locale.languageCode}");
        Get.updateLocale(locale);
        print("GET LOCALE Revoked ${Get.locale?.languageCode}");
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // status bar color
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit(UserDaoRepository()))
      ],
      child: GetMaterialApp(
        title: 'Fake Story',
        locale: Get.window.locale,
        fallbackLocale: const Locale('en', 'US'),
        theme: ThemeData(
          primarySwatch: MaterialColor(0xffBB1FD5, Constants.color),
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
