import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moody_pomodoro/app.dart';

void main() {
  runApp(ProviderScope(child: App()));
}
