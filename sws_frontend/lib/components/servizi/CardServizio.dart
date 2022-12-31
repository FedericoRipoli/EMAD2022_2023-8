import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import '../../services/entity/Area.dart';
import '../../theme/theme.dart';
import '../../screens/servizi/InfoServizio.dart';
import 'package:frontend_sws/components/generali/ChipGenerale.dart';
import 'package:frontend_sws/components/generali/ChipGenerale.dart';

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
          MaterialPageRoute(builder: (context) => InfoServizio(idServizio: idServizio)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: AppColors.white,
        elevation: 8,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12, top: 10),
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
                  fontSize: 20.0,
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
                    color: AppColors.logoBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
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
              margin: const EdgeInsets.only(bottom: 8, left: 8, top: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: aree.map((e) {
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
          ],
        ),
      ),
    );
  }
}
