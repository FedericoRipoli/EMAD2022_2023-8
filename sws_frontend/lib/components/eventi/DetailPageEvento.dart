import 'package:flutter/material.dart';
import 'package:frontend_sws/components/generali/CustomButton.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/entity/Evento.dart';

class DetailPageEvento extends StatefulWidget {
  Evento evento;

  DetailPageEvento({super.key, required this.evento});

  @override
  _DetailPageEventoState createState() => _DetailPageEventoState();
}

class _DetailPageEventoState extends State<DetailPageEvento> {
  final double infoHeight = 364.0;
  bool isContactDisable = true;
  bool isEmailDisable = true;

  @override
  Widget build(BuildContext context) {
    EdgeInsets defaultPaddingElement = const EdgeInsets.fromLTRB(30, 0, 30, 0);
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                pinned: true,
                floating: false,
                centerTitle: true,
                title: Container(
                  width: MediaQuery.of(context).size.width,
                  //color: const Color.fromARGB(50, 255, 255, 255),
                  child: Text(
                    widget.evento.nome,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColors.black,
                    ),
                  ),
                ),
                automaticallyImplyLeading: false,
                expandedHeight: MediaQuery.of(context).size.height * 0.16,
                flexibleSpace: Container(
                  color: Colors.black,
                  padding: const EdgeInsets.only(
                      top: 0, left: 0, right: 0, bottom: 0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        topLeft: Radius.circular(0)),
                    child:
                        Image.asset("assets/images/bg.jpg", fit: BoxFit.cover),
                  ),
                )),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 5),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 16, right: 16, bottom: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(children: [
                                  const Icon(
                                    Icons.accessibility,
                                    color: AppColors.logoCadmiumOrange,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    (widget.evento.aree != null ||
                                            widget.evento.aree!.isNotEmpty)
                                        ? widget.evento.aree!
                                            .map((e) => e.nome)
                                            .join(", ")
                                        : "Nessuna area di riferimento",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ]),
                              ],
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Padding(
                                    padding: defaultPaddingElement,
                                    child: CustomButton(
                                      onPressed: () => isContactDisable
                                          ? null
                                          : () async {
                                              String number = widget
                                                  .evento.contatto!.telefono!;
                                              Uri tel =
                                                  Uri.parse("tel:$number");
                                              await launchUrl(tel);
                                            },
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
                                          : () async {
                                              String email =
                                                  Uri.encodeComponent(widget
                                                      .evento.contatto!.email!);
                                              String subject = Uri.encodeComponent(
                                                  "Informazioni su ${widget.evento.nome}");
                                              String body = Uri.encodeComponent(
                                                  "Salve, la contatto in merito...");
                                              Uri mail = Uri.parse(
                                                  "mailto:$email?subject=$subject&body=$body");
                                              await launchUrl(mail);
                                            },
                                      icon: Icons.email,
                                      bgColor: isEmailDisable
                                          ? Colors.grey
                                          : AppColors.logoBlue,
                                    )))
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Informazioni sul servizio",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: 0.57,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: defaultPaddingElement,
                          child: Text(
                            (widget.evento.contenuto != null)
                                ? widget.evento.contenuto!
                                : "Nessuna descrizione",
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              letterSpacing: 0,
                              color: Colors.black,
                            ),
                            //maxLines: 4,
                            //overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                },
                childCount: 1, // 1000 list items
              ),
            ),
          ],
        ));
  }
}
