import 'package:flutter/material.dart';

class StatisticsBarChartScreen extends StatefulWidget {
  const StatisticsBarChartScreen({super.key});

  @override
  State<StatisticsBarChartScreen> createState() =>
      _StatisticsBarChartScreenState();
}

class _StatisticsBarChartScreenState extends State<StatisticsBarChartScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: const Text('Bar Chart'),
      // ),
      body: Center(
        child: Text('Bar chart page'),
      ),
    );
  }
}
