import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_story/screens/view_image.dart';
import 'package:fake_story/utils/app_constans.dart';
import 'package:fake_story/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DetailsPage extends StatefulWidget {
  static const String id = "details_page";
  String imageUrl;
  String? search;

  DetailsPage({Key? key, required this.imageUrl, this.search})
      : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final ScrollController _scrollController = ScrollController();
  bool isLoading = true;
  bool isLoadPage = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          isLoadPage = true;
        });
      }
    });
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: 45.0,
          width: 45.0,
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
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  // #post_image
                  ClipRRect(
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: widget.imageUrl,
                          placeholder: (context, url) =>
                              Image.asset("assets/images/default.png"),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/default.png"),
                        ),
                      ],
                    ),
                  ),

                  // #profile_info
                  ListTile(
                    title: Row(
                      children: [
                        Text("by"),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Abuzer",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    trailing: MaterialButton(
                      elevation: 0,
                      height: 40,
                      onPressed: () {},
                      color: Colors.grey.shade200,
                      child: const Text(
                        "Follow",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),

                  // #save_view_buttons
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: MaterialButton(
                          elevation: 0,
                          height: 50,
                          onPressed: () {},
                          color: Constants.themeColor,
                          shape: const StadiumBorder(),
                          child: Text(
                            "Download",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("More like this",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 15,
                  ),
                  MasonryGridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 8,
                      crossAxisCount: 3,
                      primary: false,
                      mainAxisSpacing: Constants.gridSpacing,
                      crossAxisSpacing: Constants.gridSpacing,
                      itemBuilder: (context, index) {
                        return AspectRatio(
                          aspectRatio: 0.571,
                          child: GeneralWidgets.storyVideo(
                            context,
                            size,
                            viewer,
                            showCategory: false,
                          ),
                        );
                      }),
                  (isLoading || isLoadPage)
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox.shrink(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
