import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:frontend_sws/components/enti/struttura/DetailPageStruttura.dart';
import 'package:frontend_sws/components/enti/struttura/StrutturaListItem.dart';
import 'package:frontend_sws/components/generali/CustomAvatar.dart';
import 'package:frontend_sws/components/loading/AllPageLoad.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

import '../../screens/ente/strutture/InfoStruttura.dart';
import '../../services/StrutturaService.dart';
import '../../services/entity/Ente.dart';
import '../../services/entity/Struttura.dart';
import '../../theme/theme.dart';

class DetailPageEnte extends StatefulWidget {
  final Ente ente;

  const DetailPageEnte({Key? key, required this.ente}) : super(key: key);

  @override
  State<DetailPageEnte> createState() => _DetailPageEnteState();
}

class _DetailPageEnteState extends State<DetailPageEnte> {
  List<Struttura>? strutture = null;
  StrutturaService strutturaService = StrutturaService();

  Future<void> _fetchStrutture() async {
    try {
      strutture =
          (await strutturaService.struttureList(null, widget.ente.id!))!;
    } catch (error) {
      print(error);
    }

    setState(() {});
  }

  @override
  void initState() {
    _fetchStrutture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets defaultPaddingElement = const EdgeInsets.fromLTRB(30, 0, 30, 0);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: WaveClipperTwo(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      height: 120,
                      color: AppColors.logoBlue,
                      child: ListTile(
                        title: Text(
                          "ENTE ${widget.ente.denominazione}",
                          style: const TextStyle(
                              color: AppColors.white,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w700,
                              fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Informazioni",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.logoCadmiumOrange),
              ),
              GFCard(
                elevation: 3,
                title: GFListTile(
                  title: Text(
                    widget.ente.denominazione,
                    style: const TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  description: Text(
                    widget.ente.descrizione ?? "Descrizione non disponibile",
                    style:
                        const TextStyle(color: AppColors.black, fontSize: 16),
                  ),
                  icon: const Icon(
                    Icons.info,
                    color: AppColors.logoCadmiumOrange,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "Le nostre strutture",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.logoCadmiumOrange),
              ),
              const SizedBox(
                height: 6,
              ),
              strutture != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: strutture!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return StrutturaListItem(
                          denominazione: strutture![index].denominazione!,
                          indirizzo: strutture![index].posizione!.indirizzo!,
                          id: strutture![index].id!,
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InfoStruttura(
                                          idStruttura: strutture![index].id!,
                                        )))
                          },
                        );
                      })
                  : const Center(
                      child: Text(
                      "Nessuna struttura",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.logoCadmiumOrange),
                    )),
            ],
          ),
        ));
  }
}
