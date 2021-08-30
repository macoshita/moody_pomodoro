import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moody_pomodoro/notifiers/timer_notifier.dart';

class TimerWidget extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(timerNotifier.select((state) => state));
    return Text(
      state.time,
      style: GoogleFonts.crimsonText(fontSize: 64),
    );
  }
}
