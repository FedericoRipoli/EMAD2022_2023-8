import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:frontend_sws/services/AreeService.dart';
import 'package:frontend_sws/services/entity/Area.dart';
import '../../components/loading/AllPageLoadTransparent.dart';
import '../../components/generali/CustomAppBar.dart';
import '../../components/generali/CustomFloatingButton.dart';
import '../../components/menu/DrawerMenu.dart';
import '../../theme/theme.dart';
import '../../util/ToastUtil.dart';
import '../../util/ColorExtension.dart';

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

  Icon? _icon;
  Color pickerColor = AppColors.logoBlue;
  bool iconError = false;

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);

    _icon = Icon(icon);
    setState(() {});
  }

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
      if (area!.icon != null) {
        _icon =
            Icon(IconData(int.parse(area!.icon!), fontFamily: "MaterialIcons"));
      }

      if (area!.color != null) {
        pickerColor = ColorExtension.fromHex(area!.color!);
      }
    }
    setState(() {
      loaded = true;
    });
    return true;
  }

  void savePage() async {
    iconError = false;

    if (_formGlobalKey.currentState!.validate()) {
      if (_icon == null) {
        iconError = true;
        setState(() {});
        return;
      }
      _formGlobalKey.currentState?.save();
      setState(() {
        loaded = false;
      });
      Area? nArea;

      if (widget.idArea == null) {
        nArea = await areeService.createArea(Area(
            nome: nomeController.value.text,
            icon: _icon!.icon!.codePoint.toString(),
            color: pickerColor.value.toRadixString(16)));
      } else {
        area!.nome = nomeController.value.text;
        area!.icon = _icon!.icon!.codePoint.toString();
        area!.color = pickerColor.value.toRadixString(16);
        nArea = await areeService.editArea(area!);
      }
      if (mounted) {}
      if (nArea != null) {
        Navigator.of(context).pop();
        ToastUtil.success(
            "Area ${widget.idArea == null ? 'aggiunta' : 'modificata'}",
            context);
      } else {
        ToastUtil.error("Errore server", context);
      }
      setState(() {
        loaded = true;
      });
    }
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
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
                onPressed: () => savePage(),
              ),
        appBar: CustomAppBar(
            title: const AppTitle(label: "Gestione Area"),
            iconData: Icons.arrow_back,
            onPressed: () => Navigator.pop(context)),
        body: FutureBuilder<bool>(
            future: initCall,
            builder: ((context, snapshot) {
              List<Widget> children = [];

              if (!snapshot.hasData && !snapshot.hasError || !loaded) {
                children.add(const AllPageLoadTransparent());
              }
              List<Widget> columnChild = [];
              columnChild.add(Form(
                  key: _formGlobalKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        TextFormField(
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return "Inserisci il campo nome";
                            }
                          },
                          controller: nomeController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nome',
                          ),
                        ),
                        if (loaded)
                          Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              iconError
                                  ? const Text(
                                      "Seleziona un colore per il marker mappa",
                                      style: TextStyle(color: Colors.red))
                                  : Container(),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: _pickIcon,
                                    child: const Text('Seleziona l\'icona'),
                                  ),
                                  const SizedBox(width: 30),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    child: _icon ?? Container(),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                  "Seleziona un colore per il marker mappa"),
                              BlockPicker(
                                pickerColor: pickerColor,
                                onColorChanged: changeColor,
                                availableColors: const [
                                  AppColors.logoBlue,
                                  AppColors.logoRed,
                                  AppColors.logoCyan,
                                  AppColors.darkBlue,
                                  AppColors.grayPurple,
                                  AppColors.ice,
                                  AppColors.logoCadmiumOrange,
                                  AppColors.logoYellow,
                                  AppColors.primaryBlue,
                                  Colors.pink,
                                  Colors.red,
                                  Colors.green
                                ],
                              )
                            ],
                          )
                      ],
                    ),
                  )));

              children.add(SingleChildScrollView(
                  child: Column(
                children: columnChild,
              )));
              return AbsorbPointer(
                absorbing: !(snapshot.hasData || snapshot.hasError),
                child: Stack(
                  children: children,
                ),
              );
            })));
  }
}
