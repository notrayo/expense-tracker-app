import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

class StatisticsBarChartScreen extends StatefulWidget {
  const StatisticsBarChartScreen({super.key});

  @override
  State<StatisticsBarChartScreen> createState() =>
      _StatisticsBarChartScreenState();
}

class _StatisticsBarChartScreenState extends State<StatisticsBarChartScreen> {
  final List<FlSpot> dummyData1 = List.generate(10, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Bar Chart'),
      // ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: LineChart(
            LineChartData(
              borderData: FlBorderData(show: false),
              lineBarsData: [
                // The red line
                LineChartBarData(
                  spots: dummyData1,
                  isCurved: true,
                  barWidth: 3,
                  color: Colors.indigo,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
