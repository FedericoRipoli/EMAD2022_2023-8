import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AllPageLoad extends StatelessWidget{
  const AllPageLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          size: 80,
          color: appTheme.primaryColor,
        ));
  }

}