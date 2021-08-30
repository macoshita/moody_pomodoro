import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moody_pomodoro/app.dart';
import 'package:moody_pomodoro/data/timer_state.dart';
import 'package:moody_pomodoro/notifiers/timer_notifier.dart';
import 'package:moody_pomodoro/widgets/timer_widget.dart';

class TimerPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRunning =
        ref.watch(timerNotifier.select((value) => value.isRunning));
    final isFinished =
        ref.watch(timerNotifier.select((value) => value.isFinished));
    final type = ref.watch(timerNotifier.select((value) => value.type));

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  ref.read(timerNotifier.notifier).pause();
                  ref.read(showSettings).state = true;
                },
              ),
            ),
          ),
          Center(child: TimerWidget()),
          if (!isRunning)
            // タイマーが動いてなかったら再開ボタンを表示
            _BottomBigButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () {
                ref.read(timerNotifier.notifier).resume();
              },
            )
          else if (type == TimerType.pomodoro)
            // ポモドーロ中
            if (isFinished) ...[
              // 完了後なら休憩ボタンを大きめに出し、作業を続けるボタンを控えめに出す
              _BottomBigButton(
                icon: Icon(Icons.hotel),
                onPressed: () {
                  ref.read(timerNotifier.notifier).startShortBreaking();
                },
              ),
              _RightBottomButton(
                icon: Icon(Icons.work),
                onPressed: () {
                  ref.read(timerNotifier.notifier).startPomodoro();
                },
              ),
            ] else
              // 完了前だったら、休憩用のボタンを控えめに出す
              Positioned(
                bottom: 24,
                right: 24,
                child: IconButton(
                  icon: Icon(Icons.hotel),
                  iconSize: 24,
                  onPressed: () {
                    ref.read(timerNotifier.notifier).startShortBreaking();
                  },
                ),
              )
          else if ({TimerType.shortBreaking, TimerType.longBreaking}
              .contains(type))
            // 休憩中
            if (isFinished) ...[
              // 急速完了後ならポモドーロボタンを大きめに出し、追加休みボタンを控えめに出す
              _BottomBigButton(
                icon: Icon(Icons.work),
                onPressed: () {
                  ref.read(timerNotifier.notifier).startPomodoro();
                },
              ),
              _RightBottomButton(
                icon: Icon(Icons.hotel),
                onPressed: () {
                  ref.read(timerNotifier.notifier).startShortBreaking();
                },
              ),
            ] else
              // 完了前だったら、ポモドーロボタンを控えめに出す
              _RightBottomButton(
                icon: Icon(Icons.work),
                onPressed: () {
                  ref.read(timerNotifier.notifier).startPomodoro();
                },
              )
        ],
      ),
    );
  }
}

class _RightBottomButton extends HookConsumerWidget {
  final Widget icon;
  final VoidCallback? onPressed;

  _RightBottomButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: IconButton(
          icon: icon,
          iconSize: 24,
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class _BottomBigButton extends HookConsumerWidget {
  final Widget icon;
  final VoidCallback? onPressed;

  _BottomBigButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: IconButton(
          icon: icon,
          iconSize: 48,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
