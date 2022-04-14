import 'dart:io';

import 'package:fake_story/api/api_calls/profil_page_calls.dart';
import 'package:fake_story/components/profile/profile_post_widget.dart';
import 'package:fake_story/utils/app_constans.dart';
import 'package:fake_story/widgets/loading.dart';
import 'package:fake_story/widgets/require_login.dart';
import 'package:fake_story/widgets/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../bloc/getx/getx_controller.dart';

import 'package:flutter/foundation.dart';

import '../data/model/usermodel.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

showLoginDialog(BuildContext context) {
  GeneralWidgets.showModalLogin(context);
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  int _selectedTag = 0;
  bool viewer = false;
  late TabController _tabController;
  File? _image;
  final picker = ImagePicker();
  final Controller controller = Get.put(Controller());
  UserModel? data;

  @override
  void initState() {
    _tabController = TabController(vsync: this, initialIndex: 0, length: 3);

    super.initState();
  }

  Future getImage() async {
    final choice = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                "Profil Fotoğrafınızın Türü nedir",
                style: TextStyle(color: Colors.black),
              ),
              content: SingleChildScrollView(
                  child: ListBody(
                children: const <Widget>[
                  Text('Yüklemek istediğiniz fotoğrafın türünü seçiniz'),
                ],
              )),
              actions: [
                // ignore: deprecated_member_use
                TextButton(
                    onPressed: () => Navigator.pop(context, "jpeg"),
                    child: const Text("Jpeg/Png")),
                // ignore: deprecated_member_use
                TextButton(
                    onPressed: () => Navigator.pop(context, "gif"),
                    child: const Text("gif")),
              ],
            ));
    if (choice == "jpeg") {
      final pickedFile =
          await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
      setState(() async {
        if (pickedFile != null) {
          print("aldı imageyi");
          _image = File(pickedFile.path);
          var alpha = await ProfilCalss.profilPhotoUpload(pickedFile.path);
          if (alpha != null) {
            setState(() {});
          }
        } else {
          print('No image selected.');
        }
      });
    } else if (choice == "gif") {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ["gif"]);
      if (result != null) {
        setState(() {
          _image = File(result.files.single.path!);

          // AnimesonApiManager().uploadProfilePic(_image, _userid).then((value) {
          //   if (value == 200) {
          //     print("çalıştı");
          //     AppProviderContainer.userDataProvider.setProfilepicFile(_image);
          //   } else {
          //     print("error");
          //   }
          // });
        });
      } else {
        print("seçim yapılmamış");
      }
    } else {
      print("Seçim yapılmamış");
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Constants.primaryColor,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color(0xffF2F4F5),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xff222222)),
        actions: [
          Center(
            child: Wrap(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.settings,
                    color: Colors.black,
                    size: 22,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: FutureBuilder(
                future: ProfilCalss.userInformations().then((value) => {
                      controller.setUserModel(value),
                      controller
                          .setMiniPostList(controller.userModel[0].likeRelated)
                    }),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data != null) {
                    var logger = Logger();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: SizedBox(
                                    height: 64,
                                    width: 64,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                          controller.userModel[0].profileRelate
                                              .profileimage,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Text(
                                        controller.userModel[0].username,
                                        // ignore: prefer_const_constructors
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        controller
                                            .userModel[0].profileRelate.bio,
                                        // ignore: prefer_const_constructors
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // ignore: prefer_const_constructors
                                    Text(
                                      controller.userModel[0].postRelated.length
                                          .toString()
                                          .toString(),
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      "Stories",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 20),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      controller.userModel[0].followers.length
                                          .toString(),
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      "Followers",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 20),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      controller.userModel[0].following.length
                                          .toString(),
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      "Following",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const SizedBox(width: 15),
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: PopupMenuButton(
                                  icon: const Icon(Icons.more_horiz_rounded),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  elevation: 0.721,
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 1,
                                      child: Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          const Text("Report"),
                                          const SizedBox(width: 10),
                                          const Spacer(),
                                          const Icon(Icons.flag_outlined),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 2,
                                      child: Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          const Text("Block"),
                                          const SizedBox(width: 10),
                                          const Spacer(),
                                          const Icon(Icons.block_rounded),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Theme(
                              data: ThemeData(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                              ),
                              child: TabBar(
                                controller: _tabController,
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color(0xfff0dff3),
                                ),
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 0),
                                padding: const EdgeInsets.all(0),
                                indicatorPadding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 4),
                                labelColor: Colors.black,
                                labelStyle: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                                unselectedLabelColor:
                                    const Color.fromARGB(255, 139, 139, 139),
                                unselectedLabelStyle: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                                isScrollable: true,
                                onTap: (value) {
                                  print(value);
                                  logger.i(controller.miniPostList.length);
                                  //Burada controler dolacak
                                  if (value == 0) {
                                    logger
                                        .i(controller.userModel[0].likeRelated);
                                    controller.setMiniPostList(
                                        controller.userModel[0].likeRelated);
                                  } else if (value == 1) {
                                    logger.i(
                                        controller.userModel[0].favoriRelated);
                                    controller.setMiniPostList(
                                        controller.userModel[0].favoriRelated);
                                  } else {
                                    logger
                                        .i(controller.userModel[0].postRelated);
                                    controller.setMiniPostList(
                                        controller.userModel[0].postRelated);
                                  }
                                },
                                // ignore: prefer_const_literals_to_create_immutables
                                tabs: <Widget>[
                                  const Tab(
                                    text: "Liked",
                                  ),
                                  const Tab(
                                    text: "Saved",
                                  ),
                                  const Tab(
                                    text: "Uploads",
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                print(_tabController.index);
                                setState(() {
                                  viewer = viewer ? false : true;
                                });
                              },
                              child: GeneralWidgets.viewerContainer(viewer),
                            ),
                          ],

                          //Gridviewo burasi
                        ),
                        const SizedBox(height: 15),
                        FutureBuilder(builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (controller.userModel.isNotEmpty) {
                            var logger = Logger();
                            logger.i("profil data dolu");
                            return Obx(() => GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: viewer ? 2 : 3,
                                    childAspectRatio: 0.571,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                  ),
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: controller.miniPostList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (controller.isUserLogin.value) {
                                      return ProfilePostWidgets
                                          .postProfileWidget(
                                              context,
                                              size,
                                              controller.miniPostList[index],
                                              viewer);
                                    } else {
                                      return forceLogin(context);
                                    }
                                  },
                                ));
                          } else {
                            logger.i("profil data bos");
                            return const Text("asd");
                          }
                        })
                      ],
                    );
                  } else {
                    if (controller.isUserLogin.value) {
                      return const Center(child: LoadingIndicator());
                    } else {
                      return forceLogin(context);
                    }
                  }
                })),
      ),
    );
  }
}
