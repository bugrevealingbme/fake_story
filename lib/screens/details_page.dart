import 'package:fake_story/api/api_calls/detail_page_calls.dart';
import 'package:fake_story/api/api_calls/profil_page_calls.dart';
import 'package:fake_story/bloc/getx/getx_controller.dart';
import 'package:fake_story/components/profile/profile_post_widget.dart';
import 'package:fake_story/data/model/postmodel.dart';
import 'package:fake_story/data/model/usermodel.dart';
import 'package:fake_story/screens/view_image.dart';
import 'package:fake_story/utils/app_constans.dart';
import 'package:fake_story/widgets/loading.dart';
import 'package:fake_story/widgets/videoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:video_player/video_player.dart';

class DetailsPage extends StatefulWidget {
  static const String id = "details_page";
  String? search;
  PostModel postModel;
  DetailsPage({Key? key, required this.postModel, this.search})
      : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final ScrollController _scrollController = ScrollController();
  bool isLoading = true;
  bool isLoadPage = false;
  bool downloading = false;
  var progressString = "";
  var logger = Logger();
  final imgUrl =
      "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4";
  VideoPlayerController? controller;
  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.network(widget.postModel.link!)
      ..initialize().then((_) {
        setState(() {});
      });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print(_scrollController.offset);
        print(_scrollController.position.pixels);
      }
    });
  }

  // Future<void> downloadFile() async {
  //   Dio dio = Dio();

  //   try {
  //     var dir = await getExternalStorageDirectory();
  //     print("path ${dir!.path}");
  //     await dio.download(imgUrl, "${dir.path}/demo.mp4",
  //         onReceiveProgress: (rec, total) {
  //       print("Rec: $rec , Total: $total");

  //       setState(() {
  //         downloading = true;
  //         progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
  //       });
  //     });
  //   } catch (e) {
  //     print(e);
  //   }

  //   print("Download completed");
  // }
  Future<bool> liked(dynamic data) async {
    UserModel user = await ProfilCalss.userInformations();
    var post = data;
    var getuserid = user.id!;
    for (var item in post.like!) {
      if (item.id == getuserid) {
        return true;
      }
    }
    return false;
  }

  Future<bool> saved(dynamic data) async {
    UserModel user = await ProfilCalss.userInformations();
    var post = data;
    var getuserid = user.id!;
    for (var item in post.favori!) {
      if (item.id == getuserid) {
        return true;
      }
    }
    return false;
  }

  Future<bool> follow(dynamic data) async {
    UserModel user = await ProfilCalss.userInformations();
    var post = data;
    var takipedilecek = post.user!.id!;
    for (var item in user.following!) {
      if (item.followingUserId?.id == takipedilecek) {
        return true;
      }
    }
    return false;
  }

  void snackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.pinkAccent,
        dismissDirection: DismissDirection.none,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 200,
            left: 15,
            right: 15),
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(height: 1.5),
        )));
  }

  bool viewer = false;
  bool like1 = false;
  bool saved1 = false;
  bool follow1 = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final Controller controllerGetx = Get.put(Controller());

    return FutureBuilder(
      future: DetailPageCalls.getPost(widget.postModel.id!),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          String cate = "";
          for (var item in snapshot.data.category) {
            cate = cate + "#" + item.title;
          }
          if (controllerGetx.isUserLogin.value) {
            liked(snapshot.data).then((value) =>
                {like1 = value, controllerGetx.likeTrueFalse(like1)});
            saved(snapshot.data).then((value) =>
                {saved1 = value, controllerGetx.saveTrueFalse(saved1)});
            follow(snapshot.data).then((value) =>
                {follow1 = value, controllerGetx.followTrueFalse(follow1)});
          }

          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
            floatingActionButton: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.black54),
                child: const Icon(Icons.chevron_left, color: Colors.white),
              ),
            ),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Container(),
              toolbarHeight: 0,
            ),
            body: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Constants.primaryColor,
                    ),
                    child: Column(
                      children: [
                        // #post_image
                        snapshot.data.isVideo
                            ? Container(
                                child: videoPlayer(context, controller!),
                              )
                            : Container(
                                child: ViewImage(
                                  url: snapshot.data.link,
                                ),
                              ),
                        const SizedBox(height: 5),

                        // #profile_info
                        Obx(() => ListTile(
                              title: Row(
                                children: [
                                  const Text("by"),
                                  const SizedBox(width: 4),
                                  GestureDetector(
                                    onTap: () {},
                                    // ignore: prefer_const_constructors
                                    child: Text(
                                      snapshot.data.user.username,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    progressString,
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  ),
                                  controllerGetx.isUserLogin.value
                                      ? TextButton(
                                          onPressed: (() {
                                            DetailPageCalls.likeUnlike(
                                                    snapshot.data.id)
                                                .then((value) => {
                                                      controllerGetx
                                                          .likeTrueFalse(
                                                              !controllerGetx
                                                                  .postLike
                                                                  .value)
                                                    });
                                          }),
                                          child: Text(
                                            controllerGetx.postLike.value
                                                ? "Liked"
                                                : "Like",
                                            // ignore: prefer_const_constructors
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        )
                                      : const Text(""),
                                  controllerGetx.isUserLogin.value
                                      ? TextButton(
                                          onPressed: (() {
                                            DetailPageCalls.favoriUnfavori(
                                                    snapshot.data.id)
                                                .then((value) => {
                                                      controllerGetx
                                                          .saveTrueFalse(
                                                              !controllerGetx
                                                                  .postSave
                                                                  .value)
                                                    });
                                          }),
                                          child: Text(
                                            controllerGetx.postSave.value
                                                ? "Saved"
                                                : "Save",
                                            // ignore: prefer_const_constructors
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        )
                                      : const Text(""),
                                ],
                              ),
                              trailing: controllerGetx.isUserLogin.value
                                  ? TextButton(
                                      onPressed: (() {
                                        DetailPageCalls.followUnfollow(
                                                snapshot.data.user.id)
                                            .then((value) => {
                                                  controllerGetx
                                                      .followTrueFalse(
                                                          !controllerGetx
                                                              .postFollow.value)
                                                });
                                      }),
                                      // ignore: prefer_const_constructors
                                      child: Text(
                                        controllerGetx.postFollow.value
                                            ? "Followed"
                                            : "Follow",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ))
                                  : const Text(""),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                cate,
                                style: TextStyle(color: Colors.blueAccent),
                              )),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: double.infinity,
                          // ignore: prefer_const_constructors
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Text(
                              snapshot.data.title,
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        // ignore: prefer_const_constructors
                        SizedBox(
                          width: double.infinity,
                          // ignore: prefer_const_constructors
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Text(
                              snapshot.data.description,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    decoration: const BoxDecoration(
                      color: Constants.primaryColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ignore: prefer_const_constructors
                        Text("More this category",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        snapshot.data.category.length != 0
                            ? FutureBuilder(
                                future: DetailPageCalls.getCategory(
                                    snapshot.data.category[0].id),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot2) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot2.data != null) {
                                    return GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: viewer ? 2 : 3,
                                        childAspectRatio: 0.571,
                                        crossAxisSpacing: Constants.gridSpacing,
                                        mainAxisSpacing: Constants.gridSpacing,
                                      ),
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: snapshot2.data.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return AspectRatio(
                                          aspectRatio: 0.571,
                                          child: ProfilePostWidgets
                                              .postProfileWidget(
                                                  context,
                                                  size,
                                                  MiniPost(
                                                      id: snapshot2
                                                          .data[index].id,
                                                      link: snapshot2
                                                          .data[index].link,
                                                      title: snapshot2
                                                          .data[index].title,
                                                      isVideo: snapshot2
                                                          .data[index].isVideo),
                                                  viewer),
                                        );
                                      },
                                    );
                                  } else {
                                    return const LoadingIndicator();
                                  }
                                },
                              )
                            : Container(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return const LoadingIndicator(
            text: "Loading",
          );
        }
      },
    );
  }
}
