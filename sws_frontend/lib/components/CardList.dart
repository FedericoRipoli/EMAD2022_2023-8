import 'package:flutter/material.dart';

import '../theme/theme.dart';

class CardList extends StatelessWidget {
  // lista di elementi da mostrare
  final List<Widget> itemList;
  final String itemLabel;
  const CardList({Key? key, required this.itemList, required this.itemLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: Text(
                  "Visualizza $itemLabel più recenti",
                  style: const TextStyle(
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
          //height: height! * .25 < 170 ? height! * .25 : 170,
          //height: height! * .25 < 300 ? height! * .25 : 300,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 260, minHeight: 120),
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
