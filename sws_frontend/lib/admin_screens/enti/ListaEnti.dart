import 'package:flutter/material.dart';
import 'package:frontend_sws/components/menu/DrawerMenu.dart';
import 'package:frontend_sws/services/EnteService.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:frontend_sws/services/entity/Ente.dart';
import 'package:frontend_sws/components/filtri/FilterBar.dart';

import '../../components/filtri/GenericFilter.dart';
import '../../components/filtri/TextFilter.dart';
import '../../components/generali/CustomAppBar.dart';
import '../../components/generali/CustomFloatingButton.dart';
import '../../components/enti/EnteListItem.dart';
import '../../components/generali/CustomPagedListView.dart';
import '../../theme/theme.dart';
import '../../util/ToastUtil.dart';
import 'GestioneEnte.dart';

class ListaEnti extends StatefulWidget {
  const ListaEnti({Key? key}) : super(key: key);
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.ListaEnti';

  @override
  State<ListaEnti> createState() => _ListaEntiState();
}

class _ListaEntiState extends State<ListaEnti> {
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();
  EnteService enteService = EnteService();
  final PagingController<int, Ente> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  String? filterNome;

  void _filterNomeChanged(String? text) {
    filterNome = text;
    _pullRefresh();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await enteService.enteList(
          filterNome, pageKey, "sort=denominazione&denominazione.dir=asc");

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
        key: _scaffoldKeyAdmin,
        drawer: DrawerMenu(currentPage: ListaEnti.id),
        resizeToAvoidBottomInset: false,
        floatingActionButton: CustomFloatingButton(
          iconData: Icons.add,
          onPressed: () {
            if (mounted) {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GestioneEnte(null)))
                  .then((v) => _pullRefresh());
            }
          },
        ),
        appBar: const CustomAppBar(title: AppTitle(label: "Gestione Enti")),
        body: RefreshIndicator(
            onRefresh: _pullRefresh,
            child: Column(children: <Widget>[
              FilterBar(filters: [
                TextFilter(
                    name: 'Ricerca per nome...',
                    positionType: GenericFilterPositionType.row,
                    valueChange: _filterNomeChanged),
              ]),
              Flexible(
                child: CustomPagedListView<Ente>(
                    pagingController: _pagingController,
                    itemBuilder: (context, item, index) => EnteListItem(
                        denominazione: item.denominazione,
                        id: item.id!,
                        onDelete: () {
                          enteService.deleteEnte(item.id!).then((value) {
                            if (value) {
                              ToastUtil.success("Ente eliminato", context);
                            } else {
                              ToastUtil.error("Errore server", context);
                            }
                            _pullRefresh();
                          });
                        },
                        onTap: () => {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              GestioneEnte(item.id)))
                                  .then((v) => _pullRefresh())
                            })),
              )
            ])));
  }

  Future<void> _pullRefresh() async {
    _pagingController.refresh();
  }
}
