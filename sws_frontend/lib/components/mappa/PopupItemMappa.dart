import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:frontend_sws/theme/theme.dart';

class PopupItemMappa extends StatelessWidget {
  final VoidCallback onTap;
  final String nome;
  final String ente;
  final String struttura;
  final String indirizzo;
  final IconData? customIcon;

  const PopupItemMappa(
      {Key? key,
      required this.onTap,
      required this.nome,
      required this.ente,
      required this.struttura,
      required this.indirizzo,
      this.customIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: onTap,
          child: Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ListTile(
                  leading: Icon(
                    customIcon ?? Icons.account_balance_outlined,
                    color: AppColors.logoCadmiumOrange,
                  ),
                  title: Text(nome),
                  subtitle: Text(struttura),
                  trailing: const Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.logoCadmiumOrange,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
