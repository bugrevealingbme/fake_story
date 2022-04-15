import 'dart:io';

import 'package:fake_story/api/video_thumbnail/thumbnail.dart';
import 'package:fake_story/data/model/postmodel.dart';
import 'package:fake_story/data/model/usermodel.dart';
import 'package:fake_story/screens/details_page.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ProfilePostWidgets {
  static postProfileWidget(
    context,
    Size size,
    MiniPost? miniPost,
    viewer, {
    bool showCategory = true,
  }) {
    return GestureDetector(
        onTap: (() {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(
                  postModel: PostModel(
                      id: miniPost?.id,
                      user: null,
                      isVideo: miniPost?.isVideo,
                      link: miniPost?.link,
                      language: null,
                      stream: null,
                      title: null,
                      like: null,
                      category: null,
                      favori: null,
                      createdAt: null)),
            ),
          );
        }),
        child: !miniPost!.isVideo!
            ? SizedBox(
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              miniPost.link!,
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
                                        color: const Color.fromARGB(
                                            180, 255, 255, 255),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Text(
                                        miniPost.title!,
                                        style: const TextStyle(
                                          color: Color(0xff111111),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
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
              )
            : FutureBuilder(
                future: GetThumbnailFromVideo.getLink(miniPost.link!),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                                color: const Color.fromRGBO(
                                                    0, 0, 0, 0.45),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: const Text(
                                              "",
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
                                          color: const Color.fromARGB(
                                              180, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: const Icon(
                                            Icons.play_arrow_outlined)),
                                  ),

                                  /// tags
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
              ));
  }
}
