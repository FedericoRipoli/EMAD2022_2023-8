import 'package:flutter/material.dart';
import 'package:frontend_sws/components/eventi/CardEvento.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../components/filtri/FilterBar.dart';
import '../../components/filtri/GenericFilter.dart';
import '../../components/filtri/TextFilter.dart';
import '../../services/EventoService.dart';
import '../../services/entity/Evento.dart';
import '../../theme/theme.dart';

class EventiScreen extends StatefulWidget {
  bool isFilterOpen = true;
  TextEditingController filtroNomeController = TextEditingController();

  EventiScreen({Key? key}) : super(key: key);

  @override
  State<EventiScreen> createState() => _EventiScreenState();
}

class _EventiScreenState extends State<EventiScreen>
    with TickerProviderStateMixin {
  final PagingController<int, Evento> _pagingController =
      PagingController(firstPageKey: 0);
  EventoService eventoService = EventoService();
  String? filterNome;
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  void _showDatePicker() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'Date scelte',
    );

    if (result != null) {
      print(result.start.toString());
      setState(() {
        _selectedDateRange = result;
      });
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          await eventoService.eventiList(filterNome, pageKey, false);
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

  void _filterNomeChange(String? text) {
    filterNome = text;
    _pullRefresh();
    setState(() {});
  }

  Future<void> _pullRefresh() async {
    _pagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: GFAppBar(
        centerTitle: true,
        backgroundColor: AppColors.logoBlue,
        brightness: Brightness.dark,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        automaticallyImplyLeading: true,
        title: const AppTitle(label: "Eventi"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(widget.isFilterOpen ? 130 : 0),
          child: widget.isFilterOpen
              ? Container(
                  child: Column(
                  children: [
                    FilterBar(filters: [
                      TextFilter(
                          name: 'Cerca un evento...',
                          textEditingController: widget.filtroNomeController,
                          positionType: GenericFilterPositionType.col,
                          valueChange: _filterNomeChange),
                    ]),
                    Container(
                      margin: const EdgeInsets.all(6),
                      child: _selectedDateRange == null
                          ? Wrap(
                              children: [
                                const Icon(
                                  Icons.date_range,
                                  color: AppColors.white,
                                ),
                                TextButton(
                                    onPressed: _showDatePicker,
                                    child: const Text(
                                      "SELEZIONA RANGE DI DATE",
                                      style: TextStyle(color: AppColors.white),
                                    ))
                              ],
                            )
                          : Text(
                              "DAL ${_selectedDateRange?.start.toString().split(' ')[0]} AL ${_selectedDateRange?.end.toString().split(' ')[0]}",
                              style: const TextStyle(
                                  color: AppColors.white, fontSize: 16),
                            ),
                    ),
                  ],
                ))
              : Container(),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  widget.isFilterOpen = !widget.isFilterOpen;
                });
              },
              icon: Icon(
                widget.isFilterOpen
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down,
                color: AppColors.white,
              ))
        ],
      ),
      body: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: Column(children: <Widget>[
            Flexible(
              child: PagedListView<int, Evento>(
                shrinkWrap: false,
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Evento>(
                    itemBuilder: (context, item, index) => CardEvento(
                          idEvento: item.id!,
                          nomeEvento: item.nome,
                          contenuto: item.contenuto,
                          luogo: 'Salerno (SA)',
                        )),
              ),
            )
          ])),
    );
  }
}
