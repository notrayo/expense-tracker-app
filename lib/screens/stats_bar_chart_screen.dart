import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsBarChartScreen extends StatefulWidget {
  const StatisticsBarChartScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsBarChartScreen> createState() =>
      _StatisticsBarChartScreenState();
}

class _StatisticsBarChartScreenState extends State<StatisticsBarChartScreen> {
  List<FlSpot> dataPoints = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  void fetchDataFromFirestore() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('newExpenses').get();

    List<double> amounts = [];
    snapshot.docs.forEach((doc) {
      // Assuming you have an 'amount' field in your Firestore documents
      double amount = doc['amount'];
      amounts.add(amount);
    });

    setState(() {
      dataPoints = _convertToFlSpots(amounts);
    });
  }

  List<FlSpot> _convertToFlSpots(List<double> amounts) {
    List<FlSpot> flSpots = [];
    for (int i = 0; i < amounts.length; i++) {
      flSpots.add(FlSpot(i.toDouble(), amounts[i]));
    }
    return flSpots;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: SafeArea(
        //   child: Container(
        //     padding: const EdgeInsets.all(20),
        //     width: double.infinity,
        //     child: LineChart(
        //       LineChartData(
        //         titlesData: FlTitlesData(
        //           bottomTitles: SideTitles(
        //             showTitles: true,
        //             margin: 8,
        //             getTitles: (value) {
        //               // Replace with your logic to format and display the month labels
        //               List<String> monthLabels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
        //               if (value >= 0 && value < monthLabels.length) {
        //                 return monthLabels[value.toInt()];
        //               }
        //               return '';
        //             },
        //           ),
        //           leftTitles: SideTitles(
        //             showTitles: true,
        //             margin: 8,
        //             reservedSize: 30,
        //             getTitles: (value) {
        //               // Replace with your logic to format and display the amount labels
        //               if (value % 100 == 0) {
        //                 return '\$${value.toInt()}';
        //               }
        //               return '';
        //             },
        //           ),
        //         ) as AxisTitles?,
        //         borderData: FlBorderData(show: false),
        //         lineBarsData: [
        //           // The line
        //           LineChartBarData(
        //             spots: dataPoints,
        //             isCurved: true,
        //             barWidth: 3,
        //             colors: [Colors.indigo],
        //             dotData: FlDotData(show: false),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}
