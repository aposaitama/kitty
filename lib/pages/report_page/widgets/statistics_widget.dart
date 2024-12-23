import 'package:flutter/material.dart';

class StatisticsWidget extends StatelessWidget {
  final Map<String, Map<String, dynamic>> summary;
  const StatisticsWidget({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 36.0,
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(6)),
        child: Row(
          children: summary.entries.map((entry) {
            double percentage = entry.value['percentage'] as double;
            int backgroundColor = entry.value['backgroundColor'] as int;
            return Expanded(
              flex: (percentage / 100 * 100).toInt(),
              child: Container(
                color: Color(backgroundColor),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
