import 'package:flutter/material.dart';

import '../../../components/enti/struttura/DetailPageStruttura.dart';
import '../../../components/generali/CustomAppBar.dart';
import '../../../components/loading/AllPageLoadTransparent.dart';
import '../../../services/StrutturaService.dart';
import '../../../services/entity/Struttura.dart';
import '../../../theme/theme.dart';



class InfoStruttura extends StatefulWidget {
  final String idStruttura;
  const InfoStruttura({Key? key, required this.idStruttura}) : super(key: key);

  @override
  State<InfoStruttura> createState() => _InfoStrutturaState();
}

class _InfoStrutturaState extends State<InfoStruttura> {
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();
  late Future<bool> initCall;
  StrutturaService stutturaService = StrutturaService();
  Struttura? struttura;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    initCall = load();
  }

  Future<bool> load() async {
    struttura = await stutturaService.getStruttura(widget.idStruttura);
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
              label: "Info Struttura",
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
                children.add(DetailPageStruttura(struttura: struttura!));
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
