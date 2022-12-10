import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:frontend_sws/services/entity/Struttura.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../components/generali/CustomAppBar.dart';
import '../../components/generali/CustomFloatingButton.dart';
import '../../components/loading/AllPageLoadTransparent.dart';
import '../../components/menu/DrawerMenu.dart';
import '../../services/AreeService.dart';
import '../../services/ServizioService.dart';
import '../../services/StrutturaService.dart';
import '../../services/entity/Area.dart';
import '../../services/entity/Contatto.dart';
import '../../services/entity/Servizio.dart';
import '../../util/ToastUtil.dart';

class GestioneServizio extends StatefulWidget {
  String? idServizio;
  String idEnte;
  static String id =
      'it.unisa.emad.comunesalerno.sws.ipageutil.GestioneServizio';

  GestioneServizio({required this.idEnte, this.idServizio, super.key});

  @override
  State<StatefulWidget> createState() => _GestioneServizio();
}

class _GestioneServizio extends State<GestioneServizio> {
  late Future<bool> initCall;
  ServizioService servizioService = ServizioService();

  AreeService areeService = AreeService();
  StrutturaService strutturaService = StrutturaService();
  Servizio? servizio;
  String? strutturaValue;
  List<String> areeValues = [];
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();

  TextEditingController noteController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController sitoWebController = TextEditingController();
  TextEditingController contenutoController = TextEditingController();
  TextfieldTagsController tagController = TextfieldTagsController();
  late double _distanceToField;
  Icon? _icon;
  bool loaded = false;
  final _formGlobalKey = GlobalKey<FormState>();
  late List<DropdownMenuItem<String>> itemsAree = [];
  late List<DropdownMenuItem<String>> itemsStrutture = [];
  List<Area>? aree = [];

  @override
  void initState() {
    super.initState();
    initCall = load();
  }

  Future<bool> load() async {
    aree = await areeService.areeList(null);
    if (aree != null) {
      itemsAree.addAll(aree!.map<DropdownMenuItem<String>>((Area item) {
        return DropdownMenuItem<String>(
            value: item.id,
            enabled: false,
            child: StatefulBuilder(
              builder: (context, menuSetState) {
                final _isSelected = areeValues.contains(item.id);
                return InkWell(
                    onTap: () {
                      _isSelected
                          ? areeValues.remove(item.id)
                          : areeValues.add(item.id!);
                      setState(() {});
                      menuSetState(() {});
                    },
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                            height: double.infinity,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                _isSelected
                                    ? const Icon(Icons.check_box_outlined)
                                    : const Icon(
                                        Icons.check_box_outline_blank_outlined),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(item.nome)
                              ],
                            ))));
              },
            ));
      }).toList());
    }
    List<Struttura>? strutture =
        await strutturaService.struttureList(null, widget.idEnte);
    if (strutture != null) {
      itemsStrutture.add(const DropdownMenuItem<String>(
        value: null,
        child: Text(""),
      ));
      itemsStrutture
          .addAll(strutture!.map<DropdownMenuItem<String>>((Struttura value) {
        return DropdownMenuItem<String>(
          value: value.id,
          child: Text(value.denominazione!),
        );
      }).toList());
    }

    servizio = widget.idServizio != null
        ? await servizioService.getServizio(widget.idServizio!)
        : null;
    if (servizio != null) {
      strutturaValue = servizio!.struttura!.id;
      areeValues = servizio!.aree!.map((e) => e.id!).toList();
      nomeController.text = (servizio!.nome);
      servizio!.hashtags?.forEach((e) {
        tagController.addTag = (e);
      });
      if (servizio!.contenuto != null) {
        contenutoController.text = (servizio!.contenuto!);
      }
      if (servizio!.note != null) {
        noteController.text = (servizio!.note!);
      }
      if (servizio!.contatto != null) {
        sitoWebController.text = servizio!.contatto!.sitoWeb != null
            ? servizio!.contatto!.sitoWeb!
            : "";
        telefonoController.text = servizio!.contatto!.telefono != null
            ? servizio!.contatto!.telefono!
            : "";
        emailController.text =
            servizio!.contatto!.email != null ? servizio!.contatto!.email! : "";
      }
      if (servizio!.customIcon != null) {
        _icon = Icon(servizio!.getIconData());
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
      Servizio? nServizio;
      if (widget.idServizio == null) {
        nServizio = await servizioService.createServizio(Servizio(
          nome: nomeController.value.text,
          contenuto: contenutoController.value.text,
          contatto: Contatto(
            telefono: telefonoController.value.text,
            email: emailController.value.text,
            sitoWeb: sitoWebController.value.text,
          ),
          hashtags: tagController.getTags,
          idAree: areeValues,
          idStruttura: strutturaValue,
          customIcon: _icon != null ? _icon!.icon!.codePoint.toString() : null,
        ));
      } else {
        servizio!.nome = nomeController.value.text;
        servizio!.contatto!.telefono = telefonoController.value.text;
        servizio!.contatto!.email = emailController.value.text;
        servizio!.contatto!.sitoWeb = sitoWebController.value.text;
        servizio!.contenuto = contenutoController.value.text;
        servizio!.idAree = areeValues;
        servizio!.idStruttura = strutturaValue;
        servizio!.hashtags = tagController.getTags;
        servizio!.customIcon =
            _icon != null ? _icon!.icon!.codePoint.toString() : null;
        nServizio = await servizioService.editServizio(servizio!);
      }
      if (mounted) {}
      if (nServizio != null) {
        Navigator.of(context).pop();
        ToastUtil.success(
            "Servizio ${widget.idServizio == null ? 'aggiunto' : 'modificato'}",
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKeyAdmin,
        resizeToAvoidBottomInset: false,
        drawer: DrawerMenu(currentPage: GestioneServizio.id),
        floatingActionButton: !loaded ||
                (servizio != null && !Servizio.canEnteEdit(servizio!.stato))
            ? null
            : CustomFloatingButton(
                iconData: Icons.save_rounded,
                onPressed: () => savePage(),
              ),
        appBar: CustomAppBar(
            title: const AppTitle(label: "Gestione Servizio"),
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
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: TextFormField(
                          enabled: (servizio == null ||
                              Servizio.canEnteEdit(servizio!.stato)),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
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
                        height: 40,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: TextFormField(
                          enabled: (servizio == null ||
                              Servizio.canEnteEdit(servizio!.stato)),
                          validator: (v) {},
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'E-mail',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: TextFormField(
                          enabled: (servizio == null ||
                              Servizio.canEnteEdit(servizio!.stato)),
                          validator: (v) {},
                          controller: telefonoController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Telefono',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: TextFormField(
                          enabled: (servizio == null ||
                              Servizio.canEnteEdit(servizio!.stato)),
                          validator: (v) {},
                          controller: sitoWebController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Sito Web',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          enabled: (servizio == null ||
                              Servizio.canEnteEdit(servizio!.stato)),
                          validator: (v) {},
                          controller: contenutoController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Descrizione',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: DropdownButtonFormField2<String>(
                            value: strutturaValue,
                            decoration: InputDecoration(
                              //Add isDense true and zero Padding.
                              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              //Add more decoration as you want here
                              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                            ),
                            isExpanded: true,
                            hint: const Text(
                              'Seleziona struttura',
                              style: TextStyle(fontSize: 14),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 30,
                            buttonHeight: 60,
                            buttonPadding:
                                const EdgeInsets.only(left: 20, right: 10),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            items: itemsStrutture,
                            validator: (value) {
                              if (value == null) {
                                return 'Seleziona una struttura';
                              }
                            },
                            onChanged: (servizio == null ||
                                    Servizio.canEnteEdit(servizio!.stato))
                                ? (value) {
                                    //Do something when changing the item if you want.
                                  }
                                : null,
                            onSaved: (value) {
                              strutturaValue = value.toString();
                            },
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: DropdownButtonFormField2<String>(
                            value: areeValues.isEmpty ? null : areeValues.last,
                            decoration: InputDecoration(
                              //Add isDense true and zero Padding.
                              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              //Add more decoration as you want here
                              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                            ),
                            isExpanded: true,
                            hint: const Text(
                              'Seleziona aree',
                              style: TextStyle(fontSize: 14),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 30,
                            buttonHeight: 60,
                            buttonPadding:
                                const EdgeInsets.only(left: 20, right: 10),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            items: itemsAree,
                            validator: (value) {
                              if (value == null) {
                                return 'Seleziona almeno un\'area';
                              }
                            },
                            onChanged: (servizio == null ||
                                    Servizio.canEnteEdit(servizio!.stato))
                                ? (value) {
                                    //Do something when changing the item if you want.
                                  }
                                : null,
                            onSaved: (value) {
                              //areeValues = value;
                            },
                            buttonWidth: 140,
                            itemHeight: 40,
                            itemPadding: EdgeInsets.zero,
                            selectedItemBuilder: (context) {
                              return aree!.map(
                                (item) {
                                  return Container(
                                    alignment: AlignmentDirectional.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text(
                                      aree!
                                          .where((element) =>
                                              areeValues.contains(element.id!))
                                          .map((e) => e.nome)
                                          .join(', '),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                  );
                                },
                              ).toList();
                            },
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFieldTags(
                          textfieldTagsController: tagController,
                          initialTags: [],
                          textSeparators: const [' ', ','],
                          inputfieldBuilder: (context, tec, fn, error,
                              onChanged, onSubmitted) {
                            return ((context, sc, tags, onTagDelete) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 50, right: 50),
                                child: TextField(
                                  enabled: servizio == null ||
                                      Servizio.canEnteEdit(servizio!.stato),
                                  controller: tec,
                                  focusNode: fn,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.logoBlue,
                                        width: 3.0,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.logoBlue,
                                        width: 3.0,
                                      ),
                                    ),
                                    helperStyle: const TextStyle(
                                        color: AppColors.logoBlue),
                                    hintText: tagController.hasTags
                                        ? ''
                                        : "Tag di ricerca...",
                                    errorText: error,
                                    prefixIconConstraints: BoxConstraints(
                                        maxWidth: _distanceToField * 0.74),
                                    prefixIcon: tags.isNotEmpty
                                        ? SingleChildScrollView(
                                            controller: sc,
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                                children:
                                                    tags.map((String tag) {
                                              return Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(15.0),
                                                  ),
                                                  color: AppColors.logoBlue,
                                                ),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 5.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      child: Text(
                                                        '$tag',
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      onTap: () {
                                                        //print("$tag selected");
                                                      },
                                                    ),
                                                    const SizedBox(width: 4.0),
                                                    InkWell(
                                                      child: const Icon(
                                                        Icons.cancel,
                                                        size: 14.0,
                                                        color: Color.fromARGB(
                                                            255, 233, 233, 233),
                                                      ),
                                                      onTap: () {
                                                        onTagDelete(tag);
                                                      },
                                                    )
                                                  ],
                                                ),
                                              );
                                            }).toList()),
                                          )
                                        : null,
                                  ),
                                  //onChanged: onChanged,
                                  // onSubmitted: onSubmitted,
                                ),
                              );
                            });
                          }),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: Row(
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
                              if (_icon != null)
                                IconButton(
                                    onPressed: _removeIcon,
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    ))
                            ],
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      (servizio != null && servizio!.note != null)
                          ? TextField(
                              enabled: false,
                              controller: noteController,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Note admin',
                              ))
                          : const SizedBox(
                              height: 0,
                            ),
                    ],
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

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);

    _icon = Icon(icon);
    setState(() {});
  }

  _removeIcon() {
    _icon = null;
    setState(() {});
  }
}
