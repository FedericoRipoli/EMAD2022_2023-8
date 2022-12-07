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
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 6), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10,right: 10, top: 5, bottom: 5),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    // Where the linear gradient begins and ends
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    // Add one stop for each color. Stops should increase from 0 to 1
                    stops: [0.2, 0.4, 0.6, 0.8],
                    colors: [
                      // Colors are easy thanks to Flutter's Colors class.
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 233, 246, 254),
                      Color.fromARGB(255, 214, 238, 253),
                      Color.fromARGB(255, 158, 214, 251),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)
                  ),
                  /*
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(6, 0), // changes position of shadow
                  ),
                ],

                 */
                ),
                child:Text(
                  overflow: TextOverflow.ellipsis,
                  nomeServizio,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 18.0,
                      fontFamily: "FredokaOne"
                  ),
                ) ,
              ),
              Container(
                padding: EdgeInsets.only(left: 10,right: 10, top: 5, bottom: 5),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    // Where the linear gradient begins and ends
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    // Add one stop for each color. Stops should increase from 0 to 1
                    stops: [0.1, 0.5, 0.7, 0.9],
                    colors: [
                      // Colors are easy thanks to Flutter's Colors class.
                      Color.fromARGB(255, 158, 214, 251),
                      Color.fromARGB(255, 139, 206, 250),
                      Color.fromARGB(255, 120, 198, 249),
                      Color.fromARGB(255, 102, 190, 248),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)
                  ),
                  /*
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 6), // changes position of shadow
                  ),
                ],

                 */
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.home_outlined,
                          color: AppColors.white,
                        ),
                        Flexible(
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              ente,
                              style: const TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
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
                          color: AppColors.white,
                        ),
                        Flexible(
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              area,
                              style: const TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
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
                          Icons.location_on_outlined,
                          color: AppColors.white,
                        ),
                        Flexible(
                            fit: FlexFit.loose,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              '$posizione',
                              style: const TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
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
      ),
    );
  }
}
