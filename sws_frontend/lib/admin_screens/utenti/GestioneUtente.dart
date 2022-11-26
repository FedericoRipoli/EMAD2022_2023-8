import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sws/services/EnteService.dart';
import 'package:frontend_sws/services/UserService.dart';
import 'package:frontend_sws/services/UtenteService.dart';
import 'package:frontend_sws/services/entity/Ente.dart';
import 'package:frontend_sws/services/entity/Utente.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:frontend_sws/main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:getwidget/getwidget.dart';

import '../../components/AllPageLoadTransparent.dart';
import '../../components/menu/DrawerMenu.dart';

class GestioneUtente extends StatefulWidget {
  String? idUtente;
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.GestioneUtente';

  GestioneUtente(this.idUtente, {super.key});

  @override
  State<StatefulWidget> createState() => _GestioneUtente();
}

class _GestioneUtente extends State<GestioneUtente> {
  EnteService enteService = EnteService();
  UtenteService utenteService = UtenteService();
  List<Ente>? enti;
  Utente? utente;
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();

  Future<bool> load() async {
    enti = await enteService.enteList(null, null);
    utente = widget.idUtente != null
        ? await utenteService.getUtente(widget.idUtente!)
        : null;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKeyAdmin,
        resizeToAvoidBottomInset: false,
        drawer: DrawerMenu(currentPage: GestioneUtente.id),
        appBar: GFAppBar(
          title: const Text("Gestione utente"),
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
              List<Widget> children = [];

              if (!snapshot.hasData && !snapshot.hasError) {
                children.add(const AllPageLoadTransparent());
              }
              List<Widget> columnChild = [];
              columnChild.add(
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term',
                  ),
                ),
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
