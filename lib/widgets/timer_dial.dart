import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moody_pomodoro/notifiers/timer_notifier.dart';

class TimerDial extends HookConsumerWidget {
  const TimerDial();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(timerNotifier.select((state) => state.time));
    return Text(
      time,
      style: GoogleFonts.crimsonText(fontSize: 64),
    );
  }
}
