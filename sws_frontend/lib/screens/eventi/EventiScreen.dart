import 'package:flutter/material.dart';
import 'package:frontend_sws/components/eventi/CardEvento.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import '../../components/filtri/DropDownFilter.dart';
import '../../components/filtri/FilterBar.dart';
import '../../components/filtri/GenericFilter.dart';
import '../../components/filtri/TextFilter.dart';
import '../../components/generali/CustomPagedListView.dart';
import '../../services/AreeService.dart';
import '../../services/EventoService.dart';
import '../../services/entity/Area.dart';
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
  String? filterNome, filterArea;
  DateTimeRange? _selectedDateRange;

  AreeService areeService = AreeService();
  List<Area>? listAree;
  List<DropDownFilterItem> itemsAree = [];
  String? dropdownValueArea;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    initAree = loadListAree();
  }

  late Future<List<DropDownFilterItem>> initAree;

  Future<List<DropDownFilterItem>> loadListAree() async {
    listAree = await areeService.areeList(null);
    itemsAree.add(DropDownFilterItem(
      id: "",
      name: "",
    ));
    if (listAree != null) {
      itemsAree.addAll(listAree!.map<DropDownFilterItem>((Area value) {
        return DropDownFilterItem(
          id: value.id,
          name: value.nome,
        );
      }).toList());
      dropdownValueArea = listAree!.first.id;
    }
    return itemsAree;
  }

  void _showDatePicker() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      locale: const Locale('it'),
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'SALVA SCELTA',
    );

    if (result != null) {
      String formattedStartDate = DateFormat('yyyy-MM-dd').format(result.start);
      String formattedEndDate = DateFormat('yyyy-MM-dd').format(result.end);
      DateTimeRange formattedResult = DateTimeRange(
          start: DateTime.parse(formattedStartDate),
          end: DateTime.parse(formattedEndDate));
      setState(() {
        _selectedDateRange = formattedResult;
      });
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await eventoService.eventiList(
          filterNome, filterArea, null, pageKey, false);
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

  Future<void> _pullRefresh() async {
    _pagingController.refresh();
  }

  void _filterNomeChange(String? text) {
    filterNome = text;
    _pullRefresh();
    setState(() {});
  }

  void _filterAreaChange(String? text) {
    filterArea = text;
    _pullRefresh();
    setState(() {});
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
          preferredSize: Size.fromHeight(widget.isFilterOpen ? 180 : 0),
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
                      DropDownFilter(
                          name: "Seleziona Area",
                          positionType: GenericFilterPositionType.row,
                          valueChange: _filterAreaChange,
                          values: itemsAree),
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
                          // DateFormat('yyyy-MM-dd').format(pickedDate)
                          : Text(
                              "Dal ${_selectedDateRange?.start.toString().split(' ')[0]} al ${_selectedDateRange?.end.toString().split(' ')[0]}",
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
              child:  CustomPagedListView<Evento>(
                    pagingController: _pagingController,

                    itemBuilder: (context, item, index) => CardEvento(
                          idEvento: item.id!,
                          nomeEvento: item.nome,
                          contenuto: item.contenuto,
                          luogo: 'Salerno (SA)',
                        )),
              ),

          ])),
    );
  }

  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => throw UnimplementedError();
}
