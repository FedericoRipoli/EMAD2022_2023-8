import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend_sws/services/EnteService.dart';
import 'package:frontend_sws/services/UtenteService.dart';
import 'package:frontend_sws/services/dto/SignupDTO.dart';
import 'package:frontend_sws/services/entity/Ente.dart';
import 'package:frontend_sws/services/entity/Utente.dart';
import 'package:frontend_sws/main.dart';
import 'package:getwidget/getwidget.dart';

import '../../components/menu/DrawerMenu.dart';

class GestioneUtente extends StatefulWidget {
  String? idUtente;
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.GestioneUtente';

  GestioneUtente(this.idUtente, {super.key});

  @override
  State<StatefulWidget> createState() => _GestioneUtente();
}

class _GestioneUtente extends State<GestioneUtente> {
  String dropdownValue = "1";
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
        floatingActionButton: Container(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            elevation: 5,
            onPressed: ()=>{
              if(widget.idUtente == null){
                //Create new user
                utenteService.createUtente(SignupDto(
                    username: usernameController.value.text,
                    password: passwordController.value.text,
                    idEnte:dropdownValue)),
                Navigator.of(context).pop(true),
                GFToast.showToast("Utente aggiunto",
                    context,
                    toastPosition: GFToastPosition.BOTTOM,
                    trailing: const Icon(Icons.check))
              }else{
                //Update user

              }
            },
            child: widget.idUtente==null? const Icon(Icons.add):const Icon(Icons.save_rounded)
          ),
        ),
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
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }else if (snapshot.hasData) {
                if(utente!=null){
                  usernameController.text = utente!.username.toString();
                }
                return Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 50,right: 50),
                      child: TextField(
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
                      padding: EdgeInsets.only(left: 50,right: 50),
                      child: TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      )
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        const Text("Seleziona Ente "),
                        Container(
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward_sharp),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: enti!.map<DropdownMenuItem<String>>((Ente value) {
                              return DropdownMenuItem<String>(
                                value: value.id,
                                child: Text(value.denominazione),
                              );
                            }).toList(),
                          ),
                        padding: EdgeInsets.only(left: 10),)
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                );
              }else{
                return Center(
                  child: Text("Errore"),
                );
              }

            })
        )
    );
  }
}
