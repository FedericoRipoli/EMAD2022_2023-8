import 'package:flutter/material.dart';
import 'package:frontend_sws/main.dart';
import 'package:settings_ui/settings_ui.dart';

class Options extends StatelessWidget {
  const Options({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: appTheme.primaryColor,
          ),
          iconSize: 28,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Impostazioni App',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: appTheme.primaryColor),
        ),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Generali'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text('Lingua'),
                value: Text('Italiano'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                initialValue: true,
                leading: Icon(Icons.format_paint),
                title: Text('Enable custom theme'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
