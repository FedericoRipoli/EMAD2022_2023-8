import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import '../admin_screens/GestioneAdminEnti.dart';
import '../services/UserService.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return GFDrawer(
      elevation: 4,
      child: ListView(
        padding: EdgeInsets.zero,
        children: userService.isAdmin()!
            ? <Widget>[
                GFDrawerHeader(
                  currentAccountPicture: GFAvatar(
                    shape: GFAvatarShape.standard,
                    child: Text(userService.getName()!.substring(0, 1)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const GFTypography(
                        text: 'Username:',
                        textColor: Colors.white,
                        type: GFTypographyType.typo6,
                      ),
                      GFTypography(
                        text: userService.getName() ?? "",
                        textColor: Colors.white,
                        type: GFTypographyType.typo5,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const GFTypography(
                    text: 'Gestione Admin Enti',
                    textColor: Colors.white,
                    type: GFTypographyType.typo6,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GestioneAdminEnti()));
                  },
                ),
                ListTile(
                  title: GFButton(
                    position: GFPosition.start,
                    onPressed: () {
                      userService.logout();
                      setState(() {});
                      Navigator.pop(context);
                    },
                    text: "Esci",
                    icon: const Icon(Icons.logout),
                  ),
                ),
              ]
            : <Widget>[
                GFDrawerHeader(
                  currentAccountPicture: GFAvatar(
                    shape: GFAvatarShape.standard,
                    child: Text(userService.getName()!.substring(0, 1)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const GFTypography(
                        text: 'Username:',
                        textColor: Colors.white,
                        type: GFTypographyType.typo6,
                      ),
                      GFTypography(
                        text: userService.getName() ?? "",
                        textColor: Colors.white,
                        type: GFTypographyType.typo5,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const GFTypography(
                    text: 'Il mio Ente',
                    textColor: Colors.white,
                    type: GFTypographyType.typo6,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: GFButton(
                    position: GFPosition.start,
                    onPressed: () {
                      userService.logout();
                      setState(() {});
                      Navigator.pop(context);
                    },
                    text: "Esci",
                    icon: const Icon(Icons.logout),
                  ),
                ),
              ],
      ),
    );
    ;
  }
}
