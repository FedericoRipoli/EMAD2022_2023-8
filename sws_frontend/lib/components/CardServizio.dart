import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'Chips.dart';
import '../screens/InfoServizio.dart';

class CardServizio extends StatelessWidget {
  final String title, subtitle, ambito, tipologia, tags;
  final String? descrizione, contenuto;
  final Stato? state;
  //final Widget toShow;
  const CardServizio(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.ambito,
      required this.tipologia,
      required this.tags,
      this.descrizione,
      this.contenuto,
      this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InfoServizio()),
          );
        },
        child: SizedBox(
          width: 330,
          height: 240,
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
            margin: const EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(
                  width: 335,
                  height: 110,
                  child: Image.asset(
                    "assets/images/card_servizio_bg.jpg",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        ChipGenerale(label: "Mensa", icon: Icons.type_specimen),
                        ChipGenerale(
                            label: "Ristoro",
                            icon: Icons.manage_search_outlined),
                        ChipGenerale(
                            label: "In Loco", icon: Icons.location_off_sharp)
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          //margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(6),
                          alignment: Alignment.center,
                          child: const Text(
                            'Mensa per senzadimora',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const InfoServizio()),
                            );
                          },
                          icon: Icon(Icons.info_outlined),
                          color: AppColors.logoBlue,
                        )
                      ]),
                ])
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
