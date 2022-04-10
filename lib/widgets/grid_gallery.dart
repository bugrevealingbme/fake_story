import 'dart:io';
import 'dart:typed_data';

import 'package:fake_story/api/api_calls/upload_page_calls.dart';
import 'package:fake_story/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

class GridGallery extends StatefulWidget {
  final ScrollController? scrollCtr;

  const GridGallery({
    Key? key,
    this.scrollCtr,
  }) : super(key: key);

  @override
  _GridGalleryState createState() => _GridGalleryState();
}

class _GridGalleryState extends State<GridGallery>
    with SingleTickerProviderStateMixin {
  final List<Widget> _mediaList = [];
  int currentPage = 0;
  int? lastPage;

  @override
  void initState() {
    super.initState();

    _fetchNewMedia();
  }

  _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (currentPage != lastPage) {
        _fetchNewMedia();
      }
    }
  }

  _fetchNewMedia() async {
    lastPage = currentPage;
    var result = await PhotoManager.requestPermission();
    if (result) {
      // success

      //load the album list
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.common,
      );
      List<AssetEntity> media = await albums[0].getAssetListPaged(
        currentPage,
        60,
      ); //preloading files
      List<Widget> temp = [];
      for (var asset in media) {
        temp.add(
          FutureBuilder(
            future: asset.thumbDataWithSize(200, 200), //resolution of thumbnail
            builder:
                (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return InkWell(
                  onTap: () {
                    asset.file.then((value) => {
                          if (asset.type == AssetType.video)
                            {
                              UploadPageCalls.createPost(
                                  value!.path, "testtt", "tr_TR", true)
                            }
                          else
                            {
                              UploadPageCalls.createPost(
                                  value!.path, "testtt", "tr_TR", false)
                            }
                        });
                    /*  setState(() {
                      Navigator.of(context).pop();
                      pickedFile = asset.file;
                      secildi = true;
                      widget.callback(pickedFile);
                    }); */
                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image.memory(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (asset.type == AssetType.video)
                        const Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 5, bottom: 5),
                            child: Icon(
                              Icons.videocam,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        );
      }
      setState(() {
        _mediaList.addAll(temp);
        currentPage++;
      });
    } else {
      // fail
      /// if result is fail, you can call `PhotoManager.openSetting();`  to open android/ios applicaton's setting to get permission
    }
  }

  void callback(Future<File?> pickedFile) {
    setState(() {
      pickedFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scroll) {
        _handleScrollEvent(scroll);
        return false;
      },
      child: GridView.builder(
          controller: widget.scrollCtr,
          itemCount: _mediaList.length,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          primary: false,
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4),
          itemBuilder: (BuildContext context, int index) {
            return Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white)),
                child: _mediaList[index]);
          }),
    );
  }
}

Future<void> gallerySheet(BuildContext context) {
  return showModalBottomSheet<void>(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25))),
    context: context,
    isScrollControlled: true,
    enableDrag: true,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 50,
              height: 4,
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffcccccc),
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                        ),
                        const Spacer(),
                        GeneralWidgets.srtLabel("Recent Photos"),
                        const Spacer(),
                        IconButton(
                          onPressed: () async {
                            final picked = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (picked == null) {
                              return;
                            }
                            final image = File(picked.path);
                            print(image);

                            /*  setState(() {
                                  pickedimage = image;
                                  gsecildi = true;
                                  Navigator.of(context).pop();
                                }); */
                          },
                          icon: const Icon(Icons.more_vert),
                        ),
                      ],
                    ),
                    GridGallery(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
