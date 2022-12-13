import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
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

  AreeService areeService = AreeService();
  StrutturaService strutturaService = StrutturaService();
  Servizio? servizio;
  String? strutturaValue;
  List<String> areeValues = [];
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();

  TextEditingController noteController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController sitoWebController = TextEditingController();
  TextEditingController contenutoController = TextEditingController();
  TextfieldTagsController tagController = TextfieldTagsController();
  late double _distanceToField;
  Icon? _icon;
  bool loaded = false;
  final _formGlobalKey = GlobalKey<FormState>();
  late List<DropdownMenuItem<String>> itemsAree = [];

  List<Area>? aree = [];

  @override
  void initState() {
    super.initState();
    initCall = load();
  }

  Future<bool> load() async {

    servizio = widget.idServizio != null
        ? await servizioService.getServizio(widget.idServizio!)
        : null;
    if (servizio != null) {
      strutturaValue = servizio!.struttura!.id;
      areeValues = servizio!.aree!.map((e) => e.id!).toList();
      nomeController.text = (servizio!.nome);
      servizio!.hashtags?.forEach((e) {
        tagController.addTag = (e);
      });
      if (servizio!.contenuto != null) {
        contenutoController.text = (servizio!.contenuto!);
      }
      if (servizio!.note != null) {
        noteController.text = (servizio!.note!);
      }
      if (servizio!.contatto != null) {
        sitoWebController.text = servizio!.contatto!.sitoWeb != null
            ? servizio!.contatto!.sitoWeb!
            : "";
        telefonoController.text = servizio!.contatto!.telefono != null
            ? servizio!.contatto!.telefono!
            : "";
        emailController.text =
        servizio!.contatto!.email != null ? servizio!.contatto!.email! : "";
      }
      if (servizio!.customIcon != null) {
        _icon = Icon(servizio!.getIconData());
      }
    }

    setState(() {
      loaded = true;
    });
    return true;
  }

  void savePage() async {
    if (_formGlobalKey.currentState!.validate()) {
      _formGlobalKey.currentState?.save();
      setState(() {
        loaded = false;
      });
      Servizio? nServizio;
      if (widget.idServizio == null) {
        nServizio = await servizioService.createServizio(Servizio(
          nome: nomeController.value.text,
          contenuto: contenutoController.value.text,
          contatto: Contatto(
            telefono: telefonoController.value.text,
            email: emailController.value.text,
            sitoWeb: sitoWebController.value.text,
          ),
          hashtags: tagController.getTags,
          idAree: areeValues,
          idStruttura: strutturaValue,
          customIcon: _icon != null ? _icon!.icon!.codePoint.toString() : null,
        ));
      } else {
        servizio!.nome = nomeController.value.text;
        servizio!.contatto!.telefono = telefonoController.value.text;
        servizio!.contatto!.email = emailController.value.text;
        servizio!.contatto!.sitoWeb = sitoWebController.value.text;
        servizio!.contenuto = contenutoController.value.text;
        servizio!.idAree = areeValues;
        servizio!.idStruttura = strutturaValue;
        servizio!.hashtags = tagController.getTags;
        servizio!.customIcon =
        _icon != null ? _icon!.icon!.codePoint.toString() : null;
        nServizio = await servizioService.editServizio(servizio!);
      }
      if (mounted) {}
      if (nServizio != null) {
        Navigator.of(context).pop();
        ToastUtil.success(
            "Servizio ${widget.idServizio == null ? 'aggiunto' : 'modificato'}",
            context);
      } else {
        ToastUtil.error("Errore server", context);
      }
      setState(() {
        loaded = true;
      });
    }
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


              List<Widget> columnChild = [];
              columnChild.add(SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Text(""),
                    ],
                  ),
                ),
              ));

              children.add(SingleChildScrollView(
                  child: Column(
                    children: columnChild,
                  )));
              if (!snapshot.hasData && !snapshot.hasError || !loaded) {
                children.add(const AllPageLoadTransparent());
              }
              return AbsorbPointer(
                absorbing: !(snapshot.hasData || snapshot.hasError),
                child: Stack(
                  children: children,
                ),
              );
            })));
  }

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);

    _icon = Icon(icon);
    setState(() {});
  }

  _removeIcon() {
    _icon = null;
    setState(() {});
  }
}
