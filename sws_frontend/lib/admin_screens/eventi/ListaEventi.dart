import 'package:flutter/material.dart';
import 'package:frontend_sws/services/EventoService.dart';
import 'package:frontend_sws/services/UserService.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../components/eventi/EventoListItem.dart';
import '../../components/filtri/DropDownFilter.dart';
import '../../components/filtri/FilterBar.dart';
import '../../components/filtri/GenericFilter.dart';
import '../../components/filtri/TextFilter.dart';
import '../../components/generali/CustomAppBar.dart';
import '../../components/generali/CustomFloatingButton.dart';
import '../../components/menu/DrawerMenu.dart';
import '../../services/entity/Evento.dart';
import '../../theme/theme.dart';
import '../../util/ToastUtil.dart';
import 'GestioneEvento.dart';

class ListaEventi extends StatefulWidget {
  const ListaEventi({Key? key}) : super(key: key);
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.ListaEventi';

  @override
  State<ListaEventi> createState() => _ListaEventiState();
}

class _ListaEventiState extends State<ListaEventi> {
  EventoService eventoService = EventoService();
  List<DropDownFilterItem> itemsFilterStato = [];
  UserService userService = UserService();
  final PagingController<int, Evento> _pagingController =
      PagingController(firstPageKey: 0);
  String? filterNome;
  String? filterStato;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    itemsFilterStato.add(DropDownFilterItem(name: "Tutti"));

    itemsFilterStato.addAll(Evento.getStatiList()
        .entries
        .map((e) => DropDownFilterItem(name: e.value, id: e.key))
        .toList());

    super.initState();
  }

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
      final newItems = await eventoService.eventiList(
          filterNome, null, filterStato, pageKey, true);
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
        drawer: DrawerMenu(currentPage: ListaEventi.id),
        resizeToAvoidBottomInset: false,
        floatingActionButton: CustomFloatingButton(
            iconData: Icons.add,
            onPressed: () {
              if (mounted) {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                GestioneEvento(idEvento: null)))
                    .then((value) => _pullRefresh());
              }
            }),
        appBar: const CustomAppBar(title: AppTitle(label: "Gestione Eventi")),
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
                child: PagedListView<int, Evento>(
                  shrinkWrap: false,
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Evento>(
                      itemBuilder: (context, item, index) => EventoListItem(
                            name: item.nome,
                            id: item.id!,
                            //statoOperazione: item.stato!,
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GestioneEvento(
                                            idEvento: item.id!,
                                          ))).then((v) => _pullRefresh())
                            },
                            onDelete: () {
                              eventoService
                                  .deleteEvento(item.id!)
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
              )
            ])));
  }

  Future<void> _pullRefresh() async {
    _pagingController.refresh();
  }
}
