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
        //padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        //height: MediaQuery.of(context).size.height * 0.3,
        //width: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: const [
              BoxShadow(
                color: AppColors.white,
                spreadRadius: 0,
                blurRadius: 1.5,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10,right: 10, top: 5, bottom: 5),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0)
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.logoBlue.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child:Text(
                overflow: TextOverflow.ellipsis,
                nomeServizio,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ) ,
            ),
            Container(
              padding: EdgeInsets.only(left: 10,right: 10, top: 5, bottom: 5),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: AppColors.logoBlue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.logoBlue.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.home_filled,
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
                          )
                      ),
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
                            style: const TextStyle(fontSize: 16),
                          )
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: AppColors.logoCadmiumOrange,
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            '$posizione',
                            style: const TextStyle(fontSize: 16),
                          )
                      ),
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
