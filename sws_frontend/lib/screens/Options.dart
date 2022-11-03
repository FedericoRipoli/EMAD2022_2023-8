import 'package:flutter/material.dart';
import 'package:frontend_sws/main.dart';

class Options extends StatelessWidget {
  const Options({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: appTheme.primaryColor,
          ),
          iconSize: 28,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Impostazioni App',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
        ),
      ),
      body: const Center(
        child: Text("Opzioni App"),
      ),
    );
  }
}
