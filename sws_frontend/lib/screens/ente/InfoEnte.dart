import 'package:flutter/material.dart';

import '../../components/enti/DetailPageEnte.dart';
import '../../components/generali/CustomAppBar.dart';
import '../../components/loading/AllPageLoadTransparent.dart';
import '../../services/EnteService.dart';
import '../../services/entity/Ente.dart';
import '../../theme/theme.dart';

class InfoEnte extends StatefulWidget {
  final String idEnte;
  const InfoEnte({Key? key, required this.idEnte}) : super(key: key);

  @override
  State<InfoEnte> createState() => _InfoEnteState();
}

class _InfoEnteState extends State<InfoEnte> {
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();
  late Future<bool> initCall;
  EnteService enteService = EnteService();
  Ente? ente;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    initCall = load();
  }

  Future<bool> load() async {
    ente = await enteService.getEnte(widget.idEnte);
    setState(() {
      loaded = true;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKeyAdmin,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
            title: const AppTitle(
              label: "Info Ente",
            ),
            iconData: Icons.arrow_back,
            onPressed: () => Navigator.pop(context)),
        body: FutureBuilder<bool>(
            future: initCall,
            builder: ((context, snapshot) {
              List<Widget> children = [];

              if (!snapshot.hasData && !snapshot.hasError || !loaded) {
                children.add(const AllPageLoadTransparent());
              }
              if (snapshot.hasData) {
                children.add(DetailPageEnte(ente: ente!));
              }
              return AbsorbPointer(
                absorbing: !(snapshot.hasData || snapshot.hasError),
                child: Stack(
                  children: children,
                ),
              );
            })));
  }
}
