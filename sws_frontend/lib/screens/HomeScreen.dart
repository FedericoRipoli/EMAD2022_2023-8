import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_sws/main.dart';
import 'package:getwidget/getwidget.dart';

// entity
import '../entity/Servizio.dart';
import '../entity/Evento.dart';

// screens
import 'package:frontend_sws/screens/Chat.dart';

//components
import 'package:frontend_sws/components/Clipper08.dart';
import 'package:frontend_sws/components/CardList.dart';
import 'package:frontend_sws/components/LoginForm.dart';
import 'package:frontend_sws/services/UserService.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _HomeState extends State<Home> {
  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
      key: _scaffoldKey,
      endDrawerEnableOpenDragGesture: false,
      drawer: GFDrawer(
        elevation: 1,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            GFDrawerHeader(
              currentAccountPicture: const GFAvatar(
                radius: 80.0,
                backgroundImage: NetworkImage(
                    "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg"),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('user name'),
                  Text(userService.getName()??""),
                ],
              ),
            ),
            const ListTile(
              title: Text('Item 1'),
              onTap: null,
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                userService.logout();
                setState(() {});
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        hoverElevation: 0,
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
          size: 28,
        ),
      ),
      appBar: GFAppBar(
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
            onPressed: () {},
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
                    height: 360, //400
                    color: appTheme.primaryColor,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Image.asset(
                            "assets/images/logo.png",
                            width: 150,
                            height: 150,
                          ),
                        ),
                        const Text(
                          'Bentornatə in\nSalerno Amica!👋',
                          style: TextStyle(
                            fontSize: 28.0,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 2),
                      ],
                    ),
                  ),
                )
              ],
            ),
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

List<Servizio> listServices = [
  const Servizio(
    id: "00001",
    nome: "Mensa",
    contenuto: "Servizio mensa per i senzadimora",
    visibile: true,
    tags: "senzadimora",
  ),
  const Servizio(
    id: "00002",
    nome: "Trasporto Anziani",
    contenuto: "Servizio di trasporto per gli anziani",
    visibile: true,
    tags: "anziani",
  ),
];

List<Evento> listEventi = [
  const Evento(
    id: "0001",
    nome: "Luci di Natale",
    contenuto: "",
    tags: "Attrazione",
  ),
  const Evento(
    id: "0002",
    nome: "Coloriamo Salerno",
    contenuto: "",
    tags: "NoProfit",
  ),
  const Evento(
    id: "0003",
    nome: "Salviamo il parco",
    contenuto: "",
    tags: "NoProfit",
  ),
];
