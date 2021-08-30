import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moody_pomodoro/app.dart';
import 'package:moody_pomodoro/notifiers/timer_notifier.dart';
import 'package:moody_pomodoro/widgets/timer_widget.dart';

class TimerPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 24,
            right: 24,
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                ref.read(showSettings).state = true;
              },
            ),
          ),
          Center(child: TimerWidget()),
          Positioned(
            bottom: 24,
            right: 24,
            child: IconButton(
              icon: Icon(Icons.hotel),
              onPressed: () {
                ref.read(timerNotifier.notifier)
                  ..setShortBreaking()
                  ..start();
              },
            ),
          ),
        ],
      ),
    );
  }
}
