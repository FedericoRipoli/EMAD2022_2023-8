import 'dart:convert';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:frontend_sws/components/generali/AddDefCard.dart';
import 'package:frontend_sws/components/generali/CustomFloatingButton.dart';
import 'package:frontend_sws/screens/eventi/InfoEvento.dart';
import 'package:frontend_sws/screens/servizi/InfoServizio.dart';
import 'package:frontend_sws/services/ImpostazioniService.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import '../admin_screens/servizi/ListaServizi.dart';
import '../components/generali/LoginForm.dart';
import '../components/generali/TopicCard.dart';
import '../components/menu/DrawerMenu.dart';
import '../services/UserService.dart';
import '../services/entity/Impostazioni.dart';
import 'Chat.dart';
import 'InfoScreen.dart';
import 'OliviaChat.dart';
import 'eventi/EventiScreen.dart';
import 'servizi/ServiziScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.Home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserService userService = UserService();
  ImpostazioniService impostazioniService = ImpostazioniService();
  late Future<bool> initCall;
  Impostazioni? impostazioni;

  void notificationTapMessage(Map<String, dynamic> data) {
    debugPrint("onMessageOpenedApp");
    if (data.containsKey("idEvento")) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InfoEvento(idEvento: data["idEvento"])));
    } else if (data.containsKey("idServizio")) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  InfoServizio(idServizio: data["idServizio"])));
    } else {}
  }

  Future<void> showNotification(RemoteMessage payload) async {
    var android = const AndroidInitializationSettings('icon');
    var initiallizationSettingsIOS = const DarwinInitializationSettings();
    var initialSetting = InitializationSettings(
        android: android, iOS: initiallizationSettingsIOS);
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(
      initialSetting,
      onDidReceiveNotificationResponse: (details) {
        Map<String, dynamic> map = jsonDecode(details.payload!);
        notificationTapMessage(map);
      },
    );

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'default_notification_channel_id',
      'Notification',
      channelDescription: 'All Notification is Here',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: "icon",
      playSound: true,
    );
    const iOSDetails = DarwinNotificationDetails();
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await flutterLocalNotificationsPlugin.show(0, payload.notification!.title,
        payload.notification!.body, platformChannelSpecifics,
        payload: jsonEncode(payload.data));
  }

  Future<void> registerNotification() async {
    FirebaseMessaging _messaging = FirebaseMessaging.instance;
    _messaging.subscribeToTopic("all");
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await _messaging.getToken();

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        showNotification(message);
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        notificationTapMessage(message.data);
      });
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  @override
  void initState() {
    super.initState();

    initCall = load();
  }

  Future<bool> load() async {
    impostazioni = await impostazioniService.getImpostazioni();
    if (!kIsWeb) {
      await registerNotification();

    }
    setState(() {});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      key: _scaffoldKey,
      drawer: userService.isLogged()
          ? DrawerMenu(currentPage: HomeScreen.id)
          : null,
      leading: userService.isLogged()
          ? null
          : GFIconButton(
              icon: const Icon(
                Icons.account_circle_sharp,
                color: Colors.white,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      content: LoginForm(userService: userService),
                    );
                  },
                ).then((value) => setState(() => {}));
              },
              type: GFButtonType.transparent,
            ),
      title: const AppTitle(
        label: "Salerno Amica",
      ),
      centerTitle: true,
      actions: [
        GFIconButton(
            color: Colors.transparent,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InfoScreen()),
              );
            },
            icon: const Icon(
              Icons.info_outline_rounded,
              color: AppColors.white,
            )),
      ],
      floatingActionButton: CustomFloatingButton(
        iconData: Icons.headset_mic,
        onPressed: () {
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OliviaChat()),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      alwaysShowLeadingAndAction: true,
      headerWidget: headerWidgetWithImage(context),
      curvedBodyRadius: 20,
      headerExpandedHeight: 0.24,
      body: [
        const Text(
          "Esplora le funzionalità",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const Icon(Icons.keyboard_double_arrow_up_rounded),
        GridView.count(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          children: [
            TopicCard(
              title: "Servizi",
              icon: Icons.handshake,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ServiziScreen()),
                );
              },
            ),
            TopicCard(
              title: "Eventi",
              icon: Icons.event_available,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventiScreen()),
                );
              },
            ),
            TopicCard(
              title: "Olivia",
              icon: Icons.live_help_rounded,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OliviaChat()),
                );
              },
            ),
            TopicCard(
              disabled: impostazioni == null,
              title: "Defibrillatori",
              icon: Icons.monitor_heart,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ServiziScreen(
                            idAreaSelected: impostazioni?.idArea,
                          )),
                );
              },
            ),
          ],
        ),
        AddDefCard(disabled: impostazioni == null),
        //AddDefCard(),
      ],
      fullyStretchable: false,
      backgroundColor: AppColors.bgWhite,
      appBarColor: AppColors.logoBlue,
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      color: AppColors.logoBlue,
      child: Center(
          child: Container(
              margin: const EdgeInsets.only(top: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const HomeTitle(),
                  Image.asset(
                    "assets/images/logo.png",
                    width: 82,
                  ),
                ],
              ))),
    );
  }
}

Widget headerWidgetWithImage(BuildContext context) {
  return Container(
      //color: AppColors.logoBlue,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Center(
            child: Container(
                margin: const EdgeInsets.only(top: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const HomeTitle(),
                    Image.asset(
                      "assets/images/logo.png",
                      width: 80,
                    ),
                  ],
                ))),
      ));
}
