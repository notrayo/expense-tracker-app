import 'package:flutter/material.dart';
import '../models/expense.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:syncfusion_flutter_charts/charts.dart';

class PieChartScreen extends StatefulWidget {
  const PieChartScreen({super.key});

  @override
  State<PieChartScreen> createState() => _PieChartScreenState();
}

class _PieChartScreenState extends State<PieChartScreen> {
  List<Expense> data = [];
  Map<String, double> categoryAmountMap = {};

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('newExpenses')
        .orderBy('date', descending: true)
        .get();

    final List<Expense> expenses = snapshot.docs
        .map((QueryDocumentSnapshot doc) => Expense.fromSnapshot(doc))
        .toList();

    // Calculate total amount per category
    categoryAmountMap = {};
    for (Expense expense in expenses) {
      final double currentAmount = categoryAmountMap[expense.category] ?? 0;
      categoryAmountMap[expense.category] = currentAmount + expense.amount;
    }

    setState(() {
      data = expenses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: const Text('Pie Chart'),
      // ),
      body: Center(child: Text('no data yet')
          //data.isEmpty ? const CircularProgressIndicator() : _buildPieChart(),
          ),
    );
  }

  // Widget _buildPieChart() {
  //   final List<String> categoryList = categoryAmountMap.keys.toList();

  //   return SfCircularChart(
  //     series: <CircularSeries>[
  //       DoughnutSeries<String, double>(
  //         dataSource: categoryList,
  //         xValueMapper: (String category, _) =>
  //             categoryList.indexOf(category).toDouble(),
  //         yValueMapper: (String category, _) =>
  //             categoryAmountMap[category] ?? 0.0,
  //         dataLabelSettings: const DataLabelSettings(isVisible: true),
  //       ),
  //     ],
  //   );
  // }
}
