import 'package:fake_story/screens/home.dart';
import 'package:fake_story/utils/app_constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      statusBarColor: Constants.primaryColor,
    ));

    return MaterialApp(
      title: 'Fake Story',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xffBB1FD5, Constants.color),
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
