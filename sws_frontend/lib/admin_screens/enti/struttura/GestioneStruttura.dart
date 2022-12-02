import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sws/services/StrutturaService.dart';
import '../../../components/AllPageLoadTransparent.dart';
import '../../../components/CustomAppBar.dart';
import '../../../components/CustomFloatingButton.dart';
import '../../../components/menu/DrawerMenu.dart';
import '../../../services/entity/Struttura.dart';
import '../../../util/ToastUtil.dart';

class GestioneStruttura extends StatefulWidget {
  String? idStruttura;
  String idEnte;
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.GestioneStruttura';

  GestioneStruttura( {super.key,this.idStruttura, required this.idEnte});

  @override
  State<StatefulWidget> createState() => _GestioneStruttura();
}

class _GestioneStruttura extends State<GestioneStruttura> {
  late Future<bool> initCall;
  StrutturaService strutturaService = StrutturaService();

  Struttura? struttura;
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();
  TextEditingController denominazioneController = TextEditingController();

  bool loaded = false;
  final _formGlobalKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    initCall = load();
  }

  Future<bool> load() async {

    struttura = widget.idStruttura != null
        ? await strutturaService.getStruttura(widget.idStruttura!)
        : null;
    if (struttura != null) {
      denominazioneController.text = (struttura!.denominazione!);
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
      Struttura? nStruttura;
      if (widget.idStruttura == null) {
        nStruttura = await strutturaService.createStruttura(Struttura(
            denominazione: denominazioneController.value.text,
          ),widget.idEnte);

      } else {
        struttura!.denominazione=denominazioneController.value.text;
        nStruttura = await strutturaService.editStruttura(struttura!);
      }
      if (mounted) {}
      if (nStruttura != null) {
        Navigator.of(context).pop();
        ToastUtil.success(
            "Struttura ${widget.idStruttura==null?'aggiunta':'modificata'}",
            context
        );

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


        drawer: DrawerMenu(currentPage: GestioneStruttura.id),
        floatingActionButton: !loaded
            ? null
            : CustomFloatingButton(
          iconData: Icons.save_rounded,
          onPressed:  () => savePage(),
        ),
        appBar: CustomAppBar(title:"Gestione Struttura",
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
                                  return "Inserisci il campo denominazione";
                                }
                              },
                              controller: denominazioneController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Denominazione',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      )
                  )



              );

              children.add(SingleChildScrollView(
                  child: Column(
                    children: columnChild,
                  )));
              return AbsorbPointer(
                absorbing: !(snapshot.hasData || snapshot.hasError),
                child: Stack(
                  children: children,
                ),
              );
            })));
  }
}
