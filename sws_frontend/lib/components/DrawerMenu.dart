import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_sws/main.dart';
import 'package:frontend_sws/screens/InitApp.dart';
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
        children: <Widget>[
                GFDrawerHeader(
                  currentAccountPicture: GFAvatar(
                    shape: GFAvatarShape.standard,
                    child: Text(
                        userService.getName()!.substring(0, 2).toUpperCase()),
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
                ),
                ListTile(
                  title: GFTypography(
                    text: 'Gestione Admin Enti',
                    textColor: Colors.black,
                    dividerWidth: 120,
                    dividerColor: appTheme.primaryColor,
                    type: GFTypographyType.typo4,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GestioneAdminEnti()));
                  },
                ),
                ListTile(
                  title: GFTypography(
                    text: 'Gestione Servizi',
                    textColor: Colors.black,
                    dividerWidth: 120,
                    dividerColor: appTheme.primaryColor,
                    type: GFTypographyType.typo4,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: GFButton(
                    position: GFPosition.start,
                    onPressed: () {
                      userService.logout();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const InitApp()), (route) => false);
                    },
                    text: "Esci",
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                ),
              ]

      ),
    );
  }
}
