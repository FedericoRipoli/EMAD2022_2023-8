import 'package:flutter/material.dart';
import 'package:frontend_sws/screens/InitApp.dart';
import 'package:getwidget/getwidget.dart';
import '../../admin_screens/contatti/ListaContatti.dart';
import '../../admin_screens/enti/ListaEnti.dart';
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

    w.add(
        UserAccountsDrawerHeader(

          accountName: Text(userService.getName()!,style:const TextStyle(
            fontSize: 20
          )),
          accountEmail: const Text(""),
          currentAccountPicture: GFAvatar(
            shape: GFAvatarShape.circle,
            child: Text(userService.getName()!.substring(0, 1).toUpperCase()),
          ),

          //.. This line of code provides the usage of multiple accounts
          /* otherAccountsPictures: <Widget>[
              GestureDetector(
                onTap: ()=> switchUser(),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(otherProfilePic)
                ),
              ),
            ], */

          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage("https://png.pngtree.com/thumb_back/fh260/background/20190828/pngtree-dark-vector-abstract-background-image_302715.jpg")
            ),
          ),
        )
    );
    /*w.add(
        GFDrawerHeader(
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
    ));*/

    bool? admin = userService.isAdmin();
    if (userService.isLogged() && admin != null && admin) {
      w.add(CustomMenuItem(
          text: 'Gestione Utenti',
          f: () {
            checkChangePage(ListaUtenti.id);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ListaUtenti()));
          }));
      w.add(CustomMenuItem(
          text: 'Gestione Enti',
          f: () {
            checkChangePage(ListaUtenti.id);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ListaEnti()));
          }));
    }
    if (userService.isLogged() && admin != null && !admin) {
      w.add(CustomMenuItem(text: 'Gestione Servizi', f: () {}));
      w.add(CustomMenuItem(
          text: 'Gestione Contatti',
          f: () {
            checkChangePage(ListaContatti.id);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ListaContatti()));
          }));
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
