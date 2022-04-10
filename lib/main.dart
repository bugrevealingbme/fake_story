import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:fake_story/bloc/cubit/user_cubit.dart';
import 'package:fake_story/bloc/repository/user_repository.dart';
import 'package:fake_story/languages.dart';
import 'package:fake_story/screens/splash_screen.dart';
import 'package:fake_story/utils/app_constans.dart';
import 'package:fake_story/utils/config.dart';
import 'package:fake_story/utils/shared_prefs_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'bloc/getx/getx_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      child: const MyApp(),
      supportedLocales: const [
        Locale('en', 'Us'),
        Locale('tr', 'TR'),
        Locale('es', 'ES')
      ],
      path: 'assets/translations'));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    CustomSharedPref.writeStringDataToSharedPref(
        "languageData", Get.deviceLocale.toString());

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final Controller controller = Get.put(Controller());
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
        locale: LocalizationService.locale,
        translations: LocalizationService(),
        fallbackLocale: LocalizationService.fallbackLocale,
        theme: ThemeData(
          primarySwatch: MaterialColor(0xffBB1FD5, Constants.color),
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
