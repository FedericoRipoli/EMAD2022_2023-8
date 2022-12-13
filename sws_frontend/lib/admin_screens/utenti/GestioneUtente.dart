import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sws/services/EnteService.dart';
import 'package:frontend_sws/services/UtenteService.dart';
import 'package:frontend_sws/services/entity/Ente.dart';
import 'package:frontend_sws/services/entity/Utente.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:frontend_sws/main.dart';
import 'package:getwidget/getwidget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../components/generali/input/CustomDropDownText.dart';
import '../../components/loading/AllPageLoadTransparent.dart';
import '../../components/generali/CustomAppBar.dart';
import '../../components/generali/CustomFloatingButton.dart';
import '../../components/menu/DrawerMenu.dart';
import '../../services/dto/SignupDTO.dart';
import '../../theme/theme.dart';
import '../../util/ToastUtil.dart';

class GestioneUtente extends StatefulWidget {
  String? idUtente;
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.GestioneUtente';

  GestioneUtente(this.idUtente, {super.key});

  @override
  State<StatefulWidget> createState() => _GestioneUtente();
}

class _GestioneUtente extends State<GestioneUtente> {
  late Future<bool> initCall;
  EnteService enteService = EnteService();
  UtenteService utenteService = UtenteService();

  List<Ente>? enti;
  Utente? utente;
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? dropdownValue;
  bool loaded = false;
  List<CustomDropDownItem> itemsEnte = [];
  final _formGlobalKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    initCall = load();
  }

  Future<bool> load() async {
    enti = await enteService.enteList(null, null, "sort=denominazione&denominazione.dir=asc");
    if (enti != null) {
      itemsEnte.add(CustomDropDownItem(
        id: null,
        name: "",
      ));
      itemsEnte.addAll(enti!.map<CustomDropDownItem>((Ente value) {
        return CustomDropDownItem(
          id: value.id,
          name: value.denominazione,
        );
      }).toList());
    }
    utente = widget.idUtente != null
        ? await utenteService.getUtente(widget.idUtente!)
        : null;
    if (utente != null) {
      dropdownValue = utente!.idEnte;
      usernameController.text = (utente!.username);
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
      Utente? nUser;
      if (widget.idUtente == null) {
        nUser = await utenteService.createUtente(SignupDto(
            username: usernameController.value.text,
            password: passwordController.value.text,
            idEnte: dropdownValue));
      } else {
        utente!.username = usernameController.value.text;
        utente!.password = passwordController.value.text;
        utente!.idEnte = dropdownValue;
        nUser = await utenteService.editUtente(utente!);
      }
      if (mounted) {}
      if (nUser != null) {
        Navigator.of(context).pop();
        ToastUtil.success(
            "Utente ${widget.idUtente == null ? 'aggiunto' : 'modificato'}",
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
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKeyAdmin,
        resizeToAvoidBottomInset: false,
        drawer: DrawerMenu(currentPage: GestioneUtente.id),
        floatingActionButton: !loaded
            ? null
            : CustomFloatingButton(
                iconData: Icons.save_rounded,
                onPressed: () => savePage(),
              ),
        appBar: CustomAppBar(
            title: const AppTitle(label: "Gestione Utente"),
            iconData: Icons.arrow_back,
            onPressed: () => Navigator.pop(context)),
        body: FutureBuilder<bool>(
            future: initCall,
            builder: ((context, snapshot) {
              List<Widget> children = [];


              List<Widget> columnChild = [];
              columnChild.add(Form(
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
                            if (v == null || v.isEmpty) {
                              return "Inserisci il campo username";
                            }
                          },
                          controller: usernameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: TextFormField(
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "Inserisci il campo passoword";
                              }
                            },
                            controller: passwordController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: CustomDropDownText(
                            value:dropdownValue,
                            name:"Seleziona ente",
                            values: itemsEnte,
                              validator: (value) {
                                if (value == null) {
                                  return 'Seleziona un ente';
                                }
                              },
                              onChanged: (value) {
                                //Do something when changing the item if you want.
                              },
                              onSaved: (value) {
                                dropdownValue = value.toString();
                              }

                          )
                      )
                    ],
                  )));

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
}
