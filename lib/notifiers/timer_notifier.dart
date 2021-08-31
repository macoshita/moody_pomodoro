import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moody_pomodoro/data/timer_state.dart';

final timerNotifier =
    StateNotifierProvider<TimerNotifier, TimerState>((_) => TimerNotifier());

class TimerNotifier extends StateNotifier<TimerState> {
  DateTime? _endTime;
  Timer? _timer;

  TimerNotifier()
      : super(
          TimerState(
            remainingSeconds: 25 * 60,
            type: TimerType.pomodoro,
          ),
        );

  void next() {
    _start(_getSeconds(state.nextType), state.nextType);
  }

  void stay() {
    _start(_getSeconds(state.type), state.type);
  }

  int _getSeconds(TimerType type) {
    // TODO: set seconds from settings
    switch (type) {
      case TimerType.pomodoro:
        return 25 * 60;
      case TimerType.shortBreaking:
        return 5 * 60;
      case TimerType.longBreaking:
        return 20 * 60;
    }
  }

  void _start(int seconds, TimerType type) {
    _timer?.cancel();
    _endTime = DateTime.now().add(Duration(seconds: seconds + 1));
    state = TimerState(remainingSeconds: seconds, type: type, isRunning: true);
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      final diff = _endTime!.difference(DateTime.now());
      final s = diff.inSeconds - (diff.inMicroseconds < 0 ? 1 : 0);
      state = state.copyWith(remainingSeconds: s);
    });
  }

  void pause() {
    _timer?.cancel();
    state = state.copyWith(isRunning: false);
  }

  void resume() {
    _start(state.remainingSeconds, state.type);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
