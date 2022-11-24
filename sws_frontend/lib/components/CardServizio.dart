import 'package:flutter/material.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:getwidget/getwidget.dart';
import 'Chips.dart';

class CardServizio extends StatelessWidget {
  final String title, subtitle, ambito, tipologia, tags;
  final String? descrizione, contenuto;
  final Stato? state;
  //final Widget toShow;
  const CardServizio(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.ambito,
      required this.tipologia,
      required this.tags,
      this.descrizione,
      this.contenuto,
      this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFCard(
      height: 300,
      boxFit: BoxFit.scaleDown,
      titlePosition: GFPosition.start,
      showOverlayImage: false,
      color: AppColors.white,
      elevation: 20,
      title: GFListTile(
        color: AppColors.white,
        margin: const EdgeInsets.all(1.5),
        avatar: const GFAvatar(
          shape: GFAvatarShape.standard,
          backgroundColor: AppColors.logoBlue,
          child: Icon(Icons.account_circle),
        ),
        titleText: title,
        subTitleText: subtitle,
        //description: Text(descrizione!),
      ),
      //content: Text(contenuto!),
      buttonBar: GFButtonBar(
        spacing: 3.0,
        direction: Axis.horizontal,
        children: <Widget>[
          ChipGenerale(label: ambito, icon: Icons.accessibility_new_outlined),
          ChipGenerale(label: tipologia, icon: Icons.type_specimen),
          ChipGenerale(label: tags, icon: Icons.tag_sharp),
          const ChipState(state: Stato.ANNULLATO),
        ],
      ),
    );
  }
}
