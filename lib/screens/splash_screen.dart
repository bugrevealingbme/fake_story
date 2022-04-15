import 'package:fake_story/api/api_calls/profil_page_calls.dart';
import 'package:fake_story/screens/auth_screen.dart';
import 'package:fake_story/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bloc/getx/getx_controller.dart';
import '../utils/shared_prefs_ext.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

final Controller controller = Get.put(Controller());

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = false;
  @override
  void initState() {
    super.initState();
    controller.setUserLoginState();

    // TODO: delete this after test
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyHomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      //Splash Screen Logic and Design
      child: CircularProgressIndicator(),
    );
  }
}
