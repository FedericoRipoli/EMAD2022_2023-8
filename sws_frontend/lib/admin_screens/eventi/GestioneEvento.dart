import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sws/services/EventoService.dart';
import 'package:intl/intl.dart';
import 'package:textfield_tags/textfield_tags.dart';
// componenti
import '../../components/generali/CustomAppBar.dart';
import '../../components/generali/CustomButton.dart';
import '../../components/generali/CustomTextField.dart';
import '../../components/loading/AllPageLoadTransparent.dart';
import '../../components/menu/DrawerMenu.dart';
import '../../services/AreeService.dart';
import '../../services/entity/Area.dart';
import '../../services/entity/Contatto.dart';
import '../../services/entity/Evento.dart';
import '../../theme/theme.dart';
import '../../util/ToastUtil.dart';

class GestioneEvento extends StatefulWidget {
  String? idEvento;
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.GestioneEvento';

  GestioneEvento({Key? key, this.idEvento}) : super(key: key);

  @override
  State<GestioneEvento> createState() => _GestioneEventoState();
}

class _GestioneEventoState extends State<GestioneEvento> {
  //
  bool loaded = false;
  late Future<bool> initCall;
  Evento? evento;
  late double _distanceToField;
  // service
  EventoService eventoService = EventoService();
  AreeService areeService = AreeService();
  // area
  List<String> areeValues = [];
  late List<DropdownMenuItem<String>> itemsAree = [];
  List<Area>? aree = [];
  // keys
  final _formGlobalKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();

  // controller
  TextEditingController noteController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController contenutoController = TextEditingController();
  TextEditingController dataInizioController = TextEditingController();
  TextEditingController dataFineController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController sitoWebController = TextEditingController();
  TextfieldTagsController tagController = TextfieldTagsController();

  // date picker

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
    evento = widget.idEvento != null
        ? await eventoService.getEvento(widget.idEvento!)
        : null;
    if (evento != null) {
      areeValues = evento!.aree!.map((e) => e.id!).toList();
      nomeController.text = (evento!.nome);
      evento!.hashtags?.forEach((e) {
        tagController.addTag = (e);
      });
      if (evento!.contenuto != null) {
        contenutoController.text = (evento!.contenuto!);
      }
      if (evento!.dataInizio != null) {
        dataInizioController.text = (evento!.dataInizio!);
      }
      if (evento!.dataFine != null) {
        dataFineController.text = (evento!.dataFine!);
      }
      if (evento!.note != null) {
        noteController.text = (evento!.note!);
      }
      if (evento!.contatto != null) {
        sitoWebController.text =
            evento!.contatto!.sitoWeb != null ? evento!.contatto!.sitoWeb! : "";
        telefonoController.text = evento!.contatto!.telefono != null
            ? evento!.contatto!.telefono!
            : "";
        emailController.text =
            evento!.contatto!.email != null ? evento!.contatto!.email! : "";
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
      Evento? nEvento;
      if (widget.idEvento == null) {
        nEvento = await eventoService.createEvento(Evento(
          nome: nomeController.value.text,
          contenuto: contenutoController.value.text,
          contatto: Contatto(
            telefono: telefonoController.value.text,
            email: emailController.value.text,
            sitoWeb: sitoWebController.value.text,
          ),
          hashtags: tagController.getTags,
          idAree: areeValues,
          dataInizio: dataInizioController.value.text,
          dataFine: dataFineController.value.text,
        ));
      } else {
        evento!.nome = nomeController.value.text;
        evento!.contatto!.telefono = telefonoController.value.text;
        evento!.contatto!.email = emailController.value.text;
        evento!.contatto!.sitoWeb = sitoWebController.value.text;
        evento!.contenuto = contenutoController.value.text;
        evento!.idAree = areeValues;
        evento!.hashtags = tagController.getTags;
        evento!.dataInizio = dataInizioController.value.text;
        evento!.dataFine = dataFineController.value.text;
        nEvento = await eventoService.editEvento(evento!);
      }
      if (mounted) {}
      if (nEvento != null) {
        Navigator.of(context).pop();
        ToastUtil.success(
            "Evento ${widget.idEvento == null ? 'aggiunto' : 'modificato'}",
            context);
      } else {
        ToastUtil.error("Errore server", context);
      }
      setState(() {
        loaded = true;
      });
    }
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKeyAdmin,
        resizeToAvoidBottomInset: false,
        drawer: DrawerMenu(currentPage: GestioneEvento.id),
        appBar: CustomAppBar(
            title: const AppTitle(label: "Gestione Evento"),
            iconData: Icons.arrow_back,
            onPressed: () => Navigator.pop(context)),
        body: FutureBuilder<bool>(
          future: initCall,
          builder: ((context, snapshot) {
            //
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
                            Icons.event_available,
                            color: AppColors.logoCadmiumOrange,
                            size: 24,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text("Modifica/Aggiungi evento")
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        nomeController.text != ""
                            ? "Modifica tutte le informazioni dell'evento"
                            : "Inserisci un nuovo evento inserendo tutte le informazioni.",
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
                        label: "Nome evento",
                        validator: "Inserisci il campo nome",
                      ),
                      CustomTextField(
                        controller: emailController,
                        label: "Email referente",
                        validator: "Inserisci il campo email",
                      ),
                      CustomTextField(
                        controller: telefonoController,
                        label: "Telefono referente",
                        validator: "Inserisci il campo telefono",
                      ),
                      CustomTextField(
                        controller: sitoWebController,
                        label: "Sito WEB evento",
                        validator: "Inserisci il campo sito WEB",
                      ),
                      CustomTextField(
                        controller: contenutoController,
                        label: "Descrizione evento",
                        validator: "Inserisci il campo descrizione",
                      ),
                      CustomTextField(
                        controller: dataInizioController,
                        label: "Data inizio evento",
                        validator: "inserisci data inizio evento",
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                "data inizio: $formattedDate"); //formatted date output using intl package =>  2021-03-16
                            setState(() {
                              dataInizioController.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                      ),
                      CustomTextField(
                        controller: dataFineController,
                        label: "Data fine evento",
                        validator: "inserisci data fine evento",
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                " data fine $formattedDate"); //formatted date output using intl package =>  2021-03-16
                            setState(() {
                              dataFineController.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "Scegli l'aree di riferimento di cui l'evento fa parte e i tag per facilitare la ricerca",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: DropdownButtonFormField2<String>(
                          value: areeValues.isEmpty ? null : areeValues.last,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
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
                          onChanged: (evento == null ||
                                  Evento.canEnteEdit(evento!.stato))
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
                          initialTags: [],
                          textSeparators: const [' ', ','],
                          inputfieldBuilder: (context, tec, fn, error,
                              onChanged, onSubmitted) {
                            return ((context, sc, tags, onTagDelete) {
                              return Container(
                                margin: const EdgeInsets.all(10),
                                child: TextField(
                                  enabled: evento == null ||
                                      Evento.canEnteEdit(evento!.stato),
                                  controller: tec,
                                  focusNode: fn,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: AppColors.logoBlue,
                                        width: 3.0,
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
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
                      const Divider(
                        thickness: 2,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      (evento != null && evento!.note != null)
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
                        onPressed: () => !loaded ||
                                (evento != null &&
                                    !Evento.canEnteEdit(evento!.stato))
                            ? null
                            : savePage,
                        fullWidth: true,
                        textButton: nomeController.text != ""
                            ? "APPLICA MODIFICHE"
                            : "SALVA INFORMAZIONI",
                        icon:
                            nomeController.text != "" ? Icons.mode : Icons.save,
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
          }),
        ));
  }
}

// campi
/**
 * contenuto
 * data_fine
 * data_inizio
 * nome
 * note
 * stato
 * contatto
 * id_ente
 * posizione
 * locandina
 */
