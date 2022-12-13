import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:frontend_sws/components/generali/CustomAppBar.dart';
import 'package:frontend_sws/components/generali/CustomTextField.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../components/generali/CustomButton.dart';
import '../theme/theme.dart';

class DefibMap extends StatefulWidget {
  const DefibMap({Key? key}) : super(key: key);

  @override
  State<DefibMap> createState() => _DefibMapState();
}

class _DefibMapState extends State<DefibMap> with TickerProviderStateMixin {
  TextEditingController nomeCognomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController descrizioneController = TextEditingController();
  late File imageFile;
  bool acceptPolicy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              shrinkWrap: true,
              padding: const EdgeInsets.only(
                  left: 25.0, top: 10.0, right: 25.0, bottom: 25.0),
              children: <Widget>[
                const Text(
                  "Cosa Fare?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColors.logoCadmiumOrange),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 6,
                ),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: 'Aiuta i tuoi concittadini a trovare un '),
                      TextSpan(
                          text: 'defibrillatore',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              " nel momento del bisogno, aggiungine uno nuovo indicando:\n"
                              "Il tuo nome & cognome 🙂\nL'email ✉\nIl numero di telefono 📞\nUn'eventuale descrizione per facilitarne il ritrovamento ℹ\nUn'eventuale immagine del defibrillatore 📷")
                    ],
                  ),
                ),
                CustomTextField(
                    controller: nomeCognomeController, label: "Nome & Cognome"),
                CustomTextField(controller: emailController, label: "E-mail"),
                CustomTextField(
                    controller: telefonoController,
                    label: "Numero di Telefono"),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Aggiungi una descrizione",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 4,
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  controller: descrizioneController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.grey), //<-- SEE HERE
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Aggiungi un'immagine",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                const SizedBox(
                  height: 16,
                ),
                CustomButton(
                  onPressed: () {},
                  icon: Icons.add,
                  textButton: 'Inserisci defibrillatore',
                )
              ],
            ),
          ),
        ));
  }

  _onAccept(bool? value) {
    setState(() {
      acceptPolicy = value!;
    });
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}

/***Dati da inserire**

    Nome e cognome (una sola stringa)

    email

    telefono

    descrizione

    immagine*/
