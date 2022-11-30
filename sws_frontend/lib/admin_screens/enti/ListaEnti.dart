import 'package:flutter/material.dart';
import 'package:frontend_sws/components/menu/DrawerMenu.dart';
import 'package:frontend_sws/services/EnteService.dart';
import 'package:getwidget/getwidget.dart';
import 'package:frontend_sws/main.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:frontend_sws/services/entity/Ente.dart';

import '../../components/CustomAppBar.dart';
import '../../components/CustomFloatingButton.dart';
import '../../components/enti/EnteListItem.dart';
import '../../theme/theme.dart';
import 'GestioneEnte.dart';

class ListaEnti extends StatefulWidget {
  const ListaEnti({Key? key}) : super(key: key);
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.ListaEnti';

  @override
  State<ListaEnti> createState() => _ListaEntiState();
}

class _ListaEntiState extends State<ListaEnti> {
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

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await enteService.enteList(null, pageKey);

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
        drawer: DrawerMenu(currentPage: ListaEnti.id),
        resizeToAvoidBottomInset: false,
        floatingActionButton: CustomFloatingButton(
          iconData: Icons.add,
          onPressed: () {
            if (mounted) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GestioneEnte(null)));
            }
          },
        ),

        /*FloatingActionButton(
            elevation: 3,
            hoverElevation: 1,
            onPressed: () {
              if (mounted) {
                Navigator.push(context, MaterialPageRoute(builder:
                    (context) => GestioneEnte(null)
                ));
              }
            },
            backgroundColor: appTheme.primaryColor,
            child: const Icon(
              Icons.add,
              size: 32,
              color: Colors.white,
            )),*/
        appBar: const CustomAppBar(title: "Gestione Enti"),

        body: RefreshIndicator(
            onRefresh: _pullRefresh,
            child: PagedListView<int, Ente>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Ente>(
                  itemBuilder: (context, item, index) => EnteListItem(
                      denominazione: item.denominazione,
                      id: item.id!,
                      onTap: () => {
                            /*
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => GestioneEnte(item.id)
                      ))
                      */
                          })),
            )));
  }

  Future<void> _pullRefresh() async {
    _pagingController.refresh();
  }
}
