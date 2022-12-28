import 'package:flutter/material.dart';
import '../../screens/eventi/InfoEvento.dart';
import '../../services/entity/Area.dart';
import '../../theme/theme.dart';
import '../../util/ManageDate.dart';

class CardEvento extends StatelessWidget {
  final String luogo, nomeEvento, idEvento;
  final String? contenuto, imgPath, telefono, email;
  final List<String>? tags;
  final List<Area>? aree;
  final String? dataInizio, dataFine;

  const CardEvento({
    Key? key,
    required this.luogo,
    required this.nomeEvento,
    required this.idEvento,
    this.contenuto,
    this.dataInizio,
    this.dataFine,
    this.imgPath,
    this.telefono,
    this.email,
    this.aree,
    this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InfoEvento(
                      idEvento: idEvento,
                    )),
          );
        },
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: AppColors.white,
            elevation: 8,
            margin:
                const EdgeInsets.only(left: 12, right: 12, bottom: 10, top: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ListTile(
                          minVerticalPadding: 6,
                          title: Text(
                            nomeEvento,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.event_available,
                            color: AppColors.logoCadmiumOrange,
                            size: 28,
                          ),
                          subtitle: Text(
                            contenuto ?? "",
                            style: const TextStyle(
                                color: AppColors.black, fontSize: 16),
                          ),
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        ListTile(
                          minVerticalPadding: 6,
                          title: Text(
                            "DA ${ManageDate.formatDate(DateTime.parse(dataInizio!), context)}"
                            "\nA ${ManageDate.formatDate(DateTime.parse(dataFine!), context)}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.calendar_month,
                            color: AppColors.logoCadmiumOrange,
                            size: 28,
                          ),
                          subtitle: Text(
                            luogo,
                            style: const TextStyle(
                                color: AppColors.black, fontSize: 16),
                          ),
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        ListTile(
                          minVerticalPadding: 6,
                          title: Text(
                            telefono ?? "Nessun contatto",
                            style: const TextStyle(
                              color: AppColors.logoBlue,
                              fontSize: 16.0,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.contact_mail,
                            color: AppColors.logoCadmiumOrange,
                            size: 28,
                          ),
                          subtitle: Text(
                            email ?? "Nessuna email",
                            style: const TextStyle(
                                color: AppColors.logoBlue, fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Container(
                          margin:
                              const EdgeInsets.only(bottom: 8, left: 8, top: 6),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: aree!.map((e) {
                              return Container(
                                  margin: const EdgeInsets.all(3),
                                  child: Chip(
                                    backgroundColor: AppColors.bgWhite,
                                    label: Text(
                                      e.nome,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    elevation: 4,
                                    avatar: const Icon(Icons.accessibility,
                                        color: AppColors.logoBlue),
                                  ));
                            }).toList(),
                          ),
                        )
                      ]),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      child: Image.asset(
                    "images/img_placeholder.jpg",
                    fit: BoxFit.fitHeight,
                  )),
                ),
              ],
            )));
  }
}

/**/
