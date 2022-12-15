import 'package:flutter/material.dart';
import 'package:frontend_sws/components/generali/CustomButton.dart';
import 'package:frontend_sws/components/generali/CustomTextField.dart';
import 'package:frontend_sws/main.dart';
import 'package:frontend_sws/services/ServizioService.dart';
import 'package:frontend_sws/services/UserService.dart';
import 'package:getwidget/getwidget.dart';
import '../../services/entity/Servizio.dart';
import '../../theme/theme.dart';
import '../../util/ToastUtil.dart';
import '../loading/AllPageLoad.dart';

// Form Login Ente / Comune
class InModificaServizio extends StatefulWidget {
  Servizio servizio;

  InModificaServizio({super.key, required this.servizio});

  @override
  State<InModificaServizio> createState() => _InModificaServizioState();
}

class _InModificaServizioState extends State<InModificaServizio> {
  final ServizioService servizioService = ServizioService();

  TextEditingController noteController = TextEditingController();
  var _isLoading = false;
  var _serverError = false;

  Future<bool> edit() async {
    setState(() => {_isLoading = true, _serverError = false});

    Servizio? s = await servizioService.editStatoServizio(
        widget.servizio.id!, Servizio.IN_MODIFICA, noteController.text);
    if(mounted){}
    Navigator.of(context).pop();

    if (s == null) {
      ToastUtil.error("Errore server", context);
    } else {
      ToastUtil.success("Servizio inviato per la modifica", context);
    }
    setState(() => {_isLoading = false});
    if (s != null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.all(6),
          child: !_isLoading
              ? Column(
                  children: [
                    Container(
                        width: 400,
                        alignment: Alignment.center,
                        child: const Text(
                          'Aggiungi note',
                          style: TextStyle(
                              color: AppColors.logoCadmiumOrange,
                              fontFamily: "FredokaOne",
                              fontSize: 24),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Inserisci il campo Note";
                          }
                        },
                        controller: noteController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Note',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      child: CustomButton(
                        onPressed: () async {
                          bool res = await edit();

                        },
                        textButton: "Richiedi modifiche",
                        icon: Icons.login_outlined,
                      ),
                    ),
                  ],
                )
              : Container(
                  height: 200,
                  width: 200,
                  alignment: Alignment.center,
                  child: const AllPageLoad())),
    );
  }
}
