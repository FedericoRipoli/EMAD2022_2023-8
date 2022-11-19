import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_sws/main.dart';
import 'package:frontend_sws/screens/Home.dart';
import '../entity/Evento.dart';
import 'Servizi.dart';
import 'Events.dart';
import 'Chatbot.dart';
import 'package:flutter/foundation.dart';
import '../entity/Servizio.dart';
import 'package:getwidget/getwidget.dart';

int sel = 1;
double? width;
double? height;
final screens = [
  const Servizi(),
  const HomeScreen(),
  const Events(),
];

// Barra di navigazione
class BottomNav2 extends StatefulWidget {
  const BottomNav2({Key? key}) : super(key: key);

  @override
  State<BottomNav2> createState() => _BottomNavState2();
}

class _BottomNavState2 extends State<BottomNav2> {
  List<BottomNavigationBarItem> createItems() {
    List<BottomNavigationBarItem> items = [];
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.location_history,
          color: appTheme.primaryColor,
        ),
        icon: const Icon(
          Icons.location_history,
          color: Colors.black,
        ),
        label: "Servizi"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.home_filled,
          color: appTheme.primaryColor,
        ),
        icon: const Icon(
          Icons.home_filled,
          color: Colors.black,
        ),
        label: "HomePage"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.event,
          color: appTheme.primaryColor,
        ),
        icon: const Icon(
          Icons.event,
          color: Colors.black,
        ),
        label: "Eventi"));
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: screens.elementAt(sel),
        bottomNavigationBar: BottomNavigationBar(
          items: createItems(),
          unselectedItemColor: Colors.black,
          selectedItemColor: appTheme.primaryColor,
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          currentIndex: sel,
          elevation: 1.5,
          onTap: (int index) {
            if (index != sel) {
              setState(() {
                sel = index;
              });
            }
          },
        ));
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() => _HomeScreenAdmin();
}
class _HomeScreenUnlogged extends State<HomeScreen>{

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appTheme.primaryColor,
        elevation: 30,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: Clipper08(),
              child: Container(
                height: height! * .65 < 360 ? height! * .65 : 380, //400
                //color: Colors.tealAccent,
                decoration: BoxDecoration(
                    gradient: RadialGradient(colors: [
                      appTheme.secondaryHeaderColor,
                      appTheme.primaryColor
                    ])),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: height! / 16,
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

                  ],
                ),
              ),
            ),
            HomeDown(
                itemList: listServices,
                itemLabel: "Servizi"),
            HomeDown(
                itemList: listEventi,
                itemLabel: "Eventi")

          ],
        ),
      ),
      drawer: GFDrawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            GFDrawerHeader(
              currentAccountPicture: GFAvatar(
                radius: 70.0,
                backgroundImage: NetworkImage(""),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text('',style: TextStyle(color: Colors.white))                   ,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.login_rounded),
              title: Text('Login'),
              onTap: () => {
                showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    content: LoginForm(),
                  );
                },
                )
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
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const ChatBot();
          }));
        },
        backgroundColor: appTheme.primaryColor,
        child: const ImageIcon(
          AssetImage("assets/images/chatbot.png"),
          size: 28,
        ),
      ),
    );
  }
}

class _HomeScreenAdmin extends State<HomeScreen>{

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appTheme.primaryColor,
        elevation: 30,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: Clipper08(),
              child: Container(
                height: height! * .65 < 360 ? height! * .65 : 380, //400
                //color: Colors.tealAccent,
                decoration: BoxDecoration(
                    gradient: RadialGradient(colors: [
                      appTheme.secondaryHeaderColor,
                      appTheme.primaryColor
                    ])),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: height! / 16,
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

                  ],
                ),
              ),
            ),
            HomeDown(
                itemList: listServices,
                itemLabel: "Servizi"),
            HomeDown(
                itemList: listEventi,
                itemLabel: "Eventi")

          ],
        ),
      ),
      drawer: GFDrawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            GFDrawerHeader(
              currentAccountPicture: GFAvatar(
                radius: 70.0,
                backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg"),
              ),
              otherAccountsPictures: <Widget>[
                GFAvatar(
                  child: Text("UA"),
                )
              ],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text('Username Admin',style: TextStyle(color: Colors.white))                   ,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.add_chart),
              title: Text('Gestione Servizi'),
              onTap: null,
            ),
            ListTile(
              leading: Icon(Icons.event_rounded),
              title: Text('Gestione Eventi'),
              onTap: null,
            ),
            ListTile(
              leading: Icon(Icons.business_sharp),
              title: Text('Gestione Enti'),
              onTap: null,
            ),
            ListTile(
              leading: Icon(Icons.verified_outlined),
              title: Text('Approvazioni'),
              onTap: null,
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Aggiungi Responsabile'),
              onTap: null,
            ),
            ListTile(
              leading: Icon(Icons.logout_rounded),
              title: Text('Logout'),
              onTap: null,
            )
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        hoverElevation: 0,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const ChatBot();
          }));
        },
        backgroundColor: appTheme.primaryColor,
        child: const ImageIcon(
          AssetImage("assets/images/chatbot.png"),
          size: 28,
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


class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(6),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              height: 480,
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Accedi a Salerno Amica',
                        style: TextStyle(
                            color: appTheme.primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      )),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Inserisci le credenziali fornite\ndal Comune di Salerno:',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'E-mail',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //forgot password screen
                    },
                    child: Text(
                      'Ho dimenticato la mia Password',
                      style: TextStyle(color: appTheme.primaryColor),
                    ),
                  ),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      margin: const EdgeInsets.only(bottom: 15),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: appTheme.primaryColor,
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        child: const Text('Accedi'),
                        onPressed: () {
                          if (kDebugMode) {
                            print(emailController.text);
                            print(passwordController.text);
                          }
                        },
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Non possiedi le credenziali?'),
                      TextButton(
                        child: Text(
                          'Richiedi il tuo account',
                          style: TextStyle(
                              fontSize: 14, color: appTheme.primaryColor),
                        ),
                        onPressed: () {
                          //signup screen
                        },
                      )
                    ],
                  ),
                ],
              )),
        ));
  }
}

class HomeDown extends StatelessWidget {
  // lista di elementi da mostrare
  final List<Widget> itemList;
  final String itemLabel;
  const HomeDown({Key? key, required this.itemList, required this.itemLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "$itemLabel più recenti",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        SizedBox(
          //height: height! * .25 < 170 ? height! * .25 : 170,
          //height: height! * .25 < 300 ? height! * .25 : 300,
          child: ConstrainedBox(
            constraints:
            BoxConstraints(maxHeight: 280, minHeight: height! * .10),
            child: ListView.builder(
                itemBuilder: (context, index) => itemList[index],
                shrinkWrap: true,
                padding: const EdgeInsets.all(1.0),
                itemCount: itemList.length,
                scrollDirection: Axis.horizontal),
          ),
        ),
      ],
    );
  }
}

class Clipper08 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height);
    // ignore: non_constant_identifier_names
    var End = Offset(size.width / 2, size.height - 30.0);
    // ignore: non_constant_identifier_names
    var Control = Offset(size.width / 4, size.height - 50.0);

    path.quadraticBezierTo(Control.dx, Control.dy, End.dx, End.dy);
    // ignore: non_constant_identifier_names
    var End2 = Offset(size.width, size.height - 80.0);
    // ignore: non_constant_identifier_names
    var Control2 = Offset(size.width * .75, size.height - 10.0);

    path.quadraticBezierTo(Control2.dx, Control2.dy, End2.dx, End2.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
