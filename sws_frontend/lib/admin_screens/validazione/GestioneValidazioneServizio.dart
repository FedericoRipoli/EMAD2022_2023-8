import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:frontend_sws/services/entity/Ente.dart';
import 'package:frontend_sws/services/entity/Struttura.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../components/generali/CustomAppBar.dart';
import '../../components/generali/input/CustomDropDown.dart';
import '../../components/generali/input/CustomDropDownText.dart';
import '../../components/generali/CustomFloatingButton.dart';
import '../../components/loading/AllPageLoadTransparent.dart';
import '../../components/menu/DrawerMenu.dart';
import '../../components/servizi/DetailPageService.dart';
import '../../components/servizi/DetailServiceToValidate.dart';
import '../../services/AreeService.dart';
import '../../services/ServizioService.dart';
import '../../services/StrutturaService.dart';
import '../../services/entity/Area.dart';
import '../../services/entity/Contatto.dart';
import '../../services/entity/Servizio.dart';
import '../../util/ToastUtil.dart';

class GestioneValidazioneServizio extends StatefulWidget {
  String? idServizio;
  static String id =
      'it.unisa.emad.comunesalerno.sws.ipageutil.GestioneValidazioneServizio';

  GestioneValidazioneServizio({this.idServizio, super.key});

  @override
  State<StatefulWidget> createState() => _GestioneServizio();
}

class _GestioneServizio extends State<GestioneValidazioneServizio> {
  late Future<bool> initCall;
  ServizioService servizioService = ServizioService();
  late double _distanceToField;

  Servizio? servizio;
  Ente? _ente;
  Struttura? _struttura;
  Contatto? _contatto;
  String?  _nome = "", _contenuto = "", _note = "";
  List<String> _aree = [];
  List<String> _tags = [];
  Icon? _icon;

  final _formGlobalKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    initCall = load();
  }

  Future<bool> load() async {
    servizio = widget.idServizio != null
        ? await servizioService.getServizio(widget.idServizio!)
        : null;
    /*
    if (servizio != null) {
      if(servizio!.struttura != null){
        _struttura = servizio!.struttura!;
      }
      if(servizio!.struttura!.ente != null){
        _ente = servizio!.struttura!.ente!;
      }
      if(servizio!.aree != null){
        _aree = servizio!.aree!.map((e) => e.nome!).toList();
      }
      if(servizio!.nome != null){
        _nome = (servizio!.nome);
      }
      if(servizio!.hashtags != null){
        servizio!.hashtags?.forEach((e) {
          _tags.add(e.toString());
        });
      }
      if (servizio!.contenuto != null) {
        _contenuto = (servizio!.contenuto!);
      }
      if (servizio!.note != null) {
        _note = (servizio!.note!);
      }
      if (servizio!.contatto != null) {
        _contatto = servizio!.contatto!;
      }
      if (servizio!.customIcon != null) {
        _icon = Icon(servizio!.getIconData());
      }
    }
     */
    setState(() {
      loaded = true;
    });
    return true;
  }

  void savePage() async {

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKeyAdmin,
        resizeToAvoidBottomInset: false,
        drawer: DrawerMenu(currentPage: GestioneValidazioneServizio.id),
        floatingActionButton: !loaded ||
            (servizio != null && !Servizio.canEnteEdit(servizio!.stato))
            ? null
            : CustomFloatingButton(
          iconData: Icons.save_rounded,
          onPressed: () => savePage(),
        ),
        appBar: CustomAppBar(
            title: const AppTitle(label: "Validazione Servizio"),
            iconData: Icons.arrow_back,
            onPressed: () => Navigator.pop(context)),
        body: FutureBuilder<bool>(
            future: initCall,
            builder: ((context, snapshot) {
              List<Widget> children = [];

              if (!snapshot.hasData && !snapshot.hasError || !loaded) {
                children.add(const AllPageLoadTransparent());
              }
              if(snapshot.hasData) {
                children.add(
                    DetailServiceToValidate(servizio: servizio!)
                );
              }
              return AbsorbPointer(
                absorbing: !(snapshot.hasData || snapshot.hasError),
                child: Stack(
                  children: children,
                ),
              );
            })));
  }
}
