import 'package:flutter/material.dart';
import 'package:frontend_sws/components/filtri/DropDownFilter.dart';
import 'package:frontend_sws/components/menu/DrawerMenu.dart';
import 'package:frontend_sws/util/ToastUtil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:frontend_sws/components/filtri/FilterBar.dart';

import '../../components/filtri/GenericFilter.dart';
import '../../components/filtri/TextFilter.dart';
import '../../components/generali/CustomAppBar.dart';
import '../../components/generali/CustomFloatingButton.dart';
import '../../components/generali/CustomPagedListView.dart';
import '../../components/servizi/ServizioListItem.dart';
import '../../services/ServizioService.dart';
import '../../services/UserService.dart';
import '../../services/entity/Servizio.dart';
import '../../theme/theme.dart';
import 'GestioneServizio.dart';

class ListaServizi extends StatefulWidget {
  const ListaServizi({Key? key}) : super(key: key);
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.ListaServizi';

  @override
  State<ListaServizi> createState() => _ListaServiziState();
}

class _ListaServiziState extends State<ListaServizi> {
  ServizioService servizioService = ServizioService();
  UserService userService = UserService();
  List<DropDownFilterItem> itemsFilterStato = [];
  late String idEnte;
  final PagingController<int, Servizio> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    idEnte = userService.getIdEnte()!;
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    itemsFilterStato.add(DropDownFilterItem(name: "Tutti"));

    itemsFilterStato.addAll(Servizio.getStatiList()
        .entries
        .map((e) => DropDownFilterItem(name: e.value, id: e.key))
        .toList());

    super.initState();
  }

  String? filterNome;
  String? filterStato;

  void _filterNomeChanged(String? text) {
    filterNome = text;
    _pullRefresh();
  }

  void _filterStatoChanged(String? text) {
    filterStato = text;
    _pullRefresh();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await servizioService.serviziList(
          filterNome, null, null, filterStato, pageKey, true,null);
      final isLastPage = newItems == null || newItems.isEmpty;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems!);
      } else {
        pageKey++;
        _pagingController.appendPage(newItems, pageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerMenu(currentPage: ListaServizi.id),
        resizeToAvoidBottomInset: false,
        floatingActionButton: CustomFloatingButton(
            iconData: Icons.add,
            onPressed: () {
              if (mounted) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GestioneServizio(
                            idServizio: null,
                            idEnte: idEnte))).then((value) => _pullRefresh());
              }
            }),
        appBar: const CustomAppBar(title: AppTitle(label: "Gestione Servizi")),
        body: RefreshIndicator(
            onRefresh: _pullRefresh,
            child: Column(children: <Widget>[
              FilterBar(filters: [
                TextFilter(
                    name: 'Nome',
                    positionType: GenericFilterPositionType.row,
                    valueChange: _filterNomeChanged),
                DropDownFilter(
                    name: "Stato",
                    positionType: GenericFilterPositionType.row,
                    valueChange: _filterStatoChanged,
                    values: itemsFilterStato)
              ]),
              Flexible(
                child: CustomPagedListView<Servizio>(
                    pagingController: _pagingController,
                    itemBuilder: (context, item, index) => ServizioListItem(
                          name: item.nome,
                          id: item.id!,
                          statoOperazione: item.stato!,
                          onTap: () => {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GestioneServizio(
                                            idServizio: item.id,
                                            idEnte: idEnte)))
                                .then((v) => _pullRefresh())
                          },
                          onDelete: () {
                            servizioService
                                .deleteServizio(item.id!)
                                .then((value) {
                              if (value) {
                                ToastUtil.success(
                                    "Servizio eliminato", context);
                              } else {
                                ToastUtil.error("Errore server", context);
                              }
                              _pullRefresh();
                            });
                          },
                        )),
              ),
            ])));
  }

  Future<void> _pullRefresh() async {
    _pagingController.refresh();
  }
}
