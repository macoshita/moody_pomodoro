import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_state.freezed.dart';

@freezed
class TimerState with _$TimerState {
  const TimerState._();
  const factory TimerState({
    required int seconds,
    required TimerType type,
    @Default(false) bool isRunning,
  }) = _TimerState;

  String get time {
    final m = '${seconds ~/ 60}'.padLeft(2, '0');
    final s = '${seconds.abs() % 60}'.padLeft(2, '0');
    return m + ':' + s;
  }
}

enum TimerType {
  pomodoro,
  shortBreaking,
  longBreaking,
}
