import 'dart:typed_data';

import 'package:video_thumbnail/video_thumbnail.dart';

class GetThumbnailFromVideo {
  static Future<String> getLink(String link) async {
    final fileName = await VideoThumbnail.thumbnailFile(
      video: link,
      imageFormat: ImageFormat.WEBP,
      maxHeight:
          250, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
    print("thumbnail get");
    return fileName!;
  }
}
