import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:frontend_sws/components/generali/CustomButton.dart';
import 'package:frontend_sws/components/generali/ImageVisualizer.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/entity/Evento.dart';
import '../../util/ManageDate.dart';

class DetailPageEvento extends StatefulWidget {
  Evento evento;

  DetailPageEvento({super.key, required this.evento});

  @override
  _DetailPageEventoState createState() => _DetailPageEventoState();
}

class _DetailPageEventoState extends State<DetailPageEvento> {
  bool isContactDisable = true;
  bool isEmailDisable = true;
  bool isSitoDisable = true;

  @override
  void initState() {
    setDisable();
    super.initState();
  }

  void setDisable() {
    if (widget.evento.contatto?.telefono != null &&
        widget.evento.contatto?.telefono != "") {
      setState(() {
        isContactDisable = false;
      });
    } else {
      setState(() {
        isContactDisable = true;
      });
    }
    if (widget.evento.contatto?.email != null &&
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(widget.evento.contatto!.email!)) {
      setState(() {
        isEmailDisable = false;
      });
    } else {
      setState(() {
        isEmailDisable = true;
      });
    }
    if (widget.evento.contatto?.sitoWeb != null &&
        widget.evento.contatto?.sitoWeb?.trim() != "") {
      setState(() {
        isSitoDisable = false;
      });
    } else {
      setState(() {
        isSitoDisable = true;
      });
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<void> _sendEmail(String email, String subject, String body) async {
    final Uri launchUri = Uri(
        scheme: 'mailto',
        path: email,
        query: encodeQueryParameters(
            <String, String>{'subject': subject, 'body': body}));
    await launchUrl(launchUri);
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets defaultPaddingElement = const EdgeInsets.fromLTRB(15, 0, 15, 0);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipPath(
                      clipper: WaveClipperOne(),
                      child: Container(
                        height: 120,
                        color: AppColors.logoBlue,
                        child: Center(
                            child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.evento.nome,
                              style: const TextStyle(
                                  color: AppColors.white,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20),
                            ),
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Informazioni",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.logoCadmiumOrange),
                ),
                GFCard(
                  elevation: 3,
                  title: GFListTile(
                    title: Text(
                      widget.evento.nome,
                      style: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                    subTitle: Text(
                      widget.evento.posizione?.indirizzo != null
                          ? "${widget.evento.posizione?.indirizzo}"
                          : "Indirizzo non disponibile",
                      style: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    description: Text(
                      widget.evento.dataInizio != null
                          ? "Da ${ManageDate.formatDate(DateTime.parse(widget.evento.dataInizio!), context)}\na ${ManageDate.formatDate(DateTime.parse(widget.evento.dataFine!), context)}"
                          : "Data non disponibile",
                      style: const TextStyle(fontSize: 16),
                    ),
                    icon: const Icon(
                      Icons.location_on,
                      color: AppColors.logoCadmiumOrange,
                    ),
                  ),
                ),
                GFCard(
                  elevation: 3,
                  title: GFListTile(
                    title: const Text(
                      "Descrizione",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    icon: const Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.logoCadmiumOrange,
                    ),
                    subTitle: TextButton(
                        onPressed: () => isSitoDisable
                            ? null
                            : _launchInBrowser(Uri.parse(
                                "https://${widget.evento.contatto?.sitoWeb?.substring(4)}")),
                        child: Text(
                          isSitoDisable
                              ? "Nessun Sito WEB"
                              : widget.evento.contatto!.sitoWeb!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.logoBlue,
                          ),
                        )),
                    description: Text(
                      (widget.evento.contenuto != null)
                          ? widget.evento.contenuto!
                          : "Nessuna descrizione",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                widget.evento.locandina != null
                    ? Padding(
                        padding: const EdgeInsets.all(0),
                        child: ImageVisualizer(
                          tag: "Locandina",
                          imageData: widget.evento.locandina!.imageData,
                        ))
                    : const Text("Nessuna Locandina",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: AppColors.logoCadmiumOrange,
                        )),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                            padding: defaultPaddingElement,
                            child: CustomButton(
                              onPressed: () => isContactDisable
                                  ? null
                                  : _makePhoneCall(
                                      widget.evento.contatto!.telefono!),
                              textButton: 'Telefona',
                              bgColor: isContactDisable
                                  ? Colors.grey
                                  : AppColors.logoBlue,
                              icon: Icons.phone,
                            ))),
                    Expanded(
                        child: Padding(
                            padding: defaultPaddingElement,
                            child: CustomButton(
                              textButton: "E-mail",
                              onPressed: () => isEmailDisable
                                  ? null
                                  : _sendEmail(
                                      widget.evento.contatto!.email!,
                                      "Informazioni su ${widget.evento.nome}",
                                      "Salve, la contatto in merito..."),
                              icon: Icons.email,
                              bgColor: isEmailDisable
                                  ? Colors.grey
                                  : AppColors.logoBlue,
                            )))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }
}
