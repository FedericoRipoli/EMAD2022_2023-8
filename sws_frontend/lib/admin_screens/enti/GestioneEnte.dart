import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend_sws/admin_screens/enti/struttura/ListaStrutture.dart';
import 'package:frontend_sws/components/generali/CustomButton.dart';
import 'package:frontend_sws/services/EnteService.dart';
import 'package:frontend_sws/services/entity/Ente.dart';
import 'package:frontend_sws/theme/theme.dart';
import '../../components/generali/CustomTextField.dart';
import '../../components/loading/AllPageLoadTransparent.dart';
import '../../components/generali/CustomAppBar.dart';
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
  bool isBlank = true;

  Ente? ente;
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();
  TextEditingController nomeController = TextEditingController();
  TextEditingController contenutoController = TextEditingController();

  bool loaded = false;
  final _formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initCall = load();
    if (nomeController.text != "") {
      isBlank = false;
    }
  }

  Future<bool> load() async {
    ente = widget.idEnte != null
        ? await enteService.getEnte(widget.idEnte!)
        : null;
    if (ente != null) {
      nomeController.text = (ente!.denominazione);
      if (ente!.descrizione != null) {
        contenutoController.text = (ente!.descrizione!);
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
      Ente? nEnte;
      if (widget.idEnte == null) {
        nEnte = await enteService.createEnte(Ente(
            denominazione: nomeController.value.text,
            descrizione: contenutoController.value.text));
      } else {
        ente!.denominazione = nomeController.value.text;
        ente!.descrizione = contenutoController.value.text;
        nEnte = await enteService.editEnte(ente!);
      }
      if (mounted) {}
      if (nEnte != null) {
        ToastUtil.success(
            "Ente ${widget.idEnte == null ? 'aggiunto' : 'modificato'}",
            context);
        ente = nEnte;
        widget.idEnte = nEnte.id;
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
        drawer: DrawerMenu(currentPage: GestioneEnte.id),
        appBar: CustomAppBar(
            title: const AppTitle(label: "Gestione Ente"),
            iconData: Icons.arrow_back,
            onPressed: () => Navigator.pop(context)),
        body: FutureBuilder<bool>(
            future: initCall,
            builder: ((context, snapshot) {
              List<Widget> children = [];

              List<Widget> columnChild = [];
              columnChild.add(Form(
                  key: _formGlobalKey,
                  child: Container(
                    margin: const EdgeInsets.all(18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Wrap(
                          children: const [
                            Icon(
                              Icons.home_work,
                              color: AppColors.logoCadmiumOrange,
                              size: 24,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text("aggiungi/modifica Enti")
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          nomeController.text != ""
                              ? "Modifica le informazioni dell'ente selezionato"
                              : "Inserisci un nuovo ente completando i campi sottostanti:",
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        CustomTextField(
                          controller: nomeController,
                          label: "Nome Ente",
                          validator: "Inserisci il campo Nome",
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        // descrizione
                        const Text(
                          "Aggiungi una descrizione per l'ente",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          controller: contenutoController,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.grey), //<-- SEE HERE
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        Text(
                          nomeController.text != ""
                              ? "Modifica le strutture dell'ente"
                              : "Aggiungi una nuova struttura all'ente in creazione",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),

                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ListaStrutture(idEnte: ente!.id!)));
                            },
                            child: Text(
                              ente?.id != null
                                  ? "Modifica Strutture"
                                  : "Aggiungi strutture",
                              style: const TextStyle(fontSize: 18),
                            )),
                        const Divider(
                          thickness: 2,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomButton(
                          onPressed: savePage,
                          fullWidth: true,
                          textButton: nomeController.text != ""
                              ? "APPLICA MODIFICHE"
                              : "SALVA INFORMAZIONI",
                          icon: nomeController.text != ""
                              ? Icons.mode
                              : Icons.save,
                        ),
                      ],
                    ),
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
