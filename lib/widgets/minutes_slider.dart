import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MinutesSlider extends HookConsumerWidget {
  final String title;
  final int minutes;
  final void Function(double)? onChanged;

  const MinutesSlider({
    required this.title,
    required this.minutes,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Spacer(),
              Text(
                '${minutes}m',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
          Slider(
            value: minutes.toDouble(),
            min: 1,
            max: 60,
            divisions: 59,
            label: '${minutes}m',
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
