import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend_sws/services/EnteService.dart';
import 'package:frontend_sws/services/entity/Ente.dart';


import '../../components/AllPageLoadTransparent.dart';
import '../../components/CustomAppBar.dart';
import '../../components/CustomFloatingButton.dart';
import '../../components/menu/DrawerMenu.dart';
import '../../util/ToastUtil.dart';

class GestioneEnte extends StatefulWidget {
  String? idEnte;
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.GestioneEnte';

  GestioneEnte(this.idEnte, {super.key});

  @override
  State<StatefulWidget> createState() => _GestioneEnte();
}

class _GestioneEnte extends State<GestioneEnte> {
  late Future<bool> initCall;
  EnteService enteService = EnteService();

  Ente? ente;
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();
  TextEditingController nomeController = TextEditingController();

  bool loaded = false;
  final _formGlobalKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    initCall = load();
  }

  Future<bool> load() async {

    ente = widget.idEnte != null
        ? await enteService.getEnte(widget.idEnte!)
        : null;
    if (ente != null) {
      nomeController.text = (ente!.denominazione);
    }
    setState(() {
      loaded = true;
    });
    return true;
  }

  void savePage() async {
    if(_formGlobalKey.currentState!.validate()){
      _formGlobalKey.currentState?.save();
      setState(() {
        loaded = false;
      });
      Ente? nEnte;
      if (widget.idEnte == null) {
        nEnte = await enteService.createEnte(Ente(
            denominazione: nomeController.value.text
        ));

      } else {
        ente!.denominazione=nomeController.value.text;
        nEnte = await enteService.editEnte(ente!);
      }
      if (mounted) {}
      if (nEnte != null) {

        ToastUtil.success(
            "Ente ${widget.idEnte==null?'aggiunto':'modificato'}",
            context
        );
        ente=nEnte;
        widget.idEnte=nEnte.id;

      } else {
        ToastUtil.error(
            "Errore server",
            context
        );

      }
      setState(() {
        loaded = true;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKeyAdmin,
        resizeToAvoidBottomInset: false,


        drawer: DrawerMenu(currentPage: GestioneEnte.id),
        floatingActionButton: !loaded
            ? null
            : CustomFloatingButton(
          iconData: Icons.save_rounded,
          onPressed:  () => savePage(),
        ),
        appBar: CustomAppBar(title:"Gestione Ente",
            iconData:Icons.arrow_back,
            onPressed:()=>Navigator.pop(context)),





        body: FutureBuilder<bool>(
            future: initCall,
            builder: ((context, snapshot) {
              List<Widget> children = [];

              if (!snapshot.hasData && !snapshot.hasError || !loaded) {
                children.add(const AllPageLoadTransparent());
              }
              List<Widget> columnChild = [];
              columnChild.add(
                  Form(
                      key: _formGlobalKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 80,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            child: TextFormField(
                              validator: (v) {
                                if(v==null || v.isEmpty) {
                                  return "Inserisci il campo nome";
                                }
                              },
                              controller: nomeController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Denominazione',
                              ),
                            ),
                          )
                        ],
                      )
                  )



              );

              children.add(Column(
                children: columnChild,
              ));
              return AbsorbPointer(
                absorbing: !(snapshot.hasData || snapshot.hasError),
                child: Stack(
                  children: children,
                ),
              );
            })));
  }
}
