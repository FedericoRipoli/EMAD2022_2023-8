import 'package:flutter/material.dart';
import 'package:frontend_sws/main.dart';

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
                  "Visualizza per ambito",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        SizedBox(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 100, minHeight: 50),
            child: ListView.builder(
                itemBuilder: (context, index) => itemList[index],
                shrinkWrap: true,
                padding: const EdgeInsets.all(1.0),
                itemCount: itemList.length,
                scrollDirection: Axis.horizontal),
          ),
        ),
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
      width: 100,
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.only(left: 12, right: 6, top: 3, bottom: 3),
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
            size: 36,
          ),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
