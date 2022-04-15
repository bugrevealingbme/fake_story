import 'dart:io';

import 'package:fake_story/api/api_calls/profil_page_calls.dart';
import 'package:fake_story/api/video_thumbnail/thumbnail.dart';
import 'package:fake_story/bloc/cubit/user_cubit.dart';
import 'package:fake_story/bloc/states/user_states.dart';
import 'package:fake_story/data/model/postmodel.dart';
import 'package:fake_story/screens/details_page.dart';
import 'package:fake_story/screens/profile.dart';
import 'package:fake_story/utils/app_constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:text_scroll/text_scroll.dart';
import '../bloc/getx/getx_controller.dart';

// ignore: prefer_const_constructors
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
    final Controller controller = Get.put(Controller());
    final myController = TextEditingController();
    final myPassController = TextEditingController();
    final myUserNameController = TextEditingController();

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
                    child: const Text(
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
                  const Text(
                    "Sign in to your account",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  GeneralWidgets()._emailPasswordWidget('login', myController,
                      myPassController, myUserNameController),
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
                  BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          EasyLoading.instance.userInteractions = false;
                          EasyLoading.show(status: 'loading...');
                          ProfilCalss.createToken(
                                  myController.text, myPassController.text)
                              .then((value) => {
                                    if (value)
                                      {
                                        EasyLoading.dismiss(),
                                        controller.setUserStateLoaded(),
                                        controller.setUserLoginState(),
                                        EasyLoading.showSuccess("Success"),
                                        Navigator.pop(context),
                                        Navigator.pop(context),
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => ProfilePage(),
                                            ))
                                      }
                                    else
                                      {
                                        EasyLoading.dismiss(),
                                        EasyLoading.showError(
                                            "Error while loading!"),
                                        controller.setUserStateError(),
                                      }
                                  });
                        },
                        child: GeneralWidgets()._submitButton(context, 'Login'),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      GeneralWidgets.showModalCreateAcc(context);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          "You don't have a account?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 3),
                        const Text(
                          "Register",
                          textAlign: TextAlign.center,
                          style: TextStyle(
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
    final myController = TextEditingController();
    final myPassController = TextEditingController();
    final myUserNameController = TextEditingController();
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
                    child: const Text(
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
                  const Text(
                    "Create an Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  GeneralWidgets()._emailPasswordWidget('register',
                      myController, myPassController, myUserNameController),
                  const SizedBox(height: 20),
                  BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return InkWell(
                          onTap: () async => {
                                if (myPassController.text.length >= 8)
                                  {
                                    EasyLoading.instance.userInteractions =
                                        false,
                                    EasyLoading.show(status: 'loading...'),
                                    await context
                                        .read<UserCubit>()
                                        .createUser(
                                            myUserNameController.text,
                                            myPassController.text,
                                            myController.text,
                                            "firstName",
                                            "lastname")
                                        .then((value) => {
                                              EasyLoading.instance
                                                  .userInteractions = true,
                                              EasyLoading.showSuccess(
                                                  'Great Success!'),
                                              Navigator.pop(context),
                                              GeneralWidgets.showModalLogin(
                                                  context)
                                            })
                                  }
                                else
                                  {
                                    EasyLoading.showError(
                                        "Pasword length must be greather than 8")
                                  }
                              },
                          child: GeneralWidgets()
                              ._submitButton(context, 'Create an account'));
                    },
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      GeneralWidgets.showModalLogin(context);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          "Already have an account?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 3),
                        const Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
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
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailPasswordWidget(
      String what,
      TextEditingController controller,
      TextEditingController passController,
      TextEditingController userNameController) {
    return Column(
      children: <Widget>[
        _entryField(what != "register" ? "Username" : "Email", controller),
        if (what == "register")
          _entryFieldRegisterUsername("Username", userNameController),
        _entryFieldPassword("Password", passController, isPassword: true),
      ],
    );
  }

  Widget _entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: double.infinity,
      child: TextField(
        controller: controller,
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

  Widget _entryFieldPassword(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: double.infinity,
      child: TextField(
        controller: controller,
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

  Widget _entryFieldRegisterUsername(
      String title, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: double.infinity,
      child: TextField(
        controller: controller,
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

  static void vipDialog(BuildContext context) async {
    vipTopFeatures() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/icons/square.png',
            width: 26,
            height: 26,
          ),
          const SizedBox(width: 10),
          const Text(
            "New feautures",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
        ],
      );
    }

    await Navigator.of(context).push(
      MaterialPageRoute<String>(
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Constants.primaryColor,
                elevation: 0,
                iconTheme: const IconThemeData(color: Color(0xff222222)),
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.restore)),
                ],
              ),
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        vipTopFeatures(),
                        const SizedBox(height: 10),
                        vipTopFeatures(),
                        const SizedBox(height: 10),
                        vipTopFeatures(),
                        const SizedBox(height: 10),
                        vipTopFeatures(),
                        const SizedBox(height: 10),
                        vipTopFeatures(),
                        const SizedBox(height: 10),
                        vipTopFeatures(),
                        const SizedBox(height: 20),
                        // ignore: prefer_const_constructors
                        Text(
                          "and much more",
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey.shade300,
                                )),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: Column(
                              children: [
                                const Text(
                                  "Monthly",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "\$9.99",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "Cancel anytime",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 1,
                                      color: Constants.themeColor,
                                    )),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    const Text(
                                      "Yearly",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      "\$99.9",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      "\$8.9 monthly",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: -12,
                                left: 0,
                                right: 0,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Constants.themeColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 3,
                                    ),
                                    child: const Text(
                                      "Save % 24",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.health_and_safety,
                          size: 18,
                          color: Colors.grey,
                        ),
                        const Text(
                          "The payment is securely allocated by the Play Store.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Constants.themeColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Pay Now",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "I'll do later",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Abonelik satın alarak gizlilk falan filan Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı oluştur",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          fullscreenDialog: true),
    );
  }

  static storyVideo(
    context,
    Size size,
    String? contentLink,
    String? createdDay,
    PostModel? postModel,
    viewer, {
    bool showCategory = true,
  }) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(postModel: postModel!),
          ),
        );
      }),
      child: FutureBuilder(
        future: GetThumbnailFromVideo.getLink(contentLink!),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var logger = Logger();
            logger.i(snapshot.data);
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
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              File(snapshot.data!),
                            )),
                      ),
                      width: double.infinity,
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
                                        color:
                                            const Color.fromRGBO(0, 0, 0, 0.45),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: const Text(
                                      "Cars",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                )
                              : Container(),

                          //time
                          Center(
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 6),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(180, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Icon(Icons.play_arrow_outlined)),
                          ),

                          /// tags
                          videoBottomInfo(viewer, createdDay!, postModel),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            var logger = Logger();
            logger.i("thumbnail Hata!");
            return Container();
          }
        },
      ),
    );
  }

  static storyPhoto(
    context,
    Size size,
    String? contentLink,
    String? createdDay,
    PostModel? postModel,
    viewer, {
    bool showCategory = true,
  }) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(postModel: postModel!),
          ),
        )
      },
      child: SizedBox(
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
                      contentLink!,
                    ),
                  ),
                ),
                child: Stack(
                  children: [
                    //category
                    showCategory
                        ? Positioned(
                            left: 10,
                            top: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 6),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(180, 255, 255, 255),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Text(
                                "Cars",
                                style: const TextStyle(
                                  color: Color(0xff111111),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    videoBottomInfo(viewer, createdDay!, postModel),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static videoBottomInfo(bool viewer, String createdDay, PostModel? postModel) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    //print(date);
    var postTime = DateTime.parse(createdDay);
    print(postTime);
    print(now);
    var differenceTime = now.difference(postTime).inMinutes;

    return Column(
      children: [
        const Spacer(),
        Container(
          color: Color.fromARGB(103, 0, 0, 0),
          child: Row(
            children: [
              differenceTime > 180
                  ? Text(
                      "Long time ago...",
                      style: TextStyle(
                          fontSize: viewer ? 10 : 9, color: Colors.white54),
                    )
                  : Text(
                      differenceTime.toString() + " minutes ago",
                      style: TextStyle(
                          fontSize: viewer ? 10 : 9, color: Colors.white54),
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
                          postModel!.like!.length.toString(),
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white54),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
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
            // Container(
            //   padding: const EdgeInsets.all(3),
            //   decoration: BoxDecoration(
            //       color: Colors.white, borderRadius: BorderRadius.circular(50)),
            //   child: SizedBox(
            //     height: 32,
            //     width: 32,
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(50),
            //       child: Image.network('https://picsum.photos/850',
            //           fit: BoxFit.cover),
            //     ),
            //   ),
            // ),
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
