import 'package:flutter/material.dart';
import 'package:frontend_sws/admin_screens/utenti/GestioneUtente.dart';
import 'package:frontend_sws/components/menu/DrawerMenu.dart';
import 'package:frontend_sws/components/utenti/UtenteListItem.dart';
import 'package:frontend_sws/util/ToastUtil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:frontend_sws/services/UtenteService.dart';
import 'package:frontend_sws/services/entity/Utente.dart';
import 'package:frontend_sws/components/filtri/FilterBar.dart';

import '../../components/filtri/DropDownFilter.dart';
import '../../components/filtri/GenericFilter.dart';
import '../../components/filtri/TextFilter.dart';
import '../../components/generali/CustomAppBar.dart';
import '../../components/generali/CustomFloatingButton.dart';

class ListaUtenti extends StatefulWidget {
  const ListaUtenti({Key? key}) : super(key: key);
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.ListaUtenti';

  @override
  State<ListaUtenti> createState() => _ListaUtentiState();
}

class _ListaUtentiState extends State<ListaUtenti> {
  UtenteService utenteService = UtenteService();
  final PagingController<int, Utente> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  void _filterEnteChange(String? text) {
    filterEnte=text;
    _pullRefresh();
  }
  void _filterUtenteChange(String? text) {
    filterUtente=text;
    _pullRefresh();
  }

  String? filterEnte;
  String? filterUtente;
  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          await utenteService.usersList(filterUtente, filterEnte, false, pageKey);
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
        drawer: DrawerMenu(currentPage: ListaUtenti.id),
        resizeToAvoidBottomInset: false,
        floatingActionButton: CustomFloatingButton(
            iconData: Icons.add,
            onPressed: () {
              if (mounted) {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GestioneUtente(null)))
                    .then((value) => _pullRefresh());
              }
            }),
        appBar: const CustomAppBar(title: "Gestione Utenti"),
        body: RefreshIndicator(
            onRefresh: _pullRefresh,
            child: Column(children: <Widget>[
              FilterBar(filters: [
                TextFilter(name: 'Ente', positionType: GenericFilterPositionType.row, valueChange: _filterEnteChange),
                TextFilter(name: 'Utente', positionType: GenericFilterPositionType.row, valueChange: _filterUtenteChange),

              ]),

              Flexible(
                child: PagedListView<int, Utente>(
                  shrinkWrap: false,
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Utente>(
                      itemBuilder: (context, item, index) => UtenteListItem(
                            name: item.username,
                            id: item.id!,
                            ente: item.nomeEnte,
                            onTap: () => {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              GestioneUtente(item.id)))
                                  .then((v) => _pullRefresh())
                            },
                            onDelete: () {
                              utenteService
                                  .deleteUtente(item.id!)
                                  .then((value) {
                                if (value) {
                                  ToastUtil.success(
                                      "Utente eliminato", context);
                                } else {
                                  ToastUtil.error("Errore server", context);
                                }
                                _pullRefresh();
                              });
                            },
                          )),
                ),
              )
            ])));
  }

  Future<void> _pullRefresh() async {
    _pagingController.refresh();
  }
}
