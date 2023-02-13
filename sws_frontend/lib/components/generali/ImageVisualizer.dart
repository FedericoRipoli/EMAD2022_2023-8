import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageVisualizer extends StatelessWidget {
  String defaultImage = "images/img_placeholder.jpg";
  final String imageData;
  String? tag;
  //final String imgPath;
  ImageVisualizer({Key? key, this.tag, required this.imageData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 20.0,
      ),
      height: 400,
      child: ClipRect(
        child: PhotoView(
          backgroundDecoration: BoxDecoration(color: Colors.white),
          imageProvider: Image.memory(
            convertBase64Image(imageData),
            gaplessPlayback: true,
          ).image,
          maxScale: PhotoViewComputedScale.covered * 2.0,
          minScale: PhotoViewComputedScale.contained * 0.8,
          initialScale: PhotoViewComputedScale.contained,
        ),
      ),
    );
  }

  Uint8List convertBase64Image(String base64String) {
    return const Base64Decoder().convert(base64String.split(',').last);
  }
}
// Image.memory(base64Decode(widget.evento.locandina!.imageData)),
