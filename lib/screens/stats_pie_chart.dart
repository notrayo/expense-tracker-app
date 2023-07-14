import 'package:flutter/material.dart';
import '../models/expense.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
//import 'package:syncfusion_flutter_charts/charts.dart';

class PieChartScreen extends StatefulWidget {
  const PieChartScreen({super.key});

  @override
  State<PieChartScreen> createState() => _PieChartScreenState();
}

class _PieChartScreenState extends State<PieChartScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   fetchDataFromFirestore();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Pie Chart'),
      // ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: PieChart(PieChartData(
              centerSpaceRadius: 15,
              borderData: FlBorderData(show: false),
              sectionsSpace: 3,
              sections: [
                PieChartSectionData(
                    value: 35, color: Colors.purple, radius: 130),
                PieChartSectionData(
                    value: 40, color: Colors.amber, radius: 110),
                PieChartSectionData(
                    value: 55, color: Colors.green, radius: 110),
                PieChartSectionData(
                    value: 70, color: Colors.orange, radius: 110),
              ]))),
    );
  }
}
