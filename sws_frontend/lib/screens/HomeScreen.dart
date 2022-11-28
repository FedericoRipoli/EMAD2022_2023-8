import 'package:flutter/material.dart';
import 'package:frontend_sws/components/CardEvento.dart';
import 'package:frontend_sws/components/CardListAmbiti.dart';
import 'package:frontend_sws/main.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:getwidget/getwidget.dart';
// screens
import 'package:frontend_sws/screens/Chat.dart';
import 'InfoApp.dart';
//components
import 'package:frontend_sws/components/Clipper08.dart';
import 'package:frontend_sws/components/CardList.dart';
import 'package:frontend_sws/components/LoginForm.dart';
import 'package:frontend_sws/services/UserService.dart';
import '../components/CardServizio.dart';
import '../components/menu/DrawerMenu.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.Home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.white,
      endDrawerEnableOpenDragGesture: false,
      drawer: userService.isLogged() ? DrawerMenu(currentPage: Home.id) : null,
      resizeToAvoidBottomInset: false,
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          elevation: 8,
          hoverElevation: 3,
          onPressed: () {
            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatPage()),
              );
            }
          },
          backgroundColor: appTheme.primaryColor,
          child: const ImageIcon(
            AssetImage("assets/images/chatbot.png"),
            size: 38,
          ),
        ),
      ),
      appBar: GFAppBar(
        title: const Text(
          "Salerno Amica",
          style: TextStyle(color: AppColors.ice, fontFamily: 'FredokaOne'),
        ),
        centerTitle: true,
        leading: userService.isLogged()
            ? GFIconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                type: GFButtonType.transparent,
              )
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
                        content: LoginForm(userService: userService),
                      );
                    },
                  ).then((value) => setState(() => {}));
                },
                type: GFButtonType.transparent,
              ),
        searchBar: false,
        elevation: 0,
        backgroundColor: appTheme.primaryColor,
        actions: <Widget>[
          GFIconButton(
            icon: const Icon(
              Icons.info_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InfoApp()),
              );
            },
            type: GFButtonType.transparent,
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipPath(
                  clipper: Clipper08(),
                  child: Container(
                    height: 190, //400
                    color: appTheme.primaryColor,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Image.asset(
                            "assets/images/logo.png",
                            width: 120,
                            height: 120,
                          ),
                        ),
                        //const SizedBox(height: 2),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const CardListAmbiti(),
            CardList(
              itemLabel: "Servizi",
              itemList: listServices,
            ),
            CardList(itemList: listEventi, itemLabel: "Eventi"),
          ],
        ),
      ),
    );
  }
}

List<CardServizio> listServices = [
  const CardServizio(
      title: 'Mensa per senzadimora',
      subtitle: 'Ente No Profit',
      ambito: 'Mensa',
      tipologia: 'Senadimora',
      tags: 'mensa'),
  const CardServizio(
      title: 'Trasporto Anziani',
      subtitle: 'Ente Anziani',
      ambito: 'Trasporto',
      tipologia: 'Anziani',
      tags: 'trasporto'),
  const CardServizio(
      title: 'Trasporto Disabili',
      subtitle: 'Ente Arca',
      ambito: 'Trasporto',
      tipologia: 'Disabilità',
      tags: 'trasporto'),
];

List<CardEvento> listEventi = [
  const CardEvento(),
  const CardEvento(),
  const CardEvento(),
];
