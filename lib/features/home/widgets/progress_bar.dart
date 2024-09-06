import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressBar extends StatelessWidget {
  final double percentWatched;
  const ProgressBar({super.key, required this.percentWatched});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5,
      child: LinearPercentIndicator(
        progressColor: Colors.white,
        backgroundColor: Colors.grey[400],
        barRadius: const Radius.circular(15),
        lineHeight: 5,
        percent: percentWatched,
      ),
    );
  }
}
