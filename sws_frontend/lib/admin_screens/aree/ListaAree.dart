import 'package:flutter/material.dart';
import 'package:frontend_sws/admin_screens/aree/GestioneArea.dart';
import 'package:frontend_sws/components/menu/DrawerMenu.dart';
import 'package:frontend_sws/components/aree/AreaListItem.dart';
import 'package:frontend_sws/util/ToastUtil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:frontend_sws/services/AreeService.dart';
import 'package:frontend_sws/services/entity/Area.dart';
import 'package:frontend_sws/components/filtri/FilterBar.dart';

import '../../components/filtri/GenericFilter.dart';
import '../../components/filtri/TextFilter.dart';
import '../../components/generali/CustomAppBar.dart';
import '../../components/generali/CustomFloatingButton.dart';
import '../../components/generali/CustomPagedListView.dart';
import '../../theme/theme.dart';

class ListaAree extends StatefulWidget {
  const ListaAree({Key? key}) : super(key: key);
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.ListaAree';

  @override
  State<ListaAree> createState() => _ListaAreeState();
}

class _ListaAreeState extends State<ListaAree> {
  AreeService areeService = AreeService();
  final PagingController<int, Area> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await areeService.areeList(filterNome);

      _pagingController.appendLastPage(newItems!);
    } catch (error) {
      _pagingController.error = error;
    }
  }

  String? filterNome;

  void _filterNomeChanged(String? text) {
    filterNome = text;
    _pullRefresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerMenu(currentPage: ListaAree.id),
        resizeToAvoidBottomInset: false,
        floatingActionButton: CustomFloatingButton(
            iconData: Icons.add,
            onPressed: () {
              if (mounted) {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GestioneArea(null)))
                    .then((value) => _pullRefresh());
              }
            }),
        appBar: const CustomAppBar(title: AppTitle(label: "Gestione Aree")),
        body: RefreshIndicator(
            onRefresh: _pullRefresh,
            child: Column(children: <Widget>[
              FilterBar(filters: [
                TextFilter(
                    name: 'Ricerca per nome area...',
                    positionType: GenericFilterPositionType.row,
                    valueChange: _filterNomeChanged),
              ]),
              Flexible(
                  child: CustomPagedListView<Area>(
                    pagingController: _pagingController,
                    itemBuilder: (context, item, index) => AreaListItem(
                      name: item.nome,
                      id: item.id!,
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    GestioneArea(item.id)))
                            .then((v) => _pullRefresh())
                      },
                      onDelete: () {
                        areeService.deleteArea(item.id!).then((value) {
                          if (value) {
                            ToastUtil.success("Area eliminata", context);
                          } else {
                            ToastUtil.error("Errore server", context);
                          }
                          _pullRefresh();
                        });
                      },
                    )),
                  )
                  /*PagedListView<int, Area>(
                shrinkWrap: false,
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Area>(
                    itemBuilder: (context, item, index) => AreaListItem(
                          name: item.nome,
                          id: item.id!,
                          onTap: () => {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GestioneArea(item.id)))
                                .then((v) => _pullRefresh())
                          },
                          onDelete: () {
                            areeService.deleteArea(item.id!).then((value) {
                              if (value) {
                                ToastUtil.success("Area eliminata", context);
                              } else {
                                ToastUtil.error("Errore server", context);
                              }
                              _pullRefresh();
                            });
                          },
                        )),
              ))*/
            ])));
  }

  Future<void> _pullRefresh() async {
    _pagingController.refresh();
  }
}
