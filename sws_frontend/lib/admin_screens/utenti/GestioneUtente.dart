
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sws/services/EnteService.dart';
import 'package:frontend_sws/services/UtenteService.dart';
import 'package:frontend_sws/services/entity/Ente.dart';
import 'package:frontend_sws/services/entity/Utente.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';

class GestioneUtente extends StatefulWidget{

  String? idUtente;

  GestioneUtente(String? idUtente){
    this.idUtente = idUtente;
  }

  @override
  State<StatefulWidget> createState() => _GestioneUtente(idUtente);

}

class _GestioneUtente extends State<GestioneUtente>{

  String? idUtente;

  _GestioneUtente(String? idUtente){
    this.idUtente = idUtente;
  }

  EnteService? enteService;
  Future<List<Ente>>? future;

  Future<List<Ente>> getEnti() async{
    List<Ente> list = await EnteService().enteList(null,null) as List<Ente>;
    if (list != null) {
      return list;
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    future = getEnti();
  }

  @override
  Widget build(BuildContext context) {
    //Utente utente = UtenteService().getUtente(idUtente!) as Utente;
    TextEditingController passwordController = TextEditingController();
    //passwordController.text = utente.password;
    TextEditingController usernameController = TextEditingController();
    //usernameController.text = utente.username;

    String? selectedValue ;

    return Scaffold(
      floatingActionButton: Container(
          width: 80,
          height: 80,
          child: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 0, 89, 179),
            child: Icon(Icons.save,size: 40),
            onPressed: () => {

            },
          )
      ),
        appBar: GFAppBar(
          title: const Text("Gestione Utente"),
          leading: IconButton(
              icon : Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: FutureBuilder<List<Ente>?>(
          future: future,
          builder: (BuildContext context, AsyncSnapshot<List<Ente>?> snapshot) {
            if (!snapshot.hasData) {
              // while data is loading:
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              // data loaded:
              final list = snapshot.data;
              selectedValue = list?.first.id;
              return Container(
                padding: EdgeInsets.only(left: 50,top: 100,right: 50,bottom: 0),
                child: Column(
                  children: [
                    TextField(
                      controller: usernameController,
                      decoration:  InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                    ),
                    SizedBox(height: 30),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(height: 30),
                    DropdownButton(
                        dropdownColor: Color.fromARGB(255, 204, 206, 208),
                        value: selectedValue,
                        onChanged: (String? newValue){
                          setState(() {
                            selectedValue = newValue!;
                          });
                        },
                        items: list?.map<DropdownMenuItem<String>>((Ente value) {
                          return DropdownMenuItem<String>(
                            value: value.id,
                            child: Text(value.denominazione.toString()),
                          );
                        }).toList()
                    )
                  ],
                ),
              );
            }
          },
        )
    );
  }

}