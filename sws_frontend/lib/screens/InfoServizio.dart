import 'package:flutter/material.dart';
import 'package:frontend_sws/components/loading/AllPageLoadTransparent.dart';
import 'package:frontend_sws/services/ServizioService.dart';
import 'package:frontend_sws/services/entity/Servizio.dart';
import 'package:frontend_sws/theme/theme.dart';

import '../components/generali/CustomAppBar.dart';
import '../components/servizi/DetailPageService.dart';

class InfoServizio extends StatefulWidget {

  String idServizio;

  InfoServizio(this.idServizio, {super.key});

  @override
  State<StatefulWidget> createState() => _InfoServizioState();

}

class _InfoServizioState extends State<InfoServizio>{
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();
  late Future<bool> initCall;
  ServizioService servizioService = ServizioService();
  Servizio? servizio;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    initCall = load();
  }

  Future<bool> load() async {
    servizio = await servizioService.getServizio(widget.idServizio);

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
            title: "Info Servizio",
            iconData: Icons.arrow_back,
            onPressed: () => Navigator.pop(context)),
        body: FutureBuilder<bool>(
            future: initCall,
            builder: ((context, snapshot) {
              List<Widget> children = [];

              if (!snapshot.hasData && !snapshot.hasError || !loaded) {
                children.add(const AllPageLoadTransparent());
              }
              List<Widget> columnChild = [];
              columnChild.add(
                DetailPageService(
                    title: servizio!.nome,
                    ente: "servizio",
                    area: servizio!.aree.toString())
              );
              children.add(SingleChildScrollView(
                  child: Column(
                    children: columnChild,
                  )));
              return AbsorbPointer(
                absorbing: !(snapshot.hasData || snapshot.hasError),
                child: Stack(
                  children: children,
                ),
              );
            })));
  }

}
