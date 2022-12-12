import 'package:flutter/material.dart';
import 'AllPageLoad.dart';

class AllPageLoadTransparent extends StatelessWidget {
  const AllPageLoadTransparent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.withOpacity(0.6), child: const AllPageLoad());
  }
}
