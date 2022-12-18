import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend_sws/components/generali/CustomButton.dart';
import 'package:frontend_sws/components/generali/CustomTextField.dart';
import 'package:frontend_sws/services/EnteService.dart';
import 'package:frontend_sws/services/UtenteService.dart';
import 'package:frontend_sws/services/entity/Ente.dart';
import 'package:frontend_sws/services/entity/Utente.dart';
// component
import '../../components/generali/input/CustomDropDownText.dart';
import '../../components/loading/AllPageLoadTransparent.dart';
import '../../components/generali/CustomAppBar.dart';
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
    enti = await enteService.enteList(
        null, null, "sort=denominazione&denominazione.dir=asc");
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
        appBar: CustomAppBar(
            title: const AppTitle(label: "Gestione Admin Enti"),
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
                              Icons.account_circle_sharp,
                              color: AppColors.logoCadmiumOrange,
                              size: 24,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text("aggiungi/modifica Admin Enti")
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          usernameController.text != ""
                              ? "Modifica le credenziali di accesso del responsabile selezionato"
                              : "Inserisci un nuovo amministratore per un ente di tua scelta. Seleziona l'ente di cui fa parte per permettere l'accesso.",
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
                          controller: usernameController,
                          label: "Username",
                          validator: "Inserisci il campo Username",
                        ),
                        CustomTextField(
                          controller: passwordController,
                          label: "Password",
                          validator: "Inserisci il campo Password",
                          isPassword: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: CustomDropDownText(
                                value: dropdownValue,
                                name: "Seleziona ente",
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
                                })),
                        const SizedBox(
                          height: 4,
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
                          textButton: usernameController.text != ""
                              ? "APPLICA MODIFICHE"
                              : "SALVA INFORMAZIONI",
                          icon: usernameController.text != ""
                              ? Icons.mode
                              : Icons.save,
                        )
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
