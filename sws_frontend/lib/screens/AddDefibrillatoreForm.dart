import 'dart:convert';
import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sws/components/generali/CustomAppBar.dart';
import 'package:frontend_sws/components/generali/CustomTextField.dart';
import 'package:frontend_sws/components/mappa/MapPicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:mime/mime.dart';
import 'dart:io';
import '../components/generali/CustomButton.dart';
import '../components/loading/AllPageLoad.dart';
import '../services/ImpostazioniService.dart';
import '../services/ServizioService.dart';
import '../services/entity/Contatto.dart';
import '../services/entity/ImageData.dart';
import '../services/entity/Impostazioni.dart';
import '../services/entity/Posizione.dart';
import '../services/entity/Servizio.dart';
import '../services/entity/Struttura.dart';
import '../theme/theme.dart';
import '../util/ToastUtil.dart';

// nome cognome -> struttura con posizione
//

class AddDefibrillatoreForm extends StatefulWidget {
  const AddDefibrillatoreForm({Key? key}) : super(key: key);

  @override
  State<AddDefibrillatoreForm> createState() => _AddDefibrillatoreFormState();
}

class _AddDefibrillatoreFormState extends State<AddDefibrillatoreForm>
    with TickerProviderStateMixin {
  TextEditingController nomeCognomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController descrizioneController = TextEditingController();
  TextEditingController indirizzoController = TextEditingController();
  final _formGlobalKey = GlobalKey<FormState>();
  PickedFile? imageFile;
  bool acceptPolicy = false;
  bool loaded = false;
  Impostazioni? impostazioni;
  ServizioService servizioService = ServizioService();
  ImpostazioniService impostazioniService = ImpostazioniService();
  LatLng? posizione;

  bool errorImmagine = false;
  bool errorPolicy = false;
  bool errorPosizione = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  void load() async {
    impostazioni = await impostazioniService.getImpostazioni();
    loaded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return !loaded
        ? const AllPageLoad()
        : Scaffold(
            appBar: const CustomAppBar(
              title: AppTitle(
                label: 'Nuovo Defibrillatore',
              ),
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Form(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(
                      left: 25.0, top: 10.0, right: 25.0, bottom: 25.0),
                  children: <Widget>[
                    const Text(
                      "Cosa puoi fare?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: AppColors.logoCadmiumOrange),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    // descrizione
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Aiuta i tuoi concittadini a trovare un '),
                          TextSpan(
                              text: 'defibrillatore',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  " nel momento del bisogno, aggiungine uno nuovo indicando:")
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Form(
                        key: _formGlobalKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomTextField(
                                controller: nomeCognomeController,
                                label: "Nome & Cognome",
                                validator: "Inserisci il campo nome",
                              ),
                              CustomTextField(
                                controller: emailController,
                                label: "E-mail",
                                validator: "Inserisci il campo email",
                              ),
                              CustomTextField(
                                controller: telefonoController,
                                label: "Numero di Telefono",
                                validator:
                                    "Inserisci il campo numero di telefono",
                              ),
                              CustomTextField(
                                controller: indirizzoController,
                                label: "Indirizzo",
                                validator: "Inserisci il campo indirizzo",
                              ),
                              const Divider(
                                thickness: 1,
                              ),
                              const SizedBox(
                                height: 12,
                              ),

                              // descrizione
                              const Text(
                                "Aggiungi una descrizione",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              TextFormField(
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return "Inserisci il campo descrizione";
                                  }
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: 4,
                                controller: descrizioneController,
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey), //<-- SEE HERE
                                  ),
                                ),
                              ),

                              // posizione
                              const SizedBox(
                                height: 16,
                              ),
                              const Text("Aggiungi la posizione geografica",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                              const SizedBox(
                                height: 10,
                              ),
                              MapPicker(
                                mapValueChanged: (value) => posizione = value,
                              ),
                              errorPosizione
                                  ? const Text(
                                      "Devi selezionare una posizione sulla mappa!",
                                      style: TextStyle(color: Colors.red))
                                  : Container(),
                              // immagine
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                "Aggiungi un'immagine",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomButton(
                                    onPressed: _getFromGallery,
                                    textButton: "Galleria",
                                    icon: Icons.photo_library,
                                  ),
                                  CustomButton(
                                    onPressed: _getFromCamera,
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
                                thickness: 1,
                              ),
                              TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        title: const Text("Privacy Policy"),
                                        content: const Text(
                                            "Qui andranno le policy"),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              child: const Text("Chiudi")),
                                        ],
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Leggi la privacy policy",
                                    style: TextStyle(color: AppColors.logoBlue),
                                  )),
                              CheckboxListTile(
                                title: const Text(
                                  "Ho letto e accetto la Privacy Policy.",
                                  style: TextStyle(fontSize: 12),
                                ),
                                value: acceptPolicy,
                                onChanged: _onAccept,
                                selectedTileColor: AppColors.white,
                                activeColor: AppColors.logoCadmiumOrange,
                              ),
                              errorPolicy
                                  ? const Text(
                                      "Devi accettare la Privacy Policy!",
                                      style: TextStyle(color: Colors.red))
                                  : Container(),
                              const Divider(
                                thickness: 1,
                              ),

                              const SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                fullWidth: true,
                                onPressed: savePage,
                                icon: Icons.add,
                                textButton: 'AGGIUNGI',
                              )
                            ])),
                  ],
                ),
              ),
            ));
  }

  void savePage() async {
    loaded = true;
    setState(() {});
    bool val = validateNoFormField();
    setState(() {});
    if (_formGlobalKey.currentState!.validate() && val) {
      Servizio defibrillatore = Servizio(
          nome: "nome",
          contatto: Contatto(
              telefono: telefonoController.text, email: emailController.text),
          contenuto: descrizioneController.text,
          struttura: Struttura(
            denominazione: nomeCognomeController.text,
            posizione: Posizione(
              indirizzo: indirizzoController.text,
              latitudine: posizione!.latitude.toString(),
              longitudine: posizione!.longitude.toString(),
            ),
          ),
          immagine: ImageData(
              imageData: base64Encode(await imageFile!.readAsBytes()),
              type: lookupMimeType(imageFile!.path) != null
                  ? lookupMimeType(imageFile!.path)!
                  : "image",
              nome: p.basename(imageFile!.path)));
      Servizio? s;
      try {
        s = await servizioService.createDefibrillatore(defibrillatore);
      } catch (e) {
        if (mounted) {}

        Navigator.of(context).pop();
        ToastUtil.error(e.toString(), context);
        return;
      }
      if (mounted) {}
      if (s == null) {
        ToastUtil.error("Errore server", context);
      } else {
        Navigator.of(context).pop();
        ToastUtil.success("Defibrillatore inviato per la verifica", context);
      }
    }
  }

  bool validateNoFormField() {
    bool ret = false;
    errorImmagine = errorPolicy = errorPosizione = false;
    if (imageFile == null) {
      ret = errorImmagine = true;
    }
    if (!acceptPolicy) {
      ret = errorPolicy = true;
    }
    if (posizione == null) {
      ret = errorPosizione = true;
    }
    return !ret;
  }

  _onAccept(bool? value) {
    setState(() {
      acceptPolicy = value!;
    });
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
