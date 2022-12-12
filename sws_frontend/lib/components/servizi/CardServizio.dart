import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import '../../services/entity/Area.dart';
import '../../theme/theme.dart';
import '../../screens/InfoServizio.dart';
import 'package:frontend_sws/components/generali/Chips.dart';
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
        color: AppColors.ice,
        elevation: 4,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              minVerticalPadding: 6,
              title: Text(
                nomeServizio,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              trailing: const Icon(
                Icons.handshake_rounded,
                color: AppColors.logoCadmiumOrange,
                size: 32,
              ),
              subtitle: Text(
                ente,
                style: const TextStyle(
                    color: AppColors.logoBlue, fontWeight: FontWeight.w600),
              ),
              /* avatar: const Icon(
                Icons.home_work,
                color: AppColors.logoBlue,
              ),*/
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 4, left: 6),
              child: Column(
                children: aree.map((e) {
                  return Chip(
                      backgroundColor: AppColors.ice,
                      label: Text(
                        e.nome,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                      elevation: 4,
                      avatar: const Icon(
                        Icons.tag,
                        color: AppColors.black,
                      ));
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
