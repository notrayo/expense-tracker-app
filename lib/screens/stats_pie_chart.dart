import 'dart:math';

import 'package:flutter/material.dart';
import '../models/expense.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

//import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
//import 'package:syncfusion_flutter_charts/charts.dart';

class PieChartScreen extends StatefulWidget {
  const PieChartScreen({super.key});

  @override
  State<PieChartScreen> createState() => _PieChartScreenState();
}

class CategoryData {
  final String category;
  final double amount;

  CategoryData({required this.category, required this.amount});
}

Color getRandomColor() {
  // Generate a random color
  return Color.fromRGBO(
    1 + Random().nextInt(255),
    1 + Random().nextInt(255),
    1 + Random().nextInt(255),
    1,
  );
}

class _PieChartScreenState extends State<PieChartScreen> {
  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  List<CategoryData> categoryDataList = [];

  List<Color> staticColors = [
    Colors.purple,
    Colors.amber,
    Colors.green,
    Colors.orange,
    Colors.blue,
  ];

  void fetchDataFromFirestore() async {
    // Fetch data from Firestore collection
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('newExpenses').get();

    // Calculate total amount per category
    Map<String, double> categoryAmounts = {};
    snapshot.docs.forEach((doc) {
      Expense expense = Expense.fromSnapshot(doc);
      String category = expense.category; // Use category directly as a string
      if (categoryAmounts.containsKey(category)) {
        categoryAmounts[category] = categoryAmounts[category]! + expense.amount;
      } else {
        categoryAmounts[category] = expense.amount;
      }
    });

    // Convert categoryAmounts map to a list of CategoryData objects
    List<CategoryData> dataList = [];
    categoryAmounts.forEach((category, amount) {
      dataList.add(CategoryData(category: category, amount: amount));
    });

    setState(() {
      categoryDataList = dataList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Pie Chart'),
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 17,
              runSpacing: 15,
              children: [
                for (int i = 0; i < categoryDataList.length; i++) ...[
                  Container(
                    width: 20,
                    height: 20,
                    color: staticColors[i % staticColors.length],
                  ),
                  Text(
                    categoryDataList[i].category,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 15,
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 3,
                  sections: categoryDataList.map((data) {
                    int index = categoryDataList.indexOf(data);
                    Color color = staticColors[index % staticColors.length];
                    return PieChartSectionData(
                      value: data.amount,
                      color: color,
                      radius: 130,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
