import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:frontend_sws/components/generali/CustomTextField.dart';
import 'package:frontend_sws/services/entity/Struttura.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../components/generali/CustomAppBar.dart';
import '../../components/generali/CustomButton.dart';
import '../../components/generali/input/CustomDropDown.dart';
import '../../components/generali/input/CustomDropDownText.dart';
import '../../components/generali/CustomFloatingButton.dart';
import '../../components/loading/AllPageLoadTransparent.dart';
import '../../components/menu/DrawerMenu.dart';
import '../../services/AreeService.dart';
import '../../services/ServizioService.dart';
import '../../services/StrutturaService.dart';
import '../../services/entity/Area.dart';
import '../../services/entity/Contatto.dart';
import '../../services/entity/ImageData.dart';
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
  bool errorImmagine = false;
  PickedFile? imageFile;

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
  late List<CustomDropDownItem> itemsStrutture = [];
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
      itemsStrutture.add(CustomDropDownItem(
        id: null,
        name: "",
      ));
      itemsStrutture
          .addAll(strutture!.map<CustomDropDownItem>((Struttura value) {
        return CustomDropDownItem(
          id: value.id,
          name: (value.denominazione!),
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

  bool validateNoFormField() {
    bool ret = false;
    errorImmagine = false;
    if (imageFile == null) {
      ret = errorImmagine = true;
    }
    return !ret;
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
            customIcon:
                _icon != null ? _icon!.icon!.codePoint.toString() : null,
            immagine: (imageFile != null)
                ? ImageData(
                    imageData: base64Encode(await imageFile!.readAsBytes()),
                    type: lookupMimeType(imageFile!.path) != null
                        ? lookupMimeType(imageFile!.path)!
                        : "image",
                    nome: p.basename(imageFile!.path))
                : null));
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
        if (imageFile != null) {
          servizio!.immagine = ImageData(
              imageData: base64Encode(await imageFile!.readAsBytes()),
              type: lookupMimeType(imageFile!.path) != null
                  ? lookupMimeType(imageFile!.path)!
                  : "image",
              nome: p.basename(imageFile!.path));
        }
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
        appBar: CustomAppBar(
            title: const AppTitle(label: "Gestione Servizio"),
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
                              Icons.handshake_rounded,
                              color: AppColors.logoCadmiumOrange,
                              size: 24,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text("Modifica/Aggiungi servizio")
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          nomeController.text != ""
                              ? "Modifica tutte le informazioni del servizio"
                              : "Inserisci un nuovo servizio inserendo tutte le informazioni.",
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        CustomTextField(
                          controller: nomeController,
                          label: "Nome servizio",
                          validator: "Inserisci il campo nome",
                          enabled: (servizio == null ||
                              Servizio.canEnteEdit(servizio!.stato)),
                        ),
                        CustomTextField(
                          controller: emailController,
                          label: "Email referente",
                          enabled: (servizio == null ||
                              Servizio.canEnteEdit(servizio!.stato)),
                        ),
                        CustomTextField(
                          controller: telefonoController,
                          label: "Telefono referente",
                          validator: "Inserisci il campo telefono",
                          enabled: (servizio == null ||
                              Servizio.canEnteEdit(servizio!.stato)),
                        ),
                        CustomTextField(
                          controller: sitoWebController,
                          label: "Sito WEB",
                          enabled: (servizio == null ||
                              Servizio.canEnteEdit(servizio!.stato)),
                        ),
                        CustomTextField(
                          controller: contenutoController,
                          label: "Descrizione servizio",
                          validator: "Inserisci il campo descrizione",
                          multiline: true,
                          enabled: (servizio == null ||
                              Servizio.canEnteEdit(servizio!.stato)),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "Scegli la struttura che offre il servizio e l'area di riferimento",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        CustomDropDown(
                          values: itemsStrutture,
                          name: 'Seleziona struttura',
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
                          value: strutturaValue,
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: DropdownButtonFormField2<String>(
                            value: areeValues.isEmpty ? null : areeValues.last,
                            decoration: InputDecoration(
                              //Add isDense true and zero Padding.
                              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
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
                              borderRadius: BorderRadius.circular(20),
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
                          ),
                        ),
                        TextFieldTags(
                            textfieldTagsController: tagController,
                            initialTags: ["servizio"],
                            textSeparators: const [' ', ','],
                            inputfieldBuilder: (context, tec, fn, error,
                                onChanged, onSubmitted) {
                              return ((context, sc, tags, onTagDelete) {
                                return Container(
                                  margin: const EdgeInsets.all(10),
                                  child: TextField(
                                    enabled: servizio == null ||
                                        Servizio.canEnteEdit(servizio!.stato),
                                    controller: tec,
                                    focusNode: fn,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: AppColors.logoBlue,
                                          width: 3.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
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
                                          maxWidth: _distanceToField * 0.60),
                                      prefixIcon: tags.isNotEmpty
                                          ? SingleChildScrollView(
                                              controller: sc,
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                  children:
                                                      tags.map((String tag) {
                                                return Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(15.0),
                                                    ),
                                                    color: AppColors.logoBlue,
                                                  ),
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5.0),
                                                  padding: const EdgeInsets
                                                          .symmetric(
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
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        onTap: () {
                                                          //print("$tag selected");
                                                        },
                                                      ),
                                                      const SizedBox(
                                                          width: 4.0),
                                                      InkWell(
                                                        child: const Icon(
                                                          Icons.cancel,
                                                          size: 14.0,
                                                          color: Color.fromARGB(
                                                              255,
                                                              233,
                                                              233,
                                                              233),
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
                                    onChanged: onChanged,
                                    onSubmitted: onSubmitted,
                                  ),
                                );
                              });
                            }),
                        TextButton(
                            onPressed: servizio == null ||
                                    Servizio.canEnteEdit(servizio!.stato)
                                ? () {
                                    tagController.clearTags();
                                  }
                                : null,
                            child: const Text(
                              "SVUOTA TAG",
                              style: TextStyle(
                                  color: AppColors.logoCadmiumOrange,
                                  fontWeight: FontWeight.w700),
                            )),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            child: Row(
                              children: [
                                ElevatedButton(
                                  onPressed: (servizio == null ||
                                          Servizio.canEnteEdit(servizio!.stato))
                                      ? _pickIcon
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  child: const Text('Icona su mappa'),
                                ),
                                const SizedBox(width: 30),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child: _icon ?? Container(),
                                ),
                                if (_icon != null)
                                  IconButton(
                                      onPressed: (servizio == null ||
                                              Servizio.canEnteEdit(
                                                  servizio!.stato))
                                          ? _removeIcon
                                          : null,
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Colors.red,
                                      ))
                              ],
                            )),
                        const Divider(
                          thickness: 2,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomButton(
                              onPressed: (servizio == null ||
                                  Servizio.canEnteEdit(
                                      servizio!.stato)) ? _getFromGallery : null,
                              textButton: "Galleria",
                              icon: Icons.photo_library,
                            ),
                            CustomButton(
                              onPressed: (servizio == null ||
                                  Servizio.canEnteEdit(
                                      servizio!.stato)) ? _getFromCamera : null,
                              textButton: "Fotocamera",
                              icon: Icons.camera_alt,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          child: imageFile != null
                              ? (kIsWeb
                                  ? Image.network(imageFile!.path)
                                  : Image.file(File(imageFile!.path)))
                              : servizio != null && servizio!.immagine != null
                                  ? Column(

                            children: [
                              Image.memory(base64Decode(
                                  servizio!.immagine!.imageData)),
                              TextButton(
                                  onPressed: servizio == null ||
                                      Servizio.canEnteEdit(servizio!.stato)
                                      ? () {
                                    imageFile=null;
                                    servizio!.immagine=null;
                                    setState(() {

                                    });
                                  }
                                      : null,
                                  child: const Text(
                                    "RIMUOVI IMMAGINE",
                                    style: TextStyle(
                                        color: AppColors.logoCadmiumOrange,
                                        fontWeight: FontWeight.w700),
                                  ))
                            ],
                          )

                                  : const Text(
                                      "Nessuna immagine selezionata",
                                      textAlign: TextAlign.center,
                                    ),
                        ),
                        errorImmagine
                            ? const Text("Devi inserire una foto!",
                                style: TextStyle(color: Colors.red))
                            : Container(),
                        const SizedBox(
                          height: 16,
                        ),
                        // termini privacy
                        const Divider(
                          thickness: 2,
                        ),
                        const SizedBox(
                          height: 20,
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
                        CustomButton(
                          onPressed: !loaded ||
                                  (servizio != null &&
                                      !Servizio.canEnteEdit(servizio!.stato))
                              ? null
                              : savePage,
                          fullWidth: true,
                          textButton: nomeController.text != ""
                              ? "APPLICA MODIFICHE"
                              : "SALVA INFORMAZIONI",
                          icon: nomeController.text != ""
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

  Future _getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      setState(() => imageFile = PickedFile(image.path));
    } catch (e) {
      print('Errore inserimento immagine: $e');
    }
  }

  Future _getFromGallery() async {
    _getImage(ImageSource.gallery);
  }

  /// Get from Camera
  Future _getFromCamera() async {
    _getImage(ImageSource.camera);
  }
}
