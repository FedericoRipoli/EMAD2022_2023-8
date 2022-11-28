import 'package:flutter/material.dart';
import 'package:frontend_sws/main.dart';

import '../theme/theme.dart';

class CardListAmbiti extends StatelessWidget {
  const CardListAmbiti({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> itemList = [
      const ChipAmbito(label: "Trasporto", icon: Icons.emoji_transportation),
      const ChipAmbito(label: "Mensa", icon: Icons.food_bank),
      const ChipAmbito(label: "Assistenza", icon: Icons.help_center),
      const ChipAmbito(label: "Giovani", icon: Icons.join_full)
    ];

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 8),
                child: const Text(
                  "Visualizza i Servizi per ambito",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    color: AppColors.black,
                  )),
            ],
          ),
        ),
        SizedBox(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 280, minHeight: 150),
            child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 3.0,
                mainAxisSpacing: 2.0,
                children: List.generate(itemList.length, (index) {
                  return Center(child: itemList[index]);
                })),
          ),
        )
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
    return Container(
      alignment: Alignment.center,
      width: 110,
      height: 110,
      padding: const EdgeInsets.all(2),
      //margin: const EdgeInsets.only(left: 12, right: 6, top: 3, bottom: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
              color: Colors.black, offset: Offset(0.8, 0.2), blurRadius: 2.0),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: appTheme.primaryColor,
            size: 48,
          ),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )
        ],
      ),
    );
  }
}
