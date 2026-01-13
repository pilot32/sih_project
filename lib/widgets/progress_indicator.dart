import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final double progress;

  const ProgressIndicatorWidget({
    Key? key,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      lineHeight: 8.0,
      percent: progress,
      backgroundColor: Colors.grey.shade300,
      progressColor: Colors.blue,
      barRadius: const Radius.circular(8),
    );
  }
}
