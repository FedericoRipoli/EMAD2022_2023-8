import 'package:flutter/material.dart';
import 'package:frontend_sws/main.dart';
import 'package:frontend_sws/screens/InitApp.dart';
import 'package:getwidget/getwidget.dart';
import '../../admin_screens/utenti/ListaUtenti.dart';
import '../../services/UserService.dart';
import 'CustomMenuItem.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key, required this.currentPage}) : super(key: key);
  final String currentPage;

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  UserService userService = UserService();

  void checkChangePage(String newPage) {
    //close menu
    Navigator.pop(context);
    if (widget.currentPage == newPage) {
      Navigator.pop(context);
      return;
    }
  }

  List<Widget> getMenuItems() {
    List<Widget> w = [];
    w.add(GFDrawerHeader(
      currentAccountPicture: GFAvatar(
        shape: GFAvatarShape.standard,
        child: Text(userService.getName()!.substring(0, 2).toUpperCase()),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          GFTypography(
            showDivider: false,
            text: userService.getName() ?? "",
            textColor: Colors.white,
            type: GFTypographyType.typo4,
          ),
        ],
      ),
    ));

    bool? admin = userService.isAdmin();
    if (userService.isLogged() && admin != null && admin) {
      w.add(CustomMenuItem(
          text: 'Gestione Utenti',
          f: () {
            checkChangePage(ListaUtenti.id);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ListaUtenti()));
          }));
    }
    if (userService.isLogged() && admin != null && !admin) {
      w.add(CustomMenuItem(text: 'Gestione Servizi', f: () {}));
    }
    if (userService.isLogged()) {
      w.add(ListTile(
        title: GFButton(
          position: GFPosition.start,
          onPressed: () {
            userService.logout();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const InitApp()),
                (route) => false);
          },
          text: "Esci",
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
      ));
    }

    return w;
  }

  @override
  Widget build(BuildContext context) {
    return GFDrawer(
      elevation: 4,
      child: ListView(padding: EdgeInsets.zero, children: getMenuItems()),
    );
  }
}
