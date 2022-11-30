import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:getwidget/getwidget.dart';
import 'package:frontend_sws/theme/theme.dart';

import '../components/CustomAppBar.dart';

class InfoApp extends StatelessWidget {
  const InfoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:const CustomAppBar(title:"Informazioni"),
        extendBodyBehindAppBar: false,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            //padding: const EdgeInsets.only(top: 0, left: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: <Widget>[
                    ClipPath(
                      clipper: WaveClipperTwo(flip: true),
                      child: Container(
                        height: 150,
                        color: AppColors.logoBlue,
                      ),
                    ),
                    const Center(
                      child: Text("Info App, Privacy Policy e il resto"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
