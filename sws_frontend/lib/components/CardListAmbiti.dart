import 'package:flutter/material.dart';
import 'package:frontend_sws/main.dart';

class CardListAmbiti extends StatelessWidget {
  const CardListAmbiti({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> itemList = [
      ChipAmbito(label: "Trasporto", icon: Icons.emoji_transportation),
      ChipAmbito(label: "Mensa", icon: Icons.food_bank),
      ChipAmbito(label: "Assistenza", icon: Icons.help_center),
      ChipAmbito(label: "Giovani", icon: Icons.join_full)
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
                padding: const EdgeInsets.only(left: 10),
                child: const Text(
                  "Visualizza per Ambito",
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
          //height: height! * .25 < 170 ? height! * .25 : 170,
          //height: height! * .25 < 300 ? height! * .25 : 300,
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
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
              color: Colors.black, offset: Offset(0.0, 1.0), blurRadius: 1.0),
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
          Text(label)
        ],
      ),
    );
  }
}
