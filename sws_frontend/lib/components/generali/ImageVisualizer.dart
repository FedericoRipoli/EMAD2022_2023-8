import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageVisualizer extends StatelessWidget {
  String defaultImage = "images/img_placeholder.jpg";
  final String tag;
  //final String imgPath;
  ImageVisualizer({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 20.0,
      ),
      height: 200.0,
      child: ClipRect(
        child: PhotoView(
          imageProvider: AssetImage(defaultImage),
          maxScale: PhotoViewComputedScale.covered * 2.0,
          minScale: PhotoViewComputedScale.contained * 0.8,
          initialScale: PhotoViewComputedScale.covered,
        ),
      ),
    );
  }
}
