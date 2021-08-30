import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final timerNotifier =
    StateNotifierProvider<TimerNotifier, TimerState>((_) => TimerNotifier());

class TimerNotifier extends StateNotifier<TimerState> {
  DateTime? startTime;
  Timer? timer;
  int? remainingSeconds;

  TimerNotifier() : super(TimerState(0));

  void start() {
    remainingSeconds = 25 * 60;
    state = TimerState(remainingSeconds!);
    startTime = DateTime.now();
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      final seconds = DateTime.now().difference(startTime!).inSeconds;
      state = TimerState(remainingSeconds! - seconds);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

class TimerState {
  final int seconds;

  TimerState(this.seconds);

  String get time {
    final m = '${seconds ~/ 60}'.padLeft(2, '0');
    final s = '${seconds.abs() % 60}'.padLeft(2, '0');
    return m + ':' + s;
  }

  @override
  bool operator ==(Object object) =>
      identical(this, object) ||
      (object is TimerState &&
          runtimeType == object.runtimeType &&
          seconds == object.seconds);

  @override
  int get hashCode => seconds.hashCode;
}
