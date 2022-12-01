import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend_sws/services/AreeService.dart';
import 'package:frontend_sws/services/entity/Area.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:frontend_sws/main.dart';
import 'package:getwidget/getwidget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../components/AllPageLoadTransparent.dart';
import '../../components/CustomAppBar.dart';
import '../../components/CustomFloatingButton.dart';
import '../../components/menu/DrawerMenu.dart';
import '../../services/dto/SignupDTO.dart';
import '../../util/ToastUtil.dart';

class GestioneArea extends StatefulWidget {
  String? idArea;
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.GestioneArea';

  GestioneArea(this.idArea, {super.key});

  @override
  State<StatefulWidget> createState() => _GestioneArea();
}

class _GestioneArea extends State<GestioneArea> {
  late Future<bool> initCall;
  AreeService areeService = AreeService();

  Area? area;
  final GlobalKey<ScaffoldState> _scaffoldKeyAdmin = GlobalKey<ScaffoldState>();
  TextEditingController nomeController = TextEditingController();
  bool loaded = false;
  final _formGlobalKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    initCall = load();
  }

  Future<bool> load() async {

    area = widget.idArea != null
        ? await areeService.getArea(widget.idArea!)
        : null;
    if (area != null) {

      nomeController.text = (area!.nome);
    }
    setState(() {
      loaded = true;
    });
    return true;
  }

  void savePage() async {
    if(_formGlobalKey.currentState!.validate()){
      _formGlobalKey.currentState?.save();
      setState(() {
        loaded = false;
      });
      Area? nArea;
      if (widget.idArea == null) {
        nArea = await areeService.createArea(Area(
            nome: nomeController.value.text));

      } else {
        area!.nome=nomeController.value.text;
        nArea = await areeService.editArea(area!);
      }
      if (mounted) {}
      if (nArea != null) {
        Navigator.of(context).pop();
        ToastUtil.success(
            "Area ${widget.idArea==null?'aggiunta':'modificata'}",
            context
        );

      } else {
        ToastUtil.error(
            "Errore server",
            context
        );

      }
      setState(() {
        loaded = true;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKeyAdmin,
        resizeToAvoidBottomInset: false,


        drawer: DrawerMenu(currentPage: GestioneArea.id),
        floatingActionButton: !loaded
            ? null
            : CustomFloatingButton(
          iconData: Icons.save_rounded,
          onPressed:  () => savePage(),
        ),
        appBar: CustomAppBar(title:"Gestione Area",
            iconData:Icons.arrow_back,
            onPressed:()=>Navigator.pop(context)),





        body: FutureBuilder<bool>(
            future: initCall,
            builder: ((context, snapshot) {
              List<Widget> children = [];

              if (!snapshot.hasData && !snapshot.hasError || !loaded) {
                children.add(const AllPageLoadTransparent());
              }
              List<Widget> columnChild = [];
              columnChild.add(
                  Form(
                      key: _formGlobalKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 80,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            child: TextFormField(
                              validator: (v) {
                                if(v==null || v.isEmpty) {
                                  return "Inserisci il campo nome";
                                }
                              },
                              controller: nomeController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                              ),
                            ),
                          )
                        ],
                      )
                  )



              );

              children.add(Column(
                children: columnChild,
              ));
              return AbsorbPointer(
                absorbing: !(snapshot.hasData || snapshot.hasError),
                child: Stack(
                  children: children,
                ),
              );
            })));
  }
}
