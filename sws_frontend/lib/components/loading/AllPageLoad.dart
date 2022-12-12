import 'package:flutter/material.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AllPageLoad extends StatelessWidget {
  const AllPageLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child:
            LoadingAnimationWidget.beat(size: 80, color: AppColors.logoBlue));
  }
}
