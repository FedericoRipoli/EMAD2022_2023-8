import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend_sws/components/menu/DrawerMenu.dart';
import 'package:frontend_sws/main.dart';
import 'package:frontend_sws/services/EnteService.dart';
import 'package:frontend_sws/services/entity/Ente.dart';
import 'package:getwidget/getwidget.dart';

import '../../components/CustomAppBar.dart';
import '../../components/CustomFloatingButton.dart';

class GestioneEnte extends StatefulWidget {
  String? idEnte;
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.GestioneEnte';

  GestioneEnte(this.idEnte, {super.key});

  @override
  State<StatefulWidget> createState() => _GestioneEnte();
}

class _GestioneEnte extends State<GestioneEnte> {
  EnteService enteService = EnteService();
  TextEditingController nomeEnte = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();

  List<Ente>? enti;
  Ente? ente;

  Future<bool> load() async {
    //aggiungere la get tramite id e sostituire qui
    enti = await enteService.enteList(null, null);
    ente = enti?.firstWhere((element) => (element.id == widget.idEnte));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKeyAdmin,
        resizeToAvoidBottomInset: false,
        floatingActionButton: CustomFloatingButton(
          iconData: Icons.save_rounded,
          onPressed: ()=>{
            if(widget.idEnte == null){
              //Create new ente
              //enteService.createEnte(),
              Navigator.of(context).pop(true),
              GFToast.showToast("Ente aggiunto",
                  context,
                  toastPosition: GFToastPosition.BOTTOM,
                  trailing: const Icon(Icons.check))
            }else{
              //Update user

            }
          },
        ),

        drawer: DrawerMenu(currentPage: GestioneEnte.id),
        appBar: CustomAppBar(title:"Gestione Ente",
            iconData:Icons.arrow_back,
            onPressed:()=>Navigator.pop(context)),
        body: FutureBuilder<bool>(
            future: load(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              /*else if (snapshot.hasError){
                return const Center(
                  child: Text("Errore"),
                );
              }*/
              else {
                if(ente!=null){
                  nomeEnte.text = ente!.denominazione.toString();
                }
                return Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 50,right: 50),
                      child: TextField(
                        controller: nomeEnte,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Denominazione',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  /*
                    Container(
                        padding: EdgeInsets.only(left: 50,right: 50),
                        child: TextField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        )
                    ),
                  */
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                );
              }


            })
        )
    );
  }

}