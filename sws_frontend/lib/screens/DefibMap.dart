import 'package:flutter/material.dart';
import 'package:frontend_sws/components/generali/CustomAppBar.dart';
import '../theme/theme.dart';

class DefibMap extends StatelessWidget {
  const DefibMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        iconData: Icons.arrow_back,
        title: AppTitle(
          label: 'Info',
        ),
      ),
      body: Center(
        child: Text("Salerno Amica"),
      ),
    );
  }
}
