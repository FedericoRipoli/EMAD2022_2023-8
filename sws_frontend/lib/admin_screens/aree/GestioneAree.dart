import 'package:flutter/material.dart';

import '../../components/CustomAppBar.dart';
import '../../components/CustomFloatingButton.dart';
import '../../components/menu/DrawerMenu.dart';



class GestioneAree extends StatefulWidget {
  const GestioneAree({Key? key}) : super(key: key);
  static String id='it.unisa.emad.comunesalerno.sws.ipageutil.GestioneAree';

  @override
  State<GestioneAree> createState() => _GestioneAreeState();
}

class _GestioneAreeState extends State<GestioneAree> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: DrawerMenu(currentPage: GestioneAree.id),
        resizeToAvoidBottomInset: false,
        floatingActionButton: CustomFloatingButton(
            iconData: Icons.add,
            onPressed: () {

            }),
        appBar: const CustomAppBar(title:"Ambiti"),


    );
  }
  
}
