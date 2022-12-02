import 'package:flutter/material.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:frontend_sws/components/CustomFloatingButton.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';

import '../components/LoginForm.dart';
import '../components/TopicCard.dart';
import '../components/menu/DrawerMenu.dart';
import '../services/UserService.dart';
import 'Chat.dart';
import 'SearchScreen.dart';

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
      title: const AppTitle(
        label: "Salerno Amica",
      ),
      centerTitle: true,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.info_outlined)),
      ],
      floatingActionButton: CustomFloatingButton(
        iconData: Icons.live_help_rounded,
        onPressed: () {
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatPage()),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      alwaysShowLeadingAndAction: true,
      headerWidget: headerWidget(context),
      curvedBodyRadius: 20,
      headerExpandedHeight: 0.28,
      body: [
        AnimatedOpacity(
          opacity: opacity1,
          duration: const Duration(milliseconds: 500),
          child: TopicCard(
            title: "Servizi Politiche Sociali & Giovanili",
            subtitle: "Visualizza come mappa o come lista",
            icon: Icons.handshake,
            image: "assets/images/card_service_bg.png",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchScreen(typeSearch: true)),
              );
            },
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        AnimatedOpacity(
          opacity: opacity1,
          duration: const Duration(milliseconds: 500),
          child: TopicCard(
            title: "Eventi nella zona di Salerno",
            subtitle: "Visualizza come mappa o come lista",
            icon: Icons.event_available,
            image: "assets/images/event_card_bg.png",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchScreen(typeSearch: false)),
              );
            },
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        AnimatedOpacity(
          opacity: opacity1,
          duration: const Duration(milliseconds: 500),
          child: TopicCard(
            title: "Vuoi unirti a Salerno Amica?",
            subtitle: "Sei un ente e vuoi offrire i tuoi servizi? Contattaci",
            icon: Icons.question_answer,
            image: "assets/images/help_card_bg.png",
            buttonLabel: "Contatta",
            onTap: () async {
              String email = Uri.encodeComponent("mail@fluttercampus.com");
              String subject = Uri.encodeComponent("Hello Flutter");
              String body = Uri.encodeComponent("Hi! I'm Flutter Developer");
              print(subject); //output: Hello%20Flutter
              Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
              if (await launchUrl(mail)) {
                print("mail opened");
              } else {
                print("mail not opened");
              }
            },
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        AnimatedOpacity(
          opacity: opacity1,
          duration: const Duration(milliseconds: 500),
          child: TopicCard(
            title: "Hai bisogno di aiuto?",
            subtitle:"Interagisci con Olivia sia via testo sia messaggi vocali",
            icon: Icons.live_help_rounded,
            image: "assets/images/intro_chatbot.png",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatPage()),
              );
            },
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
      fullyStretchable: true,
      expandedBody: infoSection(context),
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
          const AppTitle(label: "Salerno Amica"),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Image.asset(
              "assets/images/logo.png",
              width: 118,
              height: 118,
            ),
          ),
        ],
      )),
    );
  }

  Widget infoSection(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.all(8),
      child: Stack(
        children: <Widget>[
          ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                  height: 620,
                  color: AppColors.logoBlue,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Ci stiamo ancora lavorando",
                        style: TextStyle(color: AppColors.white, fontSize: 20),
                      ),
                      Image.asset(
                        'assets/images/monkey-developer.gif',
                        width: 320,
                        height: 320,
                      ),
                    ],
                  )))),
        ],
      ),
    );
  }
}
