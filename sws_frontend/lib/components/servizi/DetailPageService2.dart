import 'package:flutter/material.dart';
import 'package:frontend_sws/services/entity/Servizio.dart';
import 'package:frontend_sws/theme/theme.dart';

class DetailPageService2 extends StatefulWidget {
  Servizio servizio;
  DetailPageService2({Key? key,required this.servizio}){}
  @override
  _DetailPageService2State createState() => _DetailPageService2State();
}

class _DetailPageService2State extends State<DetailPageService2>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height*0.25,
                  child: AspectRatio(
                  aspectRatio: 3/1.3,
                  child: Image.asset(
                    "assets/images/listtile_ente.png",
                    fit: BoxFit.cover,),
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height*0.24,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey,
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                    ],
                  ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Container(
                    margin: EdgeInsets.only(top:15),
                    color: AppColors.white,
                      constraints: BoxConstraints(
                          minHeight: infoHeight,
                          maxHeight: tempHeight > infoHeight
                              ? tempHeight
                              : infoHeight),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0.0, left: 18, right: 16),
                        child: Text(
                          widget.servizio.nome,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            letterSpacing: 0.10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 0, top: 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              (widget.servizio.aree != null || widget.servizio.aree!.isNotEmpty)?
                              widget.servizio.aree!.map((e) => e.nome).join(", ")
                                  :"area di riferimento non disponinile",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 20,
                                letterSpacing: 0,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              widget.servizio.struttura?.denominazione != null?
                              widget.servizio.struttura!.denominazione!
                              :"struttura non disponinile",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 18,
                                letterSpacing: 0.27,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              widget.servizio.struttura?.posizione?.indirizzo != null?
                              widget.servizio.struttura!.posizione!.indirizzo!
                              : "" ,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 16,
                                letterSpacing: 0.57,
                                color: Colors.blue,
                              ),
                            )
                          ],
                        ),
                    ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity1,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          getTimeBoxUI('Visualizza sulla mappa', 'Geolocalizza'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: opacity2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 1, bottom: 8),
                        child: SingleChildScrollView(

                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 211, 211, 211),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(7),
                            child: Text(
                              'Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry.'
                              +"Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry."
                              +"Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry."
                              +"Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry."
                              +"Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry."
                              +"Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                letterSpacing: 0,
                                color: Colors.black,
                                ),
                                //maxLines: 4,
                                //overflow: TextOverflow.ellipsis,
                              ),
                          )
                        ),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                  opacity: opacity3,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16, bottom: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.blue
                                        .withOpacity(0.5),
                                    offset: const Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                            ),
                            child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Contatta',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        letterSpacing: 0.0,
                                        color: Colors.white,
                                      )
                                    ),
                                    Icon(
                                      Icons.phone,
                                      color: Colors.white,)
                                  ],
                                )
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                )
                ],
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

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.ice,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.blue.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 9.0, right: 9.0, top: 4.0, bottom: 4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: Colors.blue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}