import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sws/services/ContattoService.dart';
import 'package:frontend_sws/services/EnteService.dart';
import 'package:frontend_sws/services/UtenteService.dart';
import 'package:frontend_sws/services/entity/Contatto.dart';
import 'package:frontend_sws/services/entity/Ente.dart';
import 'package:frontend_sws/services/entity/Utente.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../components/AllPageLoadTransparent.dart';
import '../../components/CustomAppBar.dart';
import '../../components/CustomFloatingButton.dart';
import '../../components/menu/DrawerMenu.dart';
import '../../services/dto/SignupDTO.dart';
import '../../util/ToastUtil.dart';

class GestioneContatto extends StatefulWidget {
  String? idContatto;
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.GestioneUtente';

  GestioneContatto(this.idContatto, {super.key});

  @override
  State<StatefulWidget> createState() => _GestioneContatto();
}

class _GestioneContatto extends State<GestioneContatto> {
  late Future<bool> initCall;
  EnteService enteService = EnteService();
  UtenteService utenteService = UtenteService();
  ContattoService contattoService = ContattoService();

  List<Ente>? enti;
  Contatto? contatto;
  Utente? utente;

  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cellulareController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController pecController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  String? dropdownValue;
  bool loaded = false;
  List<DropdownMenuItem<String>> itemsEnte = [];
  final _formGlobalKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    initCall = load();
  }

  Future<bool> load() async {
    contatto = widget.idContatto != null
        ? await contattoService.getContatto(widget.idContatto!)
        : null;
    if(contatto != null){
      if(contatto!.denominazione != null)
        nomeController.text = contatto!.denominazione!;
      if(contatto!.email != null)
        emailController.text = contatto!.email!;
      if(contatto!.cellulare != null)
        cellulareController.text = contatto!.cellulare!;
      if(contatto!.telefono != null)
        telefonoController.text = contatto!.telefono!;
      if(contatto!.pec != null)
        pecController.text = contatto!.pec!;
      if(contatto!.sitoWeb != null)
        urlController.text = contatto!.sitoWeb!;
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
      Contatto? nContatto;
      if (widget.idContatto == null) {
        nContatto = await contattoService.createContatto(Contatto(
          denominazione: nomeController.value.text,
          email: emailController.value.text,
          telefono: telefonoController.value.text,
          cellulare: cellulareController.value.text,
          pec: pecController.value.text,
          sitoWeb: urlController.value.text
        ));
      } else {
        contatto!.denominazione = nomeController.value.text;
        contatto!.email = emailController.value.text;
        contatto!.telefono = telefonoController.value.text;
        contatto!.cellulare = cellulareController.value.text;
        contatto!.pec = pecController.value.text;
        contatto!.sitoWeb = urlController.value.text;
        nContatto = await contattoService.editContato(contatto!);
      }
      if (mounted) {}
      if (nContatto != null) {
        Navigator.of(context).pop();
        ToastUtil.success(
            "Contatto ${widget.idContatto==null?'aggiunto':'modificato'}",
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

  String? validateAlmostOne(){
    if((emailController.value.text == null || emailController.value.text.isEmpty)
    && (cellulareController.value.text == null || cellulareController.value.text.isEmpty)
    && (telefonoController.value.text == null || telefonoController.value.text.isEmpty))
      return "Compila almeno un campo Email, Cellulare o Telefono";
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKeyAdmin,
        resizeToAvoidBottomInset: false,
        drawer: DrawerMenu(currentPage: GestioneContatto.id),
        floatingActionButton: !loaded
            ? null
            : CustomFloatingButton(
          iconData: Icons.save_rounded,
          onPressed:  () => savePage(),
        ),
        appBar: CustomAppBar(title:"Gestione Contatto",
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
                            height: 40,
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
                                labelText: 'Nome',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                              padding: const EdgeInsets.only(left: 50, right: 50),
                              child: TextFormField(
                                validator: (v) {
                                  if(v!=null && v.isNotEmpty){
                                    RegExp emailRegEx = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                    if(!emailRegEx.hasMatch(v!))
                                      return "Formato email non valido";
                                  }else
                                    return validateAlmostOne();
                                },
                                controller: emailController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'E-mail',
                                ),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            child: TextFormField(
                              validator: (v) {
                                if(v!=null && v.isNotEmpty){
                                  RegExp cellRegEx = RegExp(r"^[0-9]{10}$");
                                  if(!cellRegEx.hasMatch(v!))
                                    return "Numero di cellulare non valido";
                                }else
                                  return validateAlmostOne();
                              },
                              controller: cellulareController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Cellulare',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            child: TextFormField(
                              validator: (v){
                                if(v!=null && v.isNotEmpty){
                                  RegExp telRegEx = RegExp(r"^[0-9]{9}$");
                                  if(!telRegEx.hasMatch(v!))
                                    return "Numero di telefono non valido";
                                }else
                                  return validateAlmostOne();
                              },
                              controller: telefonoController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Telefono',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            child: TextFormField(
                              controller: pecController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Pec',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            child: TextFormField(
                              controller: urlController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'URL del sito',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
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
