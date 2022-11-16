import 'package:flutter/material.dart';
import 'package:frontend_sws/main.dart';
import '../entity/Evento.dart';
import 'Servizi.dart';
import 'Events.dart';
import 'Options.dart';
import 'package:flutter/foundation.dart';
import '../entity/Servizio.dart';
import 'package:sidebarx/sidebarx.dart';

int sel = 1;
double? width;
double? height;
final screens = [
  const Servizi(),
  const HomeScreen(),
  const Events(),
];

// Barra di navigazione
class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigation.selIndex=0;

    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;
    return Scaffold(
      // bottomNavigationBar: /*NavigationTest()*/Navigation(),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        hoverElevation: 0,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Pagina chatbot"),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const <Widget>[Text("CHAT")],
                ),
              );
            },
          );
        },
        backgroundColor: appTheme.primaryColor,
        child: const ImageIcon(
          AssetImage("assets/images/chatbot.png"),
          size: 28,
        ),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            const HomeTop(),
            HomeDown(
              itemLabel: "Servizi",
              itemList: listServices,
            ),
            HomeDown(itemList: listEventi, itemLabel: "Eventi"),
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
    ambito: "SA",
    tipologia: "Mensa",
  ),
  const Servizio(
    id: "00002",
    nome: "Trasporto Anziani",
    contenuto: "Servizio di trasporto per gli anziani",
    visibile: true,
    tags: "anziani",
    ambito: "AZ",
    tipologia: "Trasporto",
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

// selezione servizi

class HomeTop extends StatefulWidget {
  const HomeTop({super.key});

  @override
  State<HomeTop> createState() => _HomeTopAdmin();
}

// parte superiore della Home
class _HomeTop extends State<HomeTop> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: Clipper08(),
          child: Container(
            height: height! * .65 < 460 ? height! * .65 : 500, //400
            //color: Colors.tealAccent,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              appTheme.primaryColor,
              appTheme.secondaryHeaderColor
            ])),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height! / 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.account_circle_rounded),
                        color: Colors.white,
                        iconSize: 32,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                content: LoginForm(),
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(
                        width: width! * 0.05,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                SizedBox(
                  height: height! / 24,
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
                SizedBox(height: height! * 0.0375),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _HomeTopAdmin extends State<HomeTop> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: Clipper08(),
          child: Container(
            height: height! * .65 < 460 ? height! * .65 : 500, //400
            //color: Colors.tealAccent,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  appTheme.primaryColor,
                  appTheme.secondaryHeaderColor
                ])),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height! / 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.account_circle_rounded),
                        color: Colors.white,
                        iconSize: 32,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SideBarLaterale();
                            },
                          );
                        },
                      ),
                      SizedBox(
                        width: width! * 0.05,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                SizedBox(
                  height: height! / 24,
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
                SizedBox(height: height! * 0.0375),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class SideBarLaterale extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.only(right: 250),
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Admin'),
            accountEmail: Text('admin@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorites'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Friends'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Request'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Policies'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => null,
          ),
        ],
      ),
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

// Form Login Ente / Comune
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

// campo ricerca
/*
* Container(
                  width: 300,
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: TextField(
                      controller: c,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      cursorColor: appTheme.primaryColor,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 13),
                          suffixIcon: Material(
                            elevation: 2.0,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            child: InkWell(
                              child: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const SearchTab();
                                }));
                              },
                            ),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: height! * 0.025,
                ),
* */

/*
* Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: DropdownButton(
                        // Initial Value
                        value: dropdownvalue,
                        dropdownColor: appTheme.primaryColor,
                        // Down Arrow Icon
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),

                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: width! * 0.055,
                    ),
                    InkWell(
                      child: DropdownButton(
                        // Initial Value
                        value: dropdownvalue2,
                        dropdownColor: appTheme.primaryColor,
                        // Down Arrow Icon
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),

                        // Array list of items
                        items: items2.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue2 = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                )
* */
