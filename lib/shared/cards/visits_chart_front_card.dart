import 'package:deviation_tracker_flutter_app/shared/line_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class VisitsChartFrontCard extends StatefulWidget {
  const VisitsChartFrontCard({Key? key}) : super(key: key);

  @override
  State<VisitsChartFrontCard> createState() => _VisitsChartFrontCardState();
}

class _VisitsChartFrontCardState extends State<VisitsChartFrontCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 11,
          minY: 0,
          maxY: 6
        ),
      ),
    );
  }
}
