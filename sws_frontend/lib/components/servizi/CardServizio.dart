import 'package:flutter/material.dart';
import 'package:frontend_sws/admin_screens/servizi/GestioneServizio.dart';
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
        padding: const EdgeInsets.only(left:20, right: 20, top: 20),
        margin: const EdgeInsets.only(left:20, right: 20, top: 20),
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: const [
              BoxShadow(
                color: AppColors.logoBlue,
                spreadRadius: 0,
                blurRadius: 1.5,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ]),
        child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      nomeServizio,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Divider(),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      ente,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Icon(
                          Icons.tag_sharp,
                          color: AppColors.logoCadmiumOrange,
                        ),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          area,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.logoCadmiumOrange,
                        ),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          '$posizione',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        );

  }
}
