import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moody_pomodoro/widgets/minutes_slider.dart';

class SettingsPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          MinutesSlider(title: "Pomodoro time", minutes: 25),
          MinutesSlider(title: "Short breaking time", minutes: 5),
        ],
      ),
    );
  }
}
