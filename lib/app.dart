import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moody_pomodoro/pages/settings/settings_page.dart';
import 'package:moody_pomodoro/pages/timer_page.dart';
import 'package:window_manager/window_manager.dart';

final showSettings = StateProvider((ref) => false);

class App extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WindowManager.instance.setSize(Size(320, 320));
    }, const []);

    return MaterialApp(
      title: "Moody Pomodoro",
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Navigator(
        pages: [
          MaterialPage(
            key: ValueKey('TimerPage'),
            child: TimerPage(),
          ),
          if (ref.watch(showSettings).state)
            MaterialPage(
              key: ValueKey('SettingsPage'),
              child: SettingsPage(),
            ),
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }

          ref.read(showSettings).state = false;

          return true;
        },
      ),
    );
  }
}
