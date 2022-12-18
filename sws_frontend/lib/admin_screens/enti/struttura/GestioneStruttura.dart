import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend_sws/components/generali/CustomTextField.dart';
import 'package:frontend_sws/services/StrutturaService.dart';
import '../../../components/generali/CustomButton.dart';
import '../../../components/loading/AllPageLoadTransparent.dart';
import '../../../components/generali/CustomAppBar.dart';
import '../../../components/generali/CustomFloatingButton.dart';
import '../../../components/menu/DrawerMenu.dart';
import '../../../services/entity/Posizione.dart';
import '../../../services/entity/Struttura.dart';
import '../../../theme/theme.dart';
import '../../../util/ToastUtil.dart';

class GestioneStruttura extends StatefulWidget {
  String? idStruttura;
  String idEnte;
  static String id =
      'it.unisa.emad.comunesalerno.sws.ipageutil.GestioneStruttura';

  GestioneStruttura({super.key, this.idStruttura, required this.idEnte});

  @override
  State<StatefulWidget> createState() => _GestioneStruttura();
}

class _GestioneStruttura extends State<GestioneStruttura> {
  late Future<bool> initCall;
  StrutturaService strutturaService = StrutturaService();

  Struttura? struttura;
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();
  TextEditingController denominazioneController = TextEditingController();
  TextEditingController indirizzoController = TextEditingController();
  TextEditingController latitudineController = TextEditingController();
  TextEditingController longitudineController = TextEditingController();

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
      indirizzoController.text = (struttura!.posizione!.indirizzo!);
      latitudineController.text = (struttura!.posizione!.latitudine!);
      longitudineController.text = (struttura!.posizione!.longitudine!);
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
      Struttura? nStruttura;
      if (widget.idStruttura == null) {
        nStruttura = await strutturaService.createStruttura(
            Struttura(
                denominazione: denominazioneController.value.text,
                posizione: Posizione(
                  indirizzo: indirizzoController.value.text,
                  latitudine: latitudineController.value.text,
                  longitudine: longitudineController.value.text,
                )),
            widget.idEnte);
      } else {
        struttura!.denominazione = denominazioneController.value.text;
        struttura!.posizione!.indirizzo = indirizzoController.value.text;
        struttura!.posizione!.latitudine = latitudineController.value.text;
        struttura!.posizione!.longitudine = longitudineController.value.text;
        nStruttura = await strutturaService.editStruttura(struttura!);
      }
      if (mounted) {}
      if (nStruttura != null) {
        Navigator.of(context).pop();
        ToastUtil.success(
            "Struttura ${widget.idStruttura == null ? 'aggiunta' : 'modificata'}",
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
        drawer: DrawerMenu(currentPage: GestioneStruttura.id),
        appBar: CustomAppBar(
            title: const AppTitle(label: "Gestione Struttura"),
            iconData: Icons.arrow_back,
            onPressed: () => Navigator.pop(context)),
        body: FutureBuilder<bool>(
            future: initCall,
            builder: ((context, snapshot) {
              List<Widget> children = [];

              if (!snapshot.hasData && !snapshot.hasError || !loaded) {
                children.add(const AllPageLoadTransparent());
              }
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
                            Text("aggiungi/modifica Strutture")
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          denominazioneController.text != ""
                              ? "Modifica le informazioni della struttura selezionata"
                              : "Inserisci una nuova struttura completando i campi sottostanti:",
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        CustomTextField(
                          controller: denominazioneController,
                          label: "Nome struttura",
                          validator: "Inserisci nome struttura",
                        ),
                        CustomTextField(
                          controller: indirizzoController,
                          label: "Indirizzo struttura",
                          validator: "Inserisci indirizzo struttura",
                        ),
                        CustomTextField(
                          controller: indirizzoController,
                          label: "Indirizzo struttura",
                          validator: "Inserisci indirizzo struttura",
                        ),
                        CustomTextField(
                          controller: latitudineController,
                          label: "Latitudine",
                          validator: "Inserisci latitudine struttura",
                        ),
                        CustomTextField(
                          controller: longitudineController,
                          label: "Longitudine",
                          validator: "Inserisci longitudine struttura",
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          onPressed: savePage,
                          fullWidth: true,
                          textButton: denominazioneController.text != ""
                              ? "APPLICA MODIFICHE"
                              : "SALVA INFORMAZIONI",
                          icon: denominazioneController.text != ""
                              ? Icons.mode
                              : Icons.add,
                        ),
                      ],
                    ),
                  )));

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
