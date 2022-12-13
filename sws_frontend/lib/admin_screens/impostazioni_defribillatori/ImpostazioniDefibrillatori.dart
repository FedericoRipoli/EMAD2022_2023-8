import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:frontend_sws/services/AreeService.dart';
import 'package:frontend_sws/services/entity/Area.dart';
import 'package:html_editor_enhanced/html_editor.dart';
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
import '../../util/ColorExtension.dart';

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
  String initialHtmlText="";
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

        nImpostazioni  =
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
        floatingActionButton: !loaded
            ? null
            : CustomFloatingButton(
                iconData: Icons.save_rounded,
                onPressed: () => savePage(),
              ),
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        const Text("Seleziona un ente"),
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
                          height: 40,
                        ),
                        const Text("Seleziona un'area"),
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
                        CustomHtmlEditor(
                          controller: htmlController,
                          initialText: initialHtmlText,

                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: _pickIcon,
                              child: const Text('Seleziona l\'icona'),
                            ),
                            const SizedBox(width: 30),
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
