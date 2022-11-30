import 'package:flutter/material.dart';

import '../../components/CustomAppBar.dart';
import '../../components/CustomFloatingButton.dart';
import '../../components/menu/DrawerMenu.dart';



class GestioneAmbiti extends StatefulWidget {
  const GestioneAmbiti({Key? key}) : super(key: key);
  static String id='it.unisa.emad.comunesalerno.sws.ipageutil.GestioneAmbiti';

  @override
  State<GestioneAmbiti> createState() => _GestioneAmbitiState();
}

class _GestioneAmbitiState extends State<GestioneAmbiti> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: DrawerMenu(currentPage: GestioneAmbiti.id),
        resizeToAvoidBottomInset: false,
        floatingActionButton: CustomFloatingButton(
            iconData: Icons.add,
            onPressed: () {

            }),
        appBar: const CustomAppBar(title:"Ambiti"),


    );
  }
  
}
