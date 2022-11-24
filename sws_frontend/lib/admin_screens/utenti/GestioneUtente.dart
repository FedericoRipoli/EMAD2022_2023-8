
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sws/services/EnteService.dart';
import 'package:frontend_sws/services/entity/Ente.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';

class GestioneUtente extends StatefulWidget{

  String? idUtente;

  GestioneUtente(String? idUtente){
    this.idUtente = idUtente;
  }

  @override
  State<StatefulWidget> createState() => _GestioneUtente();

}

class _GestioneUtente extends State<GestioneUtente>{
  /*
  var _isLoading = false;
  var _callError = false;
  Future<List<Ente>> getEnti() async{
    setState(() => {_isLoading = true, _callError = false});
    var list = await EnteService().enteList(null,null) as List<Ente>;
    setState(() => {_isLoading = false, _callError = list == null});
    if (list != null) {
      return list;
    }
    return [];
  }
  */
  EnteService? enteService;

  Future<List<Ente>> getEnti() async{
    List<Ente> list = await EnteService().enteList(null,null) as List<Ente>;
    if (list != null) {
      return list;
    }
    return [];
  }
  Future<List<Ente>>? future;
  @override
  void initState() {
    super.initState();
    future = getEnti();
  }

  @override
  Widget build(BuildContext context) {

    /*
    String selectedValue = "ENTE";
    List<Ente> listaEnti = (EnteService().enteList(null,null) as List<Ente>);
    */
    String selectedValue="";

    return Scaffold(
        appBar: GFAppBar(
          title: const Text("Gestione Utente"),
          leading: Icon(Icons.arrow_back_ios),
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
              return Container(
                padding: EdgeInsets.only(left: 50,top: 100,right: 50,bottom: 0),
                child: Column(
                  children: [
                    const TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                    ),
                    SizedBox(height: 30),
                    const TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(height: 30),
                    DropdownButton(
                        value: selectedValue,
                        icon: Icon(Icons.house_siding_outlined),
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
      /*
      body: Container(
        padding: EdgeInsets.only(left: 50,top: 100,right: 50,bottom: 0),
        child: Column(
          children: [
            const TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 30),
            const TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 30),
            DropdownButton(
              value: selectedValue,
              icon: Icon(Icons.house_siding_outlined),
              onChanged: (String? newValue){
                setState(() {
                  selectedValue = newValue!;
                });
              },
              items: listaEnti.map<DropdownMenuItem<String>>((Ente value) {
                return DropdownMenuItem<String>(
                  value: value.id,
                  child: Text(value.denominazione.toString()),
                );
              }).toList()
            )
          ],
        ),
      ),
    */
    );
  }

}