import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moody_pomodoro/app.dart';
import 'package:moody_pomodoro/data/timer_state.dart';
import 'package:moody_pomodoro/notifiers/timer_notifier.dart';
import 'package:moody_pomodoro/widgets/timer_widget.dart';
import 'package:window_manager/window_manager.dart';

class TimerPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRunning =
        ref.watch(timerNotifier.select((value) => value.isRunning));
    final isFinished =
        ref.watch(timerNotifier.select((value) => value.isFinished));
    final type = ref.watch(timerNotifier.select((value) => value.type));
    final nextType = ref.watch(timerNotifier.select((value) => value.nextType));
    final showMoodyButton =
        ref.watch(timerNotifier.select((value) => value.showMoodyButton));
    final showStayButton =
        ref.watch(timerNotifier.select((value) => value.showStayButton));

    useEffect(() {
      if (isFinished) {
        WindowManager.instance.setFullScreen(true);
      } else if (isRunning) {
        WindowManager.instance.setFullScreen(false);
      }
    }, [isFinished, isRunning]);

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: Stack(
            children: [
              Center(child: TimerWidget()),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _SettingsButton(),
                ),
              ),
              if (showMoodyButton)
                _BottomRightButton(
                  icon: Icon(nextType.icon),
                  onPressed: () {
                    ref.read(timerNotifier.notifier).next();
                  },
                )
              else if (showStayButton)
                _BottomRightButton(
                  icon: Icon(type.icon),
                  onPressed: () {
                    ref.read(timerNotifier.notifier).stay();
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsButton extends HookConsumerWidget {
  const _SettingsButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Icon(Icons.settings),
      iconSize: 24,
      splashRadius: 24,
      onPressed: () {
        if (!ref.read(timerNotifier).isFinished) {
          ref.read(timerNotifier.notifier).pause();
        }
        ref.read(showSettings).state = true;
      },
    );
  }
}

class _BottomRightButton extends HookConsumerWidget {
  final Widget icon;
  final VoidCallback? onPressed;

  _BottomRightButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: IconButton(
          icon: icon,
          iconSize: 24,
          splashRadius: 24,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
