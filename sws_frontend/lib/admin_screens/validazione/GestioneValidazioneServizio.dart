import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:frontend_sws/theme/theme.dart';

import '../../components/generali/CustomAppBar.dart';
import '../../components/generali/InModificaServizio.dart';
import '../../components/loading/AllPageLoadTransparent.dart';
import '../../components/menu/DrawerMenu.dart';
import 'package:frontend_sws/components/generali/ConfirmBox.dart';
import '../../components/servizi/DetailServiceToValidate.dart';
import '../../services/ServizioService.dart';
import '../../services/entity/Servizio.dart';
import '../../util/ToastUtil.dart';

class GestioneValidazioneServizio extends StatefulWidget {
  String? idServizio;
  static String id =
      'it.unisa.emad.comunesalerno.sws.ipageutil.GestioneValidazioneServizio';

  GestioneValidazioneServizio({this.idServizio, super.key});

  @override
  State<StatefulWidget> createState() => _GestioneServizio();
}

class _GestioneServizio extends State<GestioneValidazioneServizio> {
  late Future<bool> initCall;
  ServizioService servizioService = ServizioService();
  late double _distanceToField;

  Servizio? servizio;
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    loaded = false;
    initCall = load();
  }

  Future<bool> load() async {
    servizio = widget.idServizio != null
        ? await servizioService.getServizio(widget.idServizio!)
        : null;

    setState(() {
      loaded = true;
    });
    return true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKeyAdmin,
        resizeToAvoidBottomInset: false,
        drawer: DrawerMenu(currentPage: GestioneValidazioneServizio.id),
        floatingActionButton: SpeedDial(
          backgroundColor: AppColors.logoBlue,
          icon: Icons.swap_horiz,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.edit, color: AppColors.white),
              label: 'In modifica',
              backgroundColor: AppColors.logoCyan,
              onTap: () {
                modificaServizio();
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.delete_forever, color: AppColors.white),
              label: 'Elimina Servizio',
              backgroundColor: AppColors.logoRed,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ConfirmBox(
                      label: "il servizio",
                      onDelete: eliminaServizio,
                    );
                  },
                );
              },
            ),
            SpeedDialChild(
              child: const Icon(
                Icons.verified_outlined,
                color: AppColors.white,
              ),
              label: 'Approva',
              backgroundColor: Colors.green,
              onTap: () {
                approvaServizio();
              },
            ),
          ],
        ),
        appBar: CustomAppBar(
            title: const AppTitle(label: "Validazione Servizio"),
            iconData: Icons.arrow_back,
            onPressed: () => Navigator.pop(context)),
        body: FutureBuilder<bool>(
            future: initCall,
            builder: ((context, snapshot) {
              List<Widget> children = [];

              if (snapshot.hasData) {
                children.add(DetailServiceToValidate(servizio: servizio!));
              }
              if (!snapshot.hasData && !snapshot.hasError || !loaded) {
                children.add(const AllPageLoadTransparent());
              }
              return AbsorbPointer(
                absorbing: !(snapshot.hasData || snapshot.hasError),
                child: Stack(
                  children: children,
                ),
              );
            })));
  }

  void activeLoad() {
    loaded = false;
    setState(() {});
  }

  void deactiveLoad() {
    loaded = true;
    setState(() {});
  }

  void approvaServizio() async {
    activeLoad();
    Servizio? nServizio = await servizioService.editStatoServizio(
        servizio!.id!, Servizio.APPROVATO, null);
    if (nServizio == null) {
      if (mounted) {}
      //Navigator.pop(context);
      ToastUtil.error("Errore server", context);
    } else {
      servizio = nServizio;
    }
    deactiveLoad();
    //operazioni
  }

  void eliminaServizio() async {
    activeLoad();
    bool nServizio = await servizioService.deleteServizio(servizio!.id!);
    if (mounted) {}

    if (!nServizio) {
      ToastUtil.error("Errore server", context);
    } else {
      Navigator.of(context).pop();
      ToastUtil.success("Servizio eliminato", context);
    }
    deactiveLoad();
  }

  void modificaServizio() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: InModificaServizio(servizio: servizio!),
        );
      },
    ).then((value) {
      activeLoad();
      load();
    });
  }
}
