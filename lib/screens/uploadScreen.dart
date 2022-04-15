import 'dart:io';

import 'package:fake_story/screens/home.dart';
import 'package:fake_story/screens/splash_screen.dart';
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
  TextEditingController? _editingControllerCat;
  @override
  void initState() {
    super.initState();
    _editingControllerTitle = TextEditingController();
    _editingControllerDesc = TextEditingController();
    _editingControllerCat = TextEditingController();
  }

  @override
  void dispose() {
    _editingControllerTitle?.dispose();
    _editingControllerDesc?.dispose();
    _editingControllerCat?.dispose();
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
        body: SingleChildScrollView(
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
              const SizedBox(height: 15),
              const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Category",
                  )),
              Center(
                child: TextField(
                  onSubmitted: (newValue) {},
                  autofocus: true,
                  controller: _editingControllerCat,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                  width: 175,
                  child: ElevatedButton(
                      onPressed: controller.isUserLogin.value
                          ? () => {
                                // EasyLoading.showInfo(
                                //     "Post Creating Please Wait!",
                                //     duration:
                                //         const Duration(seconds: 1000000)),
                                //BURADAN OLUSTURULAN POSTUN ID SI DONECEK
                                UploadPageCalls.createPost(
                                        widget.filePath!,
                                        _editingControllerTitle!.text,
                                        false,
                                        _editingControllerDesc!.text,
                                        _editingControllerCat!.text)
                                    .then((value) => {
                                          if (value)
                                            {
                                              EasyLoading.showSuccess(
                                                  "Post Created!"),
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        MyHomePage(),
                                                  ))
                                            }
                                          else
                                            {
                                              EasyLoading.showError(
                                                  "Post creation failed!")
                                            }
                                        })
                              }
                          : showToast,
                      child: const Text("Create")))
            ],
          ),
        ));
  }

  void showToast() {
    EasyLoading.showToast("Please log in before create post!");
  }
}
