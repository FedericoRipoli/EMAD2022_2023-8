import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_sws/main.dart';
import 'package:getwidget/getwidget.dart';

class ModificaServizio extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ModificaServizio();

}

class _ModificaServizio extends State<ModificaServizio>{

  TextEditingController nomeServizio = TextEditingController();
  TextEditingController ambito = TextEditingController();

  @override
  void initState() {
    nomeServizio.text = "";
    ambito.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(),
      floatingActionButton: GFFloatingWidget(),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            GFTextField(
                decoration: InputDecoration(
                  labelText: "Nome Servizio", //babel text
                  hintText: "Mensa", //hint text
                  hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), //hint text style
                  labelStyle: TextStyle(fontSize: 13, color: Colors.redAccent), //label style
                )
            ),
            GFTextField(
                decoration: InputDecoration(
                  labelText: "Descrizione", //babel text
                  hintText: "Mensa", //hint text
                  hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), //hint text style
                  labelStyle: TextStyle(fontSize: 13, color: Colors.redAccent), //label style
                )
            ),
            Row(
              children: [
                GFTextField(
                    decoration: InputDecoration(
                      labelText: "Ambito", //babel text
                      hintText: "", //hint text
                      hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), //hint text style
                      labelStyle: TextStyle(fontSize: 13, color: Colors.redAccent), //label style
                    )
                ),
                GFTextField(
                    decoration: InputDecoration(
                      labelText: "Tipologia Utente", //babel text
                      hintText: "", //hint text
                      hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), //hint text style
                      labelStyle: TextStyle(fontSize: 13, color: Colors.redAccent), //label style
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}