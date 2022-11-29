import 'package:flutter/material.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import '../screens/InfoEvento.dart';
import '../theme/theme.dart';
import 'Chips.dart';
import 'package:frontend_sws/components/Button.dart';

class CardEvento extends StatelessWidget {
  const CardEvento({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InfoEvento()),
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
            elevation: 8,
            margin: const EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(
                  width: 330,
                  height: 110,
                  child: Image.asset(
                    "assets/images/event_default.png",
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
                        ChipGenerale(
                            label: "25 Novembre", icon: Icons.access_time),
                        ChipGenerale(label: "Salerno", icon: Icons.location_on)
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          //margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(6),
                          alignment: Alignment.center,
                          child: const Text(
                            'Evento per i giovani',
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
                                  builder: (context) => const InfoEvento()),
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
