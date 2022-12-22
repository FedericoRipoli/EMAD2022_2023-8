import 'package:flutter/material.dart';
import 'package:frontend_sws/services/EventoService.dart';

import '../../services/entity/Evento.dart';

class GestioneEvento extends StatefulWidget {
  String? idEvento;
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.GestioneEvento';

  GestioneEvento({Key? key, required this.idEvento}) : super(key: key);

  @override
  State<GestioneEvento> createState() => _GestioneEventoState();
}

class _GestioneEventoState extends State<GestioneEvento> {
  late Future<bool> initCall;
  EventoService eventoService = EventoService();

  TextEditingController noteController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController contenutoController = TextEditingController();
  TextEditingController dataInizioController = TextEditingController();
  TextEditingController dataFineController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool loaded = false;
  final _formGlobalKey = GlobalKey<FormState>();
  Evento? evento;
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    //initCall = load();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// campi
/**
 * contenuto
 * data_fine
 * data_inizio
 * nome
 * note
 * stato
 * contatto
 * id_ente
 * posizione
 * locandina
 */
