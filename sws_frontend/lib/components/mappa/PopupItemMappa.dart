import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:frontend_sws/theme/theme.dart';

class PopupItemMappa extends StatelessWidget {
  final VoidCallback onTap;
  final String nome;
  final String ente;
  final String indirizzo;

  const PopupItemMappa(
      {Key? key,
      required this.onTap,
      required this.nome,
      required this.ente,
      required this.indirizzo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               ListTile(
                leading: const Icon(Icons.account_balance_outlined),
                title: Text(nome),
                subtitle: Text(ente),
              )
            ],
          ),
        ),
      ),
    );
  }
}
