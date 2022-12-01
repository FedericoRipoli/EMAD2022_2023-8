import 'package:flutter/material.dart';
import 'package:frontend_sws/main.dart';

import '../theme/theme.dart';

class CardListAmbiti extends StatelessWidget {
  const CardListAmbiti({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> itemList = [
      const ChipAmbito(label: "Disabilità", icon: Icons.accessible),
      const ChipAmbito(label: "Immigrazione", icon: Icons.luggage),
      const ChipAmbito(label: "Minori", icon: Icons.child_care),
      const ChipAmbito(label: "Persone Anziane", icon: Icons.elderly),
      const ChipAmbito(label: "Asili Nido", icon: Icons.child_friendly),
      const ChipAmbito(
          label: "Contrasto alla povertà", icon: Icons.people_rounded),
      const ChipAmbito(
          label: "Integrazione Socio-Sanitaria", icon: Icons.social_distance),
    ];

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 6),
                child: const Text(
                  "Visualizza per Area di riferimento",
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return itemList[index];
              },
            )),
      ],
    );
  }
}

class ChipAmbito extends StatelessWidget {
  final String label;
  final IconData icon;
  const ChipAmbito({Key? key, required this.label, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        width: 104,
        height: 62,
        padding: const EdgeInsets.all(2),
        margin: const EdgeInsets.only(left: 10, bottom: 3, top: 3, right: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
                color: Colors.black, offset: Offset(0.1, 0.1), blurRadius: 0.4),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.logoBlue,
              size: 36,
            ),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
