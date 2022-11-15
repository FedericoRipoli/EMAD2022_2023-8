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
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: appTheme.primaryColor),
        ),
      ),
      body: SettingsList(
        applicationType: ApplicationType.both,
        sections: [
          SettingsSection(
            title: Text(
              'Generali',
              style: TextStyle(fontSize: 22, color: appTheme.primaryColor),
            ),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: const Text('Lingua'),
                value: const Text('Italiano'),
              ),
              SettingsTile.switchTile(
                activeSwitchColor: appTheme.primaryColor,
                onToggle: (value) {},
                initialValue: true,
                leading: const Icon(Icons.format_paint),
                title: const Text('Enable custom theme'),
              ),
            ],
          ),
          SettingsSection(
            title: Text('Accessibilità',
                style: TextStyle(fontSize: 22, color: appTheme.primaryColor)),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: const Text('Lingua'),
                value: const Text('Italiano'),
              ),
              SettingsTile.switchTile(
                activeSwitchColor: appTheme.primaryColor,
                onToggle: (value) {},
                initialValue: true,
                leading: const Icon(Icons.format_paint),
                title: const Text('Enable custom theme'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
