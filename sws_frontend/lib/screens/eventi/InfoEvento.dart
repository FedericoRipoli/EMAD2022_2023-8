import 'package:flutter/material.dart';

import '../../components/eventi/DetailPageEvento.dart';
import '../../components/generali/CustomAppBar.dart';
import '../../components/loading/AllPageLoadTransparent.dart';
import '../../services/EventoService.dart';
import '../../services/entity/Evento.dart';
import '../../theme/theme.dart';

class InfoEvento extends StatefulWidget {
  final String idEvento;
  const InfoEvento({Key? key, required this.idEvento}) : super(key: key);

  @override
  State<InfoEvento> createState() => _InfoEventoState();
}

class _InfoEventoState extends State<InfoEvento> {
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();
  late Future<bool> initCall;
  EventoService eventoService = EventoService();
  Evento? evento;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    initCall = load();
  }

  Future<bool> load() async {
    evento = await eventoService.getEvento(widget.idEvento);
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
              label: "Info Evento",
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
                children.add(DetailPageEvento(evento: evento!));
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
