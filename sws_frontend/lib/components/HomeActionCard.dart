import 'package:flutter/material.dart';
import 'package:frontend_sws/theme/theme.dart';
import 'package:getwidget/getwidget.dart';
import 'package:frontend_sws/components/CustomButton.dart';
import '../screens/SearchScreen.dart';

class HomeActionCard extends StatefulWidget {
  final String titolo, descrizione, buttonLabel, subtitolo;
  final IconData icon;
  const HomeActionCard(
      {Key? key,
      required this.titolo,
      required this.descrizione,
      required this.buttonLabel,
      required this.icon,
      required this.subtitolo})
      : super(key: key);

  @override
  State<HomeActionCard> createState() => _HomeActionCardState();
}

class _HomeActionCardState extends State<HomeActionCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 20,
      borderRadius: const BorderRadius.all(Radius.circular(40)),
      child: Container(
        height: 315,
        width: 350,
        decoration: const BoxDecoration(
          color: AppColors.ice,
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: Center(
          child: GFCard(
            boxFit: BoxFit.fitHeight,
            color: AppColors.ice,
            elevation: 0,
            title: GFListTile(
              avatar: Icon(
                widget.icon,
                size: 42,
                color: AppColors.logoCadmiumOrange,
              ),
              title: Text(
                widget.titolo,
                style: const TextStyle(
                    fontSize: 22,
                    color: AppColors.logoBlue,
                    fontWeight: FontWeight.bold),
              ),
              subTitle: Text(
                widget.subtitolo,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.black,
                ),
              ),
            ),
            titlePosition: GFPosition.start,
            content: Center(
              child: Text(
                widget.descrizione,
                style: const TextStyle(
                  fontSize: 14,
                  letterSpacing: 1.1,
                  color: AppColors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            buttonBar: GFButtonBar(
              children: <Widget>[
                CustomButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const SearchScreen(typeSearch: true)),
                    );
                  },
                  textButton: "Visualizza ${widget.buttonLabel}",
                  status: true,
                  icon: Icons.keyboard_arrow_right_outlined,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
