import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../../screens/InfoServizio.dart';

class CardServizio extends StatelessWidget {
  final String nomeServizio, ente, area, idServizio;
  final String? descrizione, posizione, data;
  //final Widget toShow;
  const CardServizio(
      {Key? key,
      required this.idServizio,
      required this.nomeServizio,
      required this.ente,
      required this.area,
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
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18.0),
            boxShadow: const [
              BoxShadow(
                color: AppColors.logoBlue,
                spreadRadius: 0,
                blurRadius: 1.8,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ]),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              width: double.maxFinite,
              child: Text(
                overflow: TextOverflow.ellipsis,
                nomeServizio,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.logoBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.home_outlined,
                        color: AppColors.logoCadmiumOrange,
                      ),
                      Flexible(
                          child: Text(
                        overflow: TextOverflow.ellipsis,
                        ente,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.start,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.tag_sharp,
                        color: AppColors.logoCadmiumOrange,
                      ),
                      Flexible(
                          child: Text(
                        overflow: TextOverflow.ellipsis,
                        area,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: AppColors.logoCadmiumOrange,
                      ),
                      Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            '$posizione',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
