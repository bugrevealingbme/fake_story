import 'package:fake_story/utils/app_constans.dart';
import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

class GeneralWidgets {
  static showModalBottom(context, Widget widget) {
    showModalBottomSheet<void>(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: const Color(0xfffafafa),
        context: context,
        builder: (BuildContext context) {
          return widget;
        });
  }

  static showModalCreateAcc(context) {
    return showModalBottom(context, createAnAccount(context));
  }

  static showModalLogin(context) {
    return showModalBottom(context, loginLogin(context));
  }

  static SingleChildScrollView loginLogin(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Later",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Sign in to your account",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  GeneralWidgets()._emailPasswordWidget('login'),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Reset your password",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  GeneralWidgets()._submitButton(context, 'Login'),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      GeneralWidgets.showModalCreateAcc(context);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "You don't have a account?",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          "Register",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Constants.themeColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Divider(),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.app_blocking),
                              const SizedBox(width: 5),
                              Text(
                                'Continue with Google',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff060c14),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.login),
                              const SizedBox(width: 5),
                              Text(
                                'Continue with Apple',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff060c14),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static SingleChildScrollView createAnAccount(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Later",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Create an Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  GeneralWidgets()._emailPasswordWidget('register'),
                  const SizedBox(height: 20),
                  GeneralWidgets()._submitButton(context, 'Create an account'),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      GeneralWidgets.showModalLogin(context);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Constants.themeColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Divider(),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.app_blocking),
                              const SizedBox(width: 5),
                              Text(
                                'Continue with Google',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff060c14),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.login),
                              const SizedBox(width: 5),
                              Text(
                                'Continue with Apple',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff060c14),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailPasswordWidget(String what) {
    return Column(
      children: <Widget>[
        _entryField("Email adress"),
        if (what == "register") _entryField("Username"),
        _entryField("Password", isPassword: true),
      ],
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: double.infinity,
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: title,
          hintStyle: const TextStyle(color: Color(0xff8f8f8f), fontSize: 16),
          border: InputBorder.none,
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }

  Widget _submitButton(context, String text) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Constants.themeColor,
      ),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  static crtLabel(text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 17, fontWeight: FontWeight.w500, color: Color(0xff222222)),
    );
  }

  static srtLabel(text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xff222222)),
    );
  }

  static storyVideo(Size size, viewer, {bool showCategory = true}) {
    return SizedBox(
      width: (size.width / 2.5),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('https://picsum.photos/850'))),
              child: Stack(
                children: [
                  /// black blur
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.4),
                                Colors.transparent
                              ]),
                        ),
                        height: size.height / 10,
                        width: size.width,
                      )),

                  //category
                  showCategory
                      ? Positioned(
                          right: 15,
                          top: 15,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 13),
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(0, 0, 0, 0.45),
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Cars",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      : Container(),

                  //time
                  Positioned(
                    left: 10,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 6),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(180, 255, 255, 255),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "0:15",
                        style: TextStyle(
                          color: Color(0xff111111),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  /// tags
                  videoBottomInfo(viewer),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static storyPhoto(Size size, viewer, {bool showCategory = true}) {
    return SizedBox(
      width: size.width / 2,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://picsum.photos/950',
                  ),
                ),
              ),
              child: Stack(
                children: [
                  //category
                  showCategory
                      ? Positioned(
                          left: viewer ? 15 : 10,
                          top: viewer ? 15 : 10,
                          child: Container(
                            padding: viewer
                                ? const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 13)
                                : const EdgeInsets.all(0),
                            decoration: viewer
                                ? BoxDecoration(
                                    color: Color.fromARGB(180, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(50),
                                  )
                                : null,
                            child: Text(
                              "Cars",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: viewer ? 14 : 13),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static videoBottomInfo(bool viewer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const Spacer(),
          Row(
            children: [
              Text(
                '1d ago',
                style: TextStyle(
                    fontSize: viewer ? 15 : 14, color: Colors.white54),
              ),
              const Spacer(),
              viewer
                  ? Row(
                      children: [
                        const Icon(
                          Icons.favorite_border_outlined,
                          size: 18,
                          color: Colors.white38,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '1.3K',
                          style: TextStyle(fontSize: 14, color: Colors.white54),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  static Container viewerContainer(viewer) {
    return Container(
        decoration: BoxDecoration(
          color: Constants.themeColor,
          borderRadius: BorderRadius.circular(3),
        ),
        height: 22,
        width: 22,
        alignment: Alignment.center,
        child: viewer
            ? const Text(
                '2',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              )
            : const Text(
                '3',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ));
  }

  static categoryC(String category, [bool active = false]) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: active ? Constants.themeColor : Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              child: SizedBox(
                height: 32,
                width: 32,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network('https://picsum.photos/850',
                      fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 15,
              width: 36,
              child: Center(
                child: TextScroll(
                  category,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: active ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                  velocity: const Velocity(pixelsPerSecond: Offset(12, 0)),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
