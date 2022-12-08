import 'package:flutter/material.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:frontend_sws/components/generali/CustomFloatingButton.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import '../components/generali/LoginForm.dart';
import '../components/generali/TopicCard.dart';
import '../components/menu/DrawerMenu.dart';
import '../services/UserService.dart';
import 'Chat.dart';
import 'eventi/EventiScreen.dart';
import 'servizi/ServiziScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.Home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      key: _scaffoldKey,
      drawer: userService.isLogged()
          ? DrawerMenu(currentPage: HomeScreen.id)
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
        iconData: Icons.assistant,
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
        TopicCard(
          title: "Servizi Politiche Sociali & Giovanili",
          icon: Icons.handshake,
          bgColor: AppColors.white,
          btnColor: AppColors.white,
          image: "assets/images/card_service_bg.png",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ServiziScreen()),
            );
          },
        ),
        const SizedBox(
          height: 12,
        ),
        TopicCard(
          bgColor: AppColors.white,
          btnColor: AppColors.white,
          title: "Eventi nella zona di Salerno",
          icon: Icons.event_available,
          image: "assets/images/event_card_bg.png",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventiScreen()),
            );
          },
        ),
        const SizedBox(
          height: 12,
        ),
        TopicCard(
          bgColor: AppColors.white,
          btnColor: AppColors.white,
          title: "Hai bisogno di aiuto?",
          icon: Icons.live_help_rounded,
          image: "assets/images/intro_chatbot.png",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatPage()),
            );
          },
        ),
        const SizedBox(
          height: 12,
        ),
        TopicCard(
          bgColor: AppColors.white,
          btnColor: AppColors.white,
          title: "Cerca i defibrillatori vicino a te",
          icon: Icons.monitor_heart,
          image: "assets/images/help_card_bg.png",
          buttonLabel: "Contatta",
          onTap: () {},
        ),
        const SizedBox(
          height: 50,
        ),
      ],
      fullyStretchable: false,
      backgroundColor: AppColors.white,
      appBarColor: AppColors.logoBlue,
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      color: AppColors.logoBlue,
      child: Container(
          margin: EdgeInsets.only(top: 50, left: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  HomeTitle(
                    label: "Salerno",
                    color: AppColors.white,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  HomeTitle(
                    label: "Amica",
                    color: AppColors.logoCadmiumOrange,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Vivi la città di Salerno\nEsplora le possibilità...",
                    style: TextStyle(
                        color: AppColors.ice,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(right: 50, bottom: 80),
                child: Image.asset(
                  "images/logo.png",
                  width: 90,
                ),
              )
            ],
          )),
    );
  }
}

/*TopicCard(
          bgColor: AppColors.white,
          btnColor: AppColors.white,
          title: "Vuoi unirti a Salerno Amica?",
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
        const SizedBox(
          height: 12,
        ),*/
