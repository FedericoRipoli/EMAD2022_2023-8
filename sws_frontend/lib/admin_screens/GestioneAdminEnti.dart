import 'package:flutter/material.dart';
import 'package:frontend_sws/components/DrawerMenu.dart';
import 'package:getwidget/getwidget.dart';
import 'package:frontend_sws/main.dart';

class GestioneAdminEnti extends StatefulWidget {
  const GestioneAdminEnti({Key? key}) : super(key: key);

  @override
  State<GestioneAdminEnti> createState() => _GestioneAdminEntiState();
}

GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();

class _GestioneAdminEntiState extends State<GestioneAdminEnti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyAdmin,
      drawer: const DrawerMenu(),
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
          child: Icon(
            Icons.add,
            size: 32,
            color: Colors.white,
          )),
      appBar: GFAppBar(
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
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ListView(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(8),
            children: const <Widget>[
              GFListTile(
                padding: EdgeInsets.all(4),
                avatar: GFAvatar(
                  shape: GFAvatarShape.standard,
                ),
                titleText: 'Nome Admin Ente',
                subTitleText: 'Nome Ente',
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          )),
    );
  }
}
