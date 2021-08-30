import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_state.freezed.dart';

@freezed
class TimerState with _$TimerState {
  const TimerState._();
  const factory TimerState({
    required int remainingSeconds,
    required TimerType type,
    @Default(false) bool isRunning,
  }) = _TimerState;

  String get time {
    final sign = remainingSeconds < 0 ? '-' : '';
    final v = remainingSeconds.abs();
    final m = (v ~/ 60).toString().padLeft(2, '0');
    final s = (v % 60).toString().padLeft(2, '0');
    return '$sign$m:$s';
  }

  bool get isFinished => remainingSeconds <= 0;
}

enum TimerType {
  pomodoro,
  shortBreaking,
  longBreaking,
}
