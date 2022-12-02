import 'package:flutter/material.dart';
import 'package:frontend_sws/components/CustomButton.dart';
import 'package:getwidget/getwidget.dart';
import '../theme/theme.dart';
import 'Chips.dart';
import '../screens/InfoServizio.dart';

class CardServizio extends StatelessWidget {
  final String title, ente, area;
  final String? descrizione, posizione, data;
  //final Widget toShow;
  const CardServizio(
      {Key? key,
      required this.title,
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
          MaterialPageRoute(builder: (context) => const InfoScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 180.0,
        width: 290.0,
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
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 22.0, top: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nome Servizio 1",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      "Nome Ente 1",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Divider(),
                    SizedBox(
                      height: 6,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(
                          Icons.tag_sharp,
                          color: AppColors.logoCadmiumOrange,
                        ),
                        Text(
                          'Persone Anziane',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.logoCadmiumOrange,
                        ),
                        Text(
                          'Via Massimo Giletti',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          color: AppColors.logoCadmiumOrange,
                        ),
                        Text(
                          'Tutti i giovedi',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.scaleDown,
                    image: AssetImage(
                      "assets/images/event_item.png",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
