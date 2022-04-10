import 'dart:io';

import 'package:fake_story/bloc/cubit/user_cubit.dart';
import 'package:fake_story/utils/app_constans.dart';
import 'package:fake_story/utils/string.extension.dart';
import 'package:fake_story/widgets/navbar.dart';
import 'package:fake_story/widgets/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/states/user_states.dart';
import '../utils/shared_prefs_ext.dart';

import 'package:flutter/foundation.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  int _selectedTag = 0;
  bool viewer = false;
  late TabController _tabController;
  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    _tabController = TabController(vsync: this, initialIndex: 0, length: 3);

    super.initState();
    CustomSharedPref.readStringDataToSharedPref("accessToken")
        .then((value) => {context.read<UserCubit>().getCurrentUser(value!)});
  }

  Future getImage() async {
    final choice = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
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
                    child: Text("Jpeg/Png")),
                // ignore: deprecated_member_use
                TextButton(
                    onPressed: () => Navigator.pop(context, "gif"),
                    child: Text("gif")),
              ],
            ));
    if (choice == "jpeg") {
      final pickedFile =
          await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
      setState(() {
        if (pickedFile != null) {
          print("aldı imageyi");
          _image = File(pickedFile.path);
          // AnimesonApiManager().uploadProfilePic(_image, _userid).then((value) {
          //   if (value == 200) {
          //     print("çalıştı");
          //     AppProviderContainer.userDataProvider.setProfilepicFile(_image);
          //   } else {
          //     print("error");
          //   }
          // });
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
          child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UserErrorState) {
              return const Center(child: Text("data"));
            }
            if (state is UserLoadedState) {
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
                                    'https://picsum.photos/850',
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.userData.username!,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  state.userData.profileRelate!.bio!,
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
                              Text(
                                "state.userData.profileRelate!.length.toString()",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
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
                                " state.userData.followers!.length.toString()",
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
                                "  state.userData.following!.length.toString()",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
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
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Follow",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          style: ButtonStyle(
                            //backgroundColor: MaterialStateProperty.all<Color>(color),
                            elevation: MaterialStateProperty.all(0),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                          setState(() {
                            viewer = viewer ? false : true;
                          });
                        },
                        child: GeneralWidgets.viewerContainer(viewer),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  GridView.count(
                    crossAxisCount: viewer ? 2 : 3,
                    childAspectRatio: 0.571,
                    shrinkWrap: true,
                    primary: false,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: <Widget>[
                      GeneralWidgets.storyVideo(
                          context, size, null, null, null, viewer,
                          showCategory: false),
                      GeneralWidgets.storyVideo(
                          context, size, null, null, null, viewer,
                          showCategory: false),
                      GeneralWidgets.storyVideo(
                          context, size, null, null, null, viewer,
                          showCategory: false),
                      GeneralWidgets.storyVideo(
                          context, size, null, null, null, viewer,
                          showCategory: false),
                    ],
                  ),
                ],
              );
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
          }),
        ),
      ),
    );
  }
}
