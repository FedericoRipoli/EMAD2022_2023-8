import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:frontend_sws/components/generali/AddDefCard.dart';
import 'package:frontend_sws/components/generali/CustomFloatingButton.dart';
import 'package:frontend_sws/screens/AddDefibrillatoreForm.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import '../components/generali/LoginForm.dart';
import '../components/generali/TopicCard.dart';
import '../components/menu/DrawerMenu.dart';
import '../services/UserService.dart';
import 'Chat.dart';
import 'InfoScreen.dart';
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
                Icons.account_circle_sharp,
                color: Colors.white,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
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
        GFIconButton(
            color: Colors.transparent,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InfoScreen()),
              );
            },
            icon: const Icon(
              Icons.info_outline_rounded,
              color: AppColors.white,
            )),
      ],
      floatingActionButton: CustomFloatingButton(
        iconData: Icons.headset_mic,
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
      headerExpandedHeight: 0.26,
      body: [
        const Text(
          "Esplora le funzionalità",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const Icon(Icons.keyboard_double_arrow_up_rounded),
        GridView.count(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          children: [
            TopicCard(
              title: "Servizi",
              icon: Icons.handshake,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ServiziScreen()),
                );
              },
            ),
            TopicCard(
              title: "Eventi",
              icon: Icons.event_available,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventiScreen()),
                );
              },
            ),
            TopicCard(
              title: "Olivia",
              icon: Icons.live_help_rounded,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatPage()),
                );
              },
            ),
            TopicCard(
              title: "Defibrillatori",
              icon: Icons.monitor_heart,
              onTap: () {},
            ),
          ],
        ),
        const AddDefCard(),
      ],
      fullyStretchable: false,
      backgroundColor: AppColors.bgWhite,
      appBarColor: AppColors.logoBlue,
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      color: AppColors.logoBlue,
      child: Center(
          child: Container(
              margin: const EdgeInsets.only(top: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const HomeTitle(),
                  Image.asset(
                    "assets/images/logo.png",
                    width: 82,
                  ),
                ],
              ))),
    );
  }
}
