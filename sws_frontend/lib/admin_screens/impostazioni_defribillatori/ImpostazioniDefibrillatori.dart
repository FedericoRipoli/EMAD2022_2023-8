import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:frontend_sws/services/AreeService.dart';
import 'package:frontend_sws/services/entity/Area.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import '../../components/generali/CustomButton.dart';
import '../../components/generali/input/CustomDropDownText.dart';
import '../../components/generali/input/CustomHtmlEditor.dart';
import '../../components/loading/AllPageLoadTransparent.dart';
import '../../components/generali/CustomAppBar.dart';
import '../../components/generali/CustomFloatingButton.dart';
import '../../components/menu/DrawerMenu.dart';
import '../../services/EnteService.dart';
import '../../services/ImpostazioniService.dart';
import '../../services/entity/Ente.dart';
import '../../services/entity/Impostazioni.dart';
import '../../theme/theme.dart';
import '../../util/ToastUtil.dart';

class ImpostazioniDefibrillatori extends StatefulWidget {
  static String id =
      'it.unisa.emad.comunesalerno.sws.ipageutil.ImpostazioniDefibrillatori';

  ImpostazioniDefibrillatori({super.key});

  @override
  State<StatefulWidget> createState() => _ImpostazioniDefibrillatori();
}

class _ImpostazioniDefibrillatori extends State<ImpostazioniDefibrillatori> {
  late Future<bool> initCall;
  ImpostazioniService impostazioniService = ImpostazioniService();

  EnteService enteService = EnteService();
  List<Ente>? enti;
  List<CustomDropDownItem> itemsEnte = [];
  String? dropdownValueEnte;

  AreeService areaService = AreeService();
  List<Area>? aree;
  List<CustomDropDownItem> itemsAree = [];
  String? dropdownValueAree;
  HtmlEditorController htmlController = HtmlEditorController();

  Icon? _icon;

  Impostazioni? impostazioni;
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();
  String initialHtmlText = "";
  bool loaded = false;
  bool iconError = false;
  final _formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initCall = load();
  }

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);

    _icon = Icon(icon);
    setState(() {});
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

    aree = await areaService.areeList(null);
    if (aree != null) {
      itemsAree.add(CustomDropDownItem(
        id: null,
        name: "",
      ));
      itemsAree.addAll(aree!.map<CustomDropDownItem>((Area value) {
        return CustomDropDownItem(
          id: value.id,
          name: value.nome,
        );
      }).toList());
    }

    impostazioni = await impostazioniService.getImpostazioni();
    if (impostazioni != null) {
      dropdownValueAree = impostazioni!.idArea;
      dropdownValueEnte = impostazioni!.idEnte;
      initialHtmlText = impostazioni!.privacyPolicy;
      _icon = Icon(impostazioni!.getIconData());
    }
    setState(() {
      loaded = true;
    });
    return true;
  }

  void savePage() async {
    if (_formGlobalKey.currentState!.validate()) {
      iconError = false;

      if (_icon == null) {
        iconError = true;
        setState(() {});
        return;
      }
      _formGlobalKey.currentState?.save();
      setState(() {
        loaded = false;
      });
      Impostazioni? nImpostazioni;

      if (impostazioni == null) {
        nImpostazioni = Impostazioni(
            icon: _icon!.icon!.codePoint.toString(),
            idEnte: dropdownValueEnte!,
            idArea: dropdownValueAree!,
            privacyPolicy: await htmlController.getText());

        nImpostazioni =
            await impostazioniService.createImpostazioni(nImpostazioni!);
      } else {
        impostazioni!.icon = _icon!.icon!.codePoint.toString();
        impostazioni!.idEnte = dropdownValueEnte!;
        impostazioni!.idArea = dropdownValueAree!;
        impostazioni!.privacyPolicy = await htmlController.getText();

        nImpostazioni =
            await impostazioniService.editImpostazioni(impostazioni!);
      }
      if (mounted) {}
      if (nImpostazioni != null) {
        Navigator.of(context).pop();
        ToastUtil.success("Impostazioni aggiornate", context);
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
        drawer: DrawerMenu(currentPage: ImpostazioniDefibrillatori.id),
        appBar: CustomAppBar(
            title: const AppTitle(label: "Impostazioni defibrillatori"),
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
                              Icons.monitor_heart,
                              color: AppColors.logoCadmiumOrange,
                              size: 24,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text("Impostazioni di visualizzazione")
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "Seleziona l'ente",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        CustomDropDownText(
                            value: dropdownValueEnte,
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
                              dropdownValueEnte = value.toString();
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Seleziona l'area",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomDropDownText(
                            value: dropdownValueAree,
                            name: "Seleziona aree",
                            values: itemsAree,
                            validator: (value) {
                              if (value == null) {
                                return 'Seleziona un\'area';
                              }
                            },
                            onChanged: (value) {
                              //Do something when changing the item if you want.
                            },
                            onSaved: (value) {
                              dropdownValueAree = value.toString();
                            }),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "Aggiungi una descrizione",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        CustomHtmlEditor(
                          controller: htmlController,
                          initialText: initialHtmlText,
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: _pickIcon,
                              child: const Text(
                                'Seleziona l\'icona',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            const SizedBox(width: 15),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: _icon ?? Container(),
                            ),
                            if (iconError)
                              const Text(
                                "Icona obbligatoria",
                                style: TextStyle(color: Colors.red),
                              )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomButton(
                          onPressed: savePage,
                          fullWidth: true,
                          textButton: "SALVA MODIFICHE",
                          icon: Icons.save,
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
