import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moody_pomodoro/data/timer_state.dart';
import 'package:moody_pomodoro/notifiers/timer_notifier.dart';
import 'package:moody_pomodoro/widgets/timer_dial.dart';

class TimerWidget extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final type = ref.watch(timerNotifier.select((state) => state.type));
    final nextType = ref.watch(timerNotifier.select((state) => state.nextType));
    final isRunning =
        ref.watch(timerNotifier.select((state) => state.isRunning));
    final showNextButton =
        ref.watch(timerNotifier.select((state) => state.showNextButton));
    return Container(
      width: 240,
      height: 240,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: type.color,
          width: 2,
        ),
      ),
      alignment: Alignment.center,
      child: Stack(
        children: [
          const Center(
            child: TimerDial(),
          ),
          Align(
            alignment: Alignment(0, -0.75),
            child: Icon(
              type.icon,
              size: 36,
              color: type.color,
            ),
          ),
          if (!isRunning)
            Align(
              alignment: Alignment(0, 0.75),
              child: IconButton(
                icon: Icon(Icons.play_arrow),
                iconSize: 36,
                onPressed: () {
                  ref.read(timerNotifier.notifier).resume();
                },
              ),
            )
          else if (showNextButton)
            Align(
              alignment: Alignment(0, 0.75),
              child: IconButton(
                icon: Icon(nextType.icon),
                iconSize: 36,
                onPressed: () {
                  ref.read(timerNotifier.notifier).next();
                },
              ),
            ),
        ],
      ),
    );
  }
}
