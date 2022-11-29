import 'package:flutter/material.dart';
import 'package:frontend_sws/components/menu/DrawerMenu.dart';
import 'package:frontend_sws/services/UserService.dart';
import 'package:frontend_sws/services/ContattoService.dart';
import 'package:getwidget/getwidget.dart';
import 'package:frontend_sws/main.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:frontend_sws/services/entity/Contatto.dart';

import '../../components/CustomAppBar.dart';
import '../../components/contatti/ContattoListItem.dart';




class ListaContatti extends StatefulWidget  {

  const ListaContatti({Key? key}) : super(key: key);
  static String id='it.unisa.emad.comunesalerno.sws.ipageutil.ListaContatti';

  @override
  State<ListaContatti> createState() => _ListaContattiState();



}


class _ListaContattiState extends State<ListaContatti> {
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();
  EnteService enteService=EnteService();
  UserService userService=UserService();
  final PagingController<int, Contatto> _pagingController =
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
      final newItems= await enteService.contattoList(userService.getIdEnte(), pageKey);

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
        drawer: DrawerMenu(currentPage: ListaContatti.id),
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
        appBar: CustomAppBar(title:"Contatti",
            iconData:Icons.menu,
            onPressed:()=>_scaffoldKeyAdmin.currentState?.openDrawer()),
        body:
        RefreshIndicator(
            onRefresh: _pullRefresh,
            child: PagedListView<int, Contatto>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Contatto>(
                  itemBuilder: (context, item, index) => ContattoListItem(
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
