import 'package:flutter/material.dart';
import 'package:frontend_sws/main.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Sezione Mappa"),
      ),
    );
  }
}
