import 'package:fake_story/screens/auth_screen.dart';
import 'package:fake_story/screens/home.dart';
import 'package:flutter/material.dart';
import '../utils/shared_prefs_ext.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = false;
  @override
  void initState() {
    super.initState();
    // TODO: delete this after test
    Future.delayed(const Duration(seconds: 3), () {
      var key = CustomSharedPref.readStringDataToSharedPref("accessToken");
      key.then((value) => {
            if (value == null)
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AuthPage()))
              }
            else
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()))
              }
          });
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
