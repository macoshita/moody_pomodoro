import 'package:flutter/material.dart';
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

  TimerType get nextType =>
      type == TimerType.pomodoro ? TimerType.shortBreaking : TimerType.pomodoro;

  bool get showMoodyButton => isRunning && !isFinished;
  bool get showStayButton => isFinished;
  bool get showNextButton => isFinished;
}

enum TimerType {
  pomodoro,
  shortBreaking,
  longBreaking,
}

extension TimerTypeX on TimerType {
  IconData get icon {
    switch (this) {
      case TimerType.pomodoro:
        return Icons.work;
      case TimerType.shortBreaking:
        return Icons.hotel;
      case TimerType.longBreaking:
        return Icons.hotel;
    }
  }

  Color get color {
    switch (this) {
      case TimerType.pomodoro:
        return Colors.red;
      case TimerType.shortBreaking:
        return Colors.green;
      case TimerType.longBreaking:
        return Colors.green;
    }
  }
}
