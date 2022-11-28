import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend_sws/components/menu/DrawerMenu.dart';
import 'package:frontend_sws/main.dart';
import 'package:frontend_sws/services/EnteService.dart';
import 'package:frontend_sws/services/entity/Ente.dart';
import 'package:getwidget/getwidget.dart';

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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          height: 70,
          width: 70,
          child: FloatingActionButton(
              elevation: 5,
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
              child: widget.idEnte==null? const Icon(Icons.add):const Icon(Icons.save_rounded)
          ),
        ),
        drawer: DrawerMenu(currentPage: GestioneEnte.id),
        appBar: GFAppBar(
          title: const Text("Gestione Ente"),
          leading: GFIconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            type: GFButtonType.transparent,
          ),
          searchBar: false,
          elevation: 0,
          backgroundColor: appTheme.primaryColor,
        ),
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