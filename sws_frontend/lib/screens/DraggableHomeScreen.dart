import 'package:flutter/material.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:frontend_sws/components/HomeActionCard.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';

import '../components/LoginForm.dart';
import '../components/menu/DrawerMenu.dart';
import '../services/UserService.dart';
import 'Chat.dart';

class DraggableHomeScreen extends StatefulWidget {
  const DraggableHomeScreen({Key? key}) : super(key: key);
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.Home';

  @override
  State<DraggableHomeScreen> createState() => _DraggableHomeScreenState();
}

class _DraggableHomeScreenState extends State<DraggableHomeScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserService userService = UserService();
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
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
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
    return DraggableHome(
      key: _scaffoldKey,
      drawer: userService.isLogged()
          ? DrawerMenu(currentPage: DraggableHomeScreen.id)
          : null,
      leading: userService.isLogged()
          ? null
          : GFIconButton(
              icon: const Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(34.0))),
                      content: LoginForm(userService: userService),
                    );
                  },
                ).then((value) => setState(() => {}));
              },
              type: GFButtonType.transparent,
            ),
      title: appName,
      centerTitle: true,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.info_outlined)),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatPage()),
            );
          }
        },
        elevation: 10,
        backgroundColor: AppColors.logoBlue,
        child: const ImageIcon(
          AssetImage("assets/images/chatbot.png"),
          size: 28,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      alwaysShowLeadingAndAction: true,
      headerWidget: headerWidget(context),
      curvedBodyRadius: 55,
      headerExpandedHeight: 0.36,
      body: [
        AnimatedOpacity(
          opacity: opacity1,
          duration: const Duration(milliseconds: 500),
          child: const HomeActionCard(
            titolo: 'Servizi ambito 5',
            descrizione:
                'Guarda tutti i servizi offerti dal Comune. Visualizza la mappa interattiva o filtrali tramite ricerca',
            buttonLabel: 'Servizi',
            icon: Icons.handshake,
            subtitolo: "Comune di Salerno",
          ),
        ),
        const SizedBox(
          height: 35,
        ),
        AnimatedOpacity(
          opacity: opacity1,
          duration: const Duration(milliseconds: 500),
          child: const HomeActionCard(
            titolo: 'Gli ultimi Eventi',
            descrizione:
                'Guarda tutti gli eventi organizzati. Visualizza la mappa interattiva o filtrali tramite ricerca',
            buttonLabel: 'Eventi',
            icon: Icons.event_available,
            subtitolo: "Comune di Salerno",
          ),
        ),
      ],
      fullyStretchable: true,
      expandedBody: const Center(child: Text("Info")),
      backgroundColor: AppColors.white,
      appBarColor: AppColors.logoBlue,
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      color: AppColors.logoBlue,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          appName,
          Container(
            margin: const EdgeInsets.all(4),
            child: Image.asset(
              "assets/images/logo.png",
              width: 130,
              height: 130,
            ),
          ),
        ],
      )),
    );
  }
}

Text appName = Text("Salerno Amica",
    style: TextStyle(
      fontFamily: "FredokaOne",
      fontSize: 26,
      letterSpacing: 2,
      color: Colors.grey[100],
    ));
