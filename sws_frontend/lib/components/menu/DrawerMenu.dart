import 'package:flutter/material.dart';
import 'package:frontend_sws/components/CustomAvatar.dart';
import 'package:frontend_sws/screens/DraggableHomeScreen.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:getwidget/getwidget.dart';
import '../../admin_screens/ambiti/GestioneAmbiti.dart';
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

    w.add(UserAccountsDrawerHeader(
      accountName: Text(userService.getName()!,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      accountEmail: const Text(""),
      currentAccountPicture: CustomAvatar(),

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
        color: AppColors.logoBlue,
        /*image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage(""),
      )*/
      ),
    ));
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
      w.add(CustomMenuItem(
          text: 'Gestione Ambiti',
          f: () {
            checkChangePage(ListaUtenti.id);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const GestioneAmbiti()));
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
      w.add(SizedBox(height: 20));
      w.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GFButton(
            color: AppColors.logoBlue,
            shape: GFButtonShape.pills,
            padding: const EdgeInsets.only(left: 20, right: 20),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const DraggableHomeScreen()),
                  (route) => false);
            },
            buttonBoxShadow: false,
            borderSide: BorderSide.none,
            text: "Home",
            size: GFSize.MEDIUM,
            textStyle: const TextStyle(fontSize: 16, color: AppColors.white),
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
          GFButton(
            onPressed: () {
              userService.logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const DraggableHomeScreen()),
                  (route) => false);
            },
            padding: const EdgeInsets.only(left: 20, right: 20),
            shape: GFButtonShape.pills,
            size: GFSize.MEDIUM,
            text: "Esci",
            color: AppColors.logoBlue,
            buttonBoxShadow: false,
            borderSide: BorderSide.none,
            textStyle: const TextStyle(fontSize: 16, color: AppColors.white),
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
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
