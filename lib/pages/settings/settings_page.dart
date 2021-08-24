import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: 'Time',
            tiles: [
              SettingsTile(
                title: 'Focus time',
                subtitle: '25:00',
              ),
              SettingsTile(
                title: 'Break time',
                subtitle: '05:00',
              ),
            ],
          )
        ],
      ),
    );
  }
}
