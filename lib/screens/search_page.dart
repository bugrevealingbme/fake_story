import 'package:fake_story/api/api_calls/home_calls.dart';
import 'package:fake_story/utils/app_constans.dart';
import 'package:fake_story/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fake_story/utils/shared_prefs_ext.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../api/api_calls/detail_page_calls.dart';
import '../bloc/getx/getx_controller.dart';
import '../components/profile/profile_post_widget.dart';
import '../data/model/usermodel.dart';
import '../languages.dart';
import '../widgets/loading.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  bool viewer = false;
  late TabController _tabController;
  String suffixText = "EN";
  String searchText = "";
  List<MiniPost> miniList = [];

  final Controller controller = Get.put(Controller());
  @override
  void initState() {
    _tabController = TabController(vsync: this, initialIndex: 0, length: 3);

    super.initState();
  }

  @override
  void dispose() {
    miniList.clear();
    controller.setMiniSearchPostList(miniList);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var logger = Logger();
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: const Color(0xffF2F4F5),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xff222222)),
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: const TextStyle(
                            color: Color(0xff8f8f8f), fontSize: 17),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 0.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xff8f8f8f),
                        ),
                        // suffixText: suffixText,
                        // suffixIcon: IconButton(
                        //   icon: const Icon(
                        //     Icons.arrow_drop_down,
                        //     color: const Color(0xff8f8f8f),
                        //   ),
                        //   onPressed: () {
                        //     showDialog(
                        //         context: context,
                        //         builder: (BuildContext context) =>
                        //             _buildPopupDialog(context));
                        //   },
                        // ),
                      ),
                      onChanged: (val) {
                        if (val.length > 2) {
                          setState(() {
                            searchText = val;
                          });
                          _tabController.index = 0;
                          HomeCall.getSearchPostList(
                                  val, false, "created_at", true)
                              .then((value) => {
                                    if (value != null)
                                      {
                                        miniList.clear(),
                                        for (var item in value)
                                          {
                                            miniList.add(MiniPost(
                                                id: item.id,
                                                link: item.link,
                                                title: item.title,
                                                isVideo: item.isVideo))
                                          },
                                        controller
                                            .setMiniSearchPostList(miniList)
                                      }
                                  });
                        } else if (val.isEmpty) {
                          miniList.clear();
                          controller.setMiniSearchPostList(miniList);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                      onPressed: () {
                        miniList.clear();
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 16),
                      )),
                ],
              ),
              //const SizedBox(height: 30),
              // GeneralWidgets.crtLabel('Categories'),
              // const SizedBox(height: 15),
              // FutureBuilder(
              //   future: HomeCall.getListCategory(),
              //   builder:
              //       (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              //     if (snapshot.data != null &&
              //         snapshot.connectionState == ConnectionState.done) {
              //       List<Widget> categoryList = [];
              //       for (var item in snapshot.data) {
              //         categoryList.add(GeneralWidgets.categoryC(item.title));
              //       }
              //       if (categoryList.isNotEmpty) {
              //         return SingleChildScrollView(
              //           scrollDirection: Axis.horizontal,
              //           child: Row(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: categoryList,
              //           ),
              //         );
              //       } else {
              //         return Container();
              //       }
              //     } else {
              //       return Container();
              //     }
              //   },
              // ),
              const SizedBox(height: 30),
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
                          fontSize: 16, fontWeight: FontWeight.w500),
                      unselectedLabelColor:
                          const Color.fromARGB(255, 139, 139, 139),
                      unselectedLabelStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                      isScrollable: true,
                      onTap: (index) {
                        print(index);
                        switch (index) {
                          case 0:
                            if (searchText.length > 2) {
                              HomeCall.getSearchPostList(
                                      searchText, false, "created_at", true)
                                  .then((value) => {
                                        if (value != null)
                                          {
                                            miniList.clear(),
                                            for (var item in value)
                                              {
                                                miniList.add(MiniPost(
                                                    id: item.id,
                                                    link: item.link,
                                                    title: item.title,
                                                    isVideo: item.isVideo))
                                              },
                                            controller
                                                .setMiniSearchPostList(miniList)
                                          }
                                      });
                            } else if (searchText.isEmpty) {
                              miniList.clear();
                              controller.setMiniSearchPostList(miniList);
                            }

                            break;

                          case 1:
                            if (searchText.length > 2) {
                              HomeCall.getSearchPostList(
                                      searchText, true, "created_at", false)
                                  .then((value) => {
                                        if (value != null)
                                          {
                                            miniList.clear(),
                                            for (var item in value)
                                              {
                                                miniList.add(MiniPost(
                                                    id: item.id,
                                                    link: item.link,
                                                    title: item.title,
                                                    isVideo: item.isVideo))
                                              },
                                            controller
                                                .setMiniSearchPostList(miniList)
                                          }
                                      });
                            } else if (searchText.isEmpty) {
                              miniList.clear();
                              controller.setMiniSearchPostList(miniList);
                            }
                            break;
                          case 2:
                            if (searchText.length > 2) {
                              HomeCall.getSearchPostList(
                                      searchText, false, "created_at", false)
                                  .then((value) => {
                                        if (value != null)
                                          {
                                            miniList.clear(),
                                            for (var item in value)
                                              {
                                                miniList.add(MiniPost(
                                                    id: item.id,
                                                    link: item.link,
                                                    title: item.title,
                                                    isVideo: item.isVideo))
                                              },
                                            controller
                                                .setMiniSearchPostList(miniList)
                                          }
                                      });
                            } else if (searchText.isEmpty) {
                              miniList.clear();
                              controller.setMiniSearchPostList(miniList);
                            }
                            break;

                          default:
                        }
                      },
                      // ignore: prefer_const_literals_to_create_immutables
                      tabs: <Widget>[
                        const Tab(
                          text: "All",
                        ),
                        const Tab(
                          text: "Videos",
                        ),
                        const Tab(
                          text: "Photos",
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
              Obx(() => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: viewer ? 2 : 3,
                      childAspectRatio: 0.571,
                      crossAxisSpacing: Constants.gridSpacing,
                      mainAxisSpacing: Constants.gridSpacing,
                    ),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: controller.miniSerachPostList.length,
                    itemBuilder: (context, index) {
                      return AspectRatio(
                        aspectRatio: 0.571,
                        child: ProfilePostWidgets.postProfileWidget(
                            context,
                            size,
                            MiniPost(
                                id: controller.miniSerachPostList[index].id,
                                link: controller.miniSerachPostList[index].link,
                                title:
                                    controller.miniSerachPostList[index].title,
                                isVideo: controller
                                    .miniSerachPostList[index].isVideo),
                            viewer),
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  final List<String> _languages = [
    'English',
    'Espanol',
    'Turkish',
    'Portogues'
  ];
  return AlertDialog(
    title: const Text('Choose Your Language'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 200,
          height: 200,
          child: ListView.builder(
              itemCount: LocalizationService.langs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: TextButton(
                    onPressed: () {
                      switch (LocalizationService.langs[index].toString()) {
                        case "English":
                          CustomSharedPref.writeStringDataToSharedPref(
                              "languageData", "en_us");

                          Navigator.of(context).pop();
                          break;
                        case "Türkçe":
                          CustomSharedPref.writeStringDataToSharedPref(
                              "languageData", "tr_TR");
                          Navigator.of(context).pop();
                          break;
                        case "日本語":
                          // LocalizationService().changeLocale("日本語");
                          CustomSharedPref.writeStringDataToSharedPref(
                              "languageData", "ja_JP");
                          Navigator.of(context).pop();
                          break;
                        default:
                      }

                      print(LocalizationService.langs[index].toString());
                    },
                    child: Text(
                      LocalizationService.langs[index],
                    ),
                  ),
                );
              }),
        )
      ],
    ),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
}
