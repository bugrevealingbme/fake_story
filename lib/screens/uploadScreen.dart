import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../api/api_calls/upload_page_calls.dart';

class UploadPage extends StatefulWidget {
  String? filePath;
  UploadPage({Key? key, this.filePath}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  bool beforeCreatedPost = true;
  TextEditingController? _editingControllerTitle;
  TextEditingController? _editingControllerDesc;
  @override
  void initState() {
    super.initState();
    _editingControllerTitle = TextEditingController();
    _editingControllerDesc = TextEditingController();
  }

  @override
  void dispose() {
    _editingControllerTitle?.dispose();
    _editingControllerDesc?.dispose();
    super.dispose();
  }

  void updateCreateState() {
    setState(() {
      beforeCreatedPost = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Create Post"),
        ),
        body: beforeCreatedPost
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Image(
                        image: FileImage(File(widget.filePath!)),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const SizedBox(
                        width: double.infinity,
                        // ignore: unnecessary_const
                        child: const Text(
                          "Title",
                        )),
                    Center(
                      child: TextField(
                        onSubmitted: (newValue) {},
                        autofocus: true,
                        controller: _editingControllerTitle,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Description",
                        )),
                    Center(
                      child: TextField(
                        onSubmitted: (newValue) {},
                        autofocus: true,
                        controller: _editingControllerDesc,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                        width: 175,
                        child: ElevatedButton(
                            onPressed: () async => {
                                  EasyLoading.showInfo(
                                      "Post Creating Please Wait!",
                                      duration:
                                          const Duration(seconds: 1000000)),
                                  //BURADAN OLUSTURULAN POSTUN ID SI DONECEK
                                  await UploadPageCalls.createPost(
                                    widget.filePath!,
                                    _editingControllerTitle!.text,
                                    false,
                                    _editingControllerDesc!.text,
                                  ),
                                  EasyLoading.dismiss(),
                                  updateCreateState(),
                                },
                            child: const Text("Create")))
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Categories",
                        )),
                    Center(
                      child: TextField(
                        onSubmitted: (newValue) {},
                        autofocus: true,
                        controller: _editingControllerDesc,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                        width: 175,
                        child: ElevatedButton(
                            onPressed: () => {
                                  EasyLoading.showInfo(
                                      "Post Uploading Please Wait!",
                                      duration:
                                          const Duration(seconds: 1000000)),
                                  //##### CATEGORILERIN BASINMA ### EKLENECEK
                                  // UploadPageCalls.createPost(
                                  //   widget.filePath!,
                                  //   _editingControllerTitle!.text,
                                  //   false,
                                  //   _editingControllerDesc!.text,
                                  // ).then((value) => {
                                  //       if (value)
                                  //         {EasyLoading.dismiss()}
                                  //       else
                                  //         {EasyLoading.showError("Failed!")}
                                  //     })
                                },
                            child: const Text("Add Categories")))
                  ],
                ),
              ));
  }
}
