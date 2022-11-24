import 'package:flutter/material.dart';
import 'package:frontend_sws/components/menu/DrawerMenu.dart';
import 'package:frontend_sws/services/EnteService.dart';
import 'package:getwidget/getwidget.dart';
import 'package:frontend_sws/main.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:frontend_sws/services/entity/Ente.dart';

import '../../components/enti/EnteListItem.dart';




class ListaEnti extends StatefulWidget  {

  const ListaEnti({Key? key}) : super(key: key);
  static String id='it.unisa.emad.comunesalerno.sws.ipageutil.ListaEnti';

  @override
  State<ListaEnti> createState() => _ListaEntiState();



}


class _ListaEntiState extends State<ListaEnti> {
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();
  EnteService enteService=EnteService();
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
      final newItems= await enteService.enteList(null, pageKey);

      final isLastPage = newItems==null || newItems.isEmpty;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems!);
      } else {
        pageKey ++;
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
        floatingActionButton: FloatingActionButton(
            elevation: 3,
            hoverElevation: 1,
            onPressed: () {
              if (mounted) {
                // open add modal
              }
            },
            backgroundColor: appTheme.primaryColor,
            child: const Icon(
              Icons.add,
              size: 32,
              color: Colors.white,
            )),
        appBar: GFAppBar(title: const Text("Enti"),
          leading: GFIconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              _scaffoldKeyAdmin.currentState?.openDrawer();
            },
            type: GFButtonType.transparent,
          ),
          searchBar: false,
          elevation: 0,
          backgroundColor: appTheme.primaryColor,
        ),
        body:
        RefreshIndicator(
          onRefresh: _pullRefresh,
          child: PagedListView<int, Ente>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Ente>(
                itemBuilder: (context, item, index) => EnteListItem(
                    denominazione:item.denominazione,
                    id:item.id!,
                    onTap:()=>{}
                )
            ),
          )
        )


    );
  }
  Future<void> _pullRefresh() async {
    _pagingController.refresh();
  }
}
