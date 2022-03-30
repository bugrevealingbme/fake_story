import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ProfileButton extends StatelessWidget {
  final String imagePath;
  final bool imagePathonNetwork;
  final BuildContext context;
  final double? width;
  final double? height;
  final Color? touchcolor;
  final Color? backgroundcolor;
  final Function onTap;
  final DefaultCacheManager manager;
  final Function? onDoubleTap;
  final Function? onLongPress;

  const ProfileButton(
      {required Key key,
      required this.context,
      required this.manager,
      required this.onLongPress,
      required this.imagePath,
      required this.imagePathonNetwork,
      required this.height,
      required this.width,
      required this.touchcolor,
      required this.onTap,
      required this.onDoubleTap,
      required this.backgroundcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5, bottom: 5),
      child: Material(
        color: backgroundcolor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        child: InkWell(
          splashColor: touchcolor ?? Colors.yellow,
          borderRadius: BorderRadius.circular(50),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: imagePathonNetwork
                ? CachedNetworkImage(
                    imageUrl: imagePath,
                    width: width ?? 46,
                    height: height ?? 46,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                            Radius.elliptical(9999.0, 9999.0)),
                        boxShadow: [
                          const BoxShadow(
                            color: Color(0x29000000),
                            offset: Offset(0, 2),
                            blurRadius: 2,
                          ),
                        ],
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Image.asset("/assets/logo/logo.png"),
                  )
                : Image(
                    image: AssetImage(imagePath),
                    width: width ?? 50,
                    height: height ?? 50,
                    fit: BoxFit.cover,
                  ),
          ),
          onTap: () {
            onTap();
          },
          onDoubleTap: () {
            print("Trigger onDoubleTap on Profile");
          },
          onLongPress: () {
            print("Trigger LongPress on Profile");
          },
        ),
      ),
    );
  }
}
