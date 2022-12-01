import 'package:flutter/material.dart';
import 'package:frontend_sws/admin_screens/aree/GestioneArea.dart';
import 'package:frontend_sws/components/filtri/FilterController.dart';
import 'package:frontend_sws/components/menu/DrawerMenu.dart';
import 'package:frontend_sws/components/aree/AreaListItem.dart';
import 'package:frontend_sws/util/ToastUtil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:frontend_sws/services/AreeService.dart';
import 'package:frontend_sws/services/entity/Area.dart';
import 'package:frontend_sws/components/filtri/FilterBar.dart';

import '../../components/CustomAppBar.dart';
import '../../components/CustomFloatingButton.dart';

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
  late List<FilterTextController> _inputFilter;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _inputFilter = <FilterTextController>[
      FilterTextController(textPlaceholder: 'Nome',
          f: _executeSearch),
    ];
    super.initState();
  }

  void _executeSearch(String text) {
    print(text);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
      await areeService.areeList(null);

        _pagingController.appendLastPage(newItems!);

    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
    for (var el in _inputFilter) {el.dispose();}
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
                        builder: (context) => GestioneArea(null))).then((value) => _pullRefresh());
              }
            }),
        appBar: const CustomAppBar(title: "Gestione Aree"),
        body: RefreshIndicator(
            onRefresh: _pullRefresh,
            child: Column(
                children: <Widget>[
                  FilterBar(
                      controllers: _inputFilter
                  ),
                  PagedListView<int, Area>(
                    shrinkWrap: true,
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
                                        GestioneArea(item.id))
                            ).then((v) => _pullRefresh())
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
                ]
            )
        )
    );
  }

  Future<void> _pullRefresh() async {
    _pagingController.refresh();
  }
}
