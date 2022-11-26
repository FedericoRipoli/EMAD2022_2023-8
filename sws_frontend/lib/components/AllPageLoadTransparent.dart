import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'AllPageLoad.dart';

class AllPageLoadTransparent extends StatelessWidget{
  const AllPageLoadTransparent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      color: Colors.grey.withOpacity(0.9),
      child: const AllPageLoad()
    );
  }

}