import 'package:flutter/material.dart';
import 'package:frontend_sws/components/menu/DrawerMenu.dart';
import 'package:frontend_sws/services/StrutturaService.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../services/entity/Struttura.dart';
import '../../../components/CustomAppBar.dart';
import '../../../components/CustomFloatingButton.dart';
import '../../../components/enti/struttura/StrutturaListItem.dart';
import '../../../util/ToastUtil.dart';
import 'GestioneStruttura.dart';

class ListaStrutture extends StatefulWidget {
  final String idEnte;

  const ListaStrutture({Key? key, required this.idEnte}) : super(key: key);
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.ListaStrutture';

  @override
  State<ListaStrutture> createState() => _ListaStruttureState();
}

class _ListaStruttureState extends State<ListaStrutture> {
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();
  StrutturaService strutturaService = StrutturaService();
  final PagingController<int, Struttura> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  void _executeSearch(String text) {
    print(text);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await strutturaService.struttureList(widget.idEnte);

      _pagingController.appendLastPage(newItems!);
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
        drawer: DrawerMenu(currentPage: ListaStrutture.id),
        resizeToAvoidBottomInset: false,
        floatingActionButton: CustomFloatingButton(
          iconData: Icons.add,
          onPressed: () {
            if (mounted) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          GestioneStruttura(idEnte: widget.idEnte))).then((v) => _pullRefresh());
            }
          },
        ),
        appBar: CustomAppBar(title:"Lista Strutture",
            iconData:Icons.arrow_back,
            onPressed:()=>Navigator.pop(context)),
        body: RefreshIndicator(
            onRefresh: _pullRefresh,
            child: Column(children: <Widget>[
              Flexible(
                  child: PagedListView<int, Struttura>(
                scrollDirection: Axis.vertical,
                shrinkWrap: false,
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Struttura>(
                    itemBuilder: (context, item, index) => StrutturaListItem(
                        denominazione: item.denominazione!,
                        id: item.id!,
                        onDelete: () {
                          strutturaService.deleteStruttura(item.id!).then((value) {
                            if (value) {
                              ToastUtil.success("Struttura eliminata", context);
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
                                      builder: (context) => GestioneStruttura(
                                          idStruttura: item.id,
                                          idEnte: widget.idEnte))).then((v) => _pullRefresh())
                            })),
              ))
            ])));
  }

  Future<void> _pullRefresh() async {
    _pagingController.refresh();
  }
}
