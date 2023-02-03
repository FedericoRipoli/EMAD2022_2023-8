import 'package:flutter/material.dart';
import 'package:frontend_sws/components/generali/CustomAppBar.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../theme/theme.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle.isEmpty ? 'Non disponibile' : subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        iconData: Icons.arrow_back,
        title: AppTitle(
          label: 'Informazioni',
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 86,
                ),
                const SizedBox(
                  height: 14,
                ),
                const Text(
                  "CHE COS'È SALERNO AMICA?",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: "Lexend",
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "L'applicazione Salerno Amica nasce come punto di aggregazione di tutti i servizi"
                  " che il Comune di Saleno, mette a disposizione dei suoi cittadini, gratuitamente.\n"
                  "Visualizza tutti i Servizi tramite gli appositi filtri di ricerca o utilizzando la comoda mappa. "
                  "Aiuta i tuoi concittadini aggiungendo la posizione dei defibrillatori per permetterne il facile ritrovamento.",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 8,
                ),
                _infoTile('App name', 'Salerno Amica'),
                _infoTile('App version', _packageInfo.version),
              ],
            ),
          )),
    );
  }
}
