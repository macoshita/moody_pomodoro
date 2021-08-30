import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moody_pomodoro/data/timer_state.dart';

final timerNotifier =
    StateNotifierProvider<TimerNotifier, TimerState>((_) => TimerNotifier());

class TimerNotifier extends StateNotifier<TimerState> {
  DateTime? _startTime;
  Timer? _timer;
  int? _remainingSeconds;

  TimerNotifier()
      : super(
          TimerState(
            seconds: 25 * 60,
            type: TimerType.pomodoro,
          ),
        );

  void setPomodoro() {
    _timer?.cancel();
    state = TimerState(seconds: 25 * 60, type: TimerType.pomodoro);
  }

  void setShortBreaking() {
    _timer?.cancel();
    state = TimerState(seconds: 5 * 60, type: TimerType.shortBreaking);
  }

  void setLongBreaking() {
    _timer?.cancel();
    state = TimerState(seconds: 20 * 60, type: TimerType.longBreaking);
  }

  void start() {
    _timer?.cancel();
    _remainingSeconds = state.seconds;
    _startTime = DateTime.now();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      final seconds = DateTime.now().difference(_startTime!).inSeconds;
      state = state.copyWith(
        seconds: _remainingSeconds! - seconds,
        isRunning: true,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
