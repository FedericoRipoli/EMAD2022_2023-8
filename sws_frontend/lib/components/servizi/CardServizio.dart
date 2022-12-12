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
      child: Container(
        height: 160,
        margin: const EdgeInsets.all(8),
        //padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(26.0),
            boxShadow: const [
              BoxShadow(
                color: AppColors.logoBlue,
                spreadRadius: 0,
                blurRadius: 0.9,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ]),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(left: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        nomeServizio,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                      ),
                      Wrap(
                        children: [
                          const Icon(
                            Icons.home_work,
                            color: AppColors.logoBlue,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            ente,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: AppColors.logoBlue,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: aree.map((e) {
                          return Wrap(
                            children: [
                              const Icon(
                                Icons.tag,
                                color: AppColors.logoBlue,
                              ),
                              Text(
                                e.nome,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  color: AppColors.logoBlue,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
