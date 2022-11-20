// utility libraries
import 'package:flutter/material.dart';
import 'package:frontend_sws/main.dart';

// screens
import 'Servizi.dart';
import 'Events.dart';
import 'HomeScreen.dart';

int sel = 1;
double? width;
double? height;
final screens = [
  const Servizi(),
  const Home(),
  const Events(),
];

// inizializza l'app
class InitApp extends StatefulWidget {
  const InitApp({Key? key}) : super(key: key);

  @override
  State<InitApp> createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> {
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
          unselectedItemColor: appTheme.secondaryHeaderColor,
          selectedItemColor: appTheme.primaryColor,
          type: BottomNavigationBarType.shifting,
          backgroundColor: Colors.white,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          currentIndex: sel,
          elevation: 2,
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
