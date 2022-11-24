import 'package:flutter/material.dart';
import 'package:frontend_sws/admin_screens/utenti/GestioneUtente.dart';
import 'package:frontend_sws/components/menu/DrawerMenu.dart';
import 'package:frontend_sws/services/EnteService.dart';
import 'package:frontend_sws/services/entity/Ente.dart';
import 'package:getwidget/getwidget.dart';
import 'package:frontend_sws/main.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:frontend_sws/services/UtenteService.dart';
import 'package:frontend_sws/services/entity/Utente.dart';
import 'package:frontend_sws/components/utenti/UtenteListItem.dart';


class ListaUtenti extends StatefulWidget  {

  const ListaUtenti({Key? key}) : super(key: key);
  static String id='it.unisa.emad.comunesalerno.sws.ipageutil.GestioneEnti';

  @override
  State<ListaUtenti> createState() => _ListaUtentiState();



}


class _ListaUtentiState extends State<ListaUtenti> {
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();
  UtenteService utenteService=UtenteService();
  final PagingController<int, Utente> _pagingController =
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
      final newItems= await utenteService.usersList(null,null,null, pageKey);
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
        drawer: DrawerMenu(currentPage: ListaUtenti.id),
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
        appBar: GFAppBar(title: const Text("Utenti"),
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
          child: PagedListView<int, Utente>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Utente>(
                itemBuilder: (context, item, index) => UtenteListItem(
                    name:item.username,
                    id:item.id!,
                    ente:item.ente,
                    onTap:()=>{
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GestioneUtente(item.id)))
                    }
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
