import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../services/entity/Area.dart';
import '../../theme/theme.dart';
import '../../screens/InfoServizio.dart';
import 'package:frontend_sws/components/generali/Chips.dart';

class CardServizio extends StatelessWidget {
  final String nomeServizio, ente, idServizio;
  final List<Area> aree;
  final String? descrizione, posizione, data;

  //final Widget toShow;
  const CardServizio(
      {Key? key,
      required this.idServizio,
      required this.nomeServizio,
      required this.ente,
      required this.aree,
      this.descrizione,
      this.posizione,
      this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InfoServizio(idServizio)),
        );
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(16),
        color: AppColors.greyLight,
        child: Column(
          children: [ListTile(), ListTile()],
        ),
      ),
    );
  }
}
