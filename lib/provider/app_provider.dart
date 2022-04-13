import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../api/download/download.dart';

class AppProviderContainer {
  static DownloaderNotifier downloaderNotifier = DownloaderNotifier();
  // ignore: prefer_final_fields
  static List<SingleChildWidget> _providersList = [
    ChangeNotifierProvider(create: (_) => downloaderNotifier),
  ];
  void init() {
    downloaderNotifier.initDownloader();
  }

  static List<SingleChildWidget> get providerlist => _providersList;
}
