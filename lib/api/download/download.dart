import 'dart:async';
import 'dart:io';
import 'package:android_path_provider/android_path_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'dart:isolate';
import 'dart:ui';
import 'package:permission_handler/permission_handler.dart';

import '../../provider/app_provider.dart';
import '../../widgets/loading.dart';

class DownloaderNotifier extends ChangeNotifier {
  static List<DownloadTask> downloadingList = [];
  ReceivePort _port = ReceivePort();

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  void remove(String taskId) {
    FlutterDownloader.remove(taskId: taskId);
    notifyListeners();
  }

  void initDownloader() async {
    try {
      IsolateNameServer.registerPortWithName(
          _port.sendPort, 'downloader_send_port');
      _port.listen((dynamic data) {});
      FlutterDownloader.registerCallback(downloadCallback);
      print("Downloader channel yapılandırıldı");
    } catch (e) {
      print("Downloader channelin yapılandırılmasında hata oluştu HATA:" +
          e.toString());
    }
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  Future<String> _localPath() async {
    var _localPath =
        (await _findLocalPath()) + Platform.pathSeparator + 'fakestory';
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    return _localPath;
  }

  Future<String> _createStoryFolder(String folderName) async {
    var localpath = await _localPath();
    final savedDir = Directory(localpath + Platform.pathSeparator + folderName);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    return savedDir.path;
  }

  static Future<String> _findLocalPath() async {
    final directory = await AndroidPathProvider.downloadsPath;
    if (!await Directory(directory).exists()) {
      Directory(directory).create();
    }
    return directory;
  }

  Future<bool> _checkPermission() async {
    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      final result = await Permission.storage.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  Future<List<DownloadTask>?> getAllDownloads() async {
    final tasks = await FlutterDownloader.loadTasks();
    return tasks;
  }

  Future<void> addQueue(String url, String currentName, String savename) async {
    var permissionStatus = await _checkPermission();
    var _savename = _reformatter(savename);
    var _filename = _reformatter(currentName);
    if (permissionStatus) {
      await FlutterDownloader.enqueue(
        url: url,
        fileName: _savename + ".mp4",
        savedDir: await _createStoryFolder(_filename),
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
      notifyListeners();
    } else {
      print("Uygulama depolama izinine sahip değil");
    }
  }

  static void downloader(String url, String currentName, String fileName,
      BuildContext context) async {
    try {
      showLoadingIndicator("İndiriliyor", context);

      await AppProviderContainer.downloaderNotifier
          .addQueue(url, currentName, fileName);
    } catch (e) {
      print(e);
    } finally {
      hideOpenDialog(context);
    }
  }

  static void showLoadingIndicator(String text, BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            // ignore: prefer_const_constructors
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8.0))),
            backgroundColor: Colors.black87,
            content: LoadingIndicator(text: text),
          ),
        );
      },
    );
  }

  static void hideOpenDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  String _reformatter(String text) {
    var reFormattedText = text;
    RegExp textRegex = RegExp(r"(\W)");
    reFormattedText = reFormattedText.replaceAll(textRegex, "");
    print("reformattedText: " + reFormattedText);
    return reFormattedText;
  }

  List<DownloadTask> get list => downloadingList;
}
