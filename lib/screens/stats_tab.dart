import 'package:expense_tracker/screens/stats_bar_chart_screen.dart';
import 'package:flutter/material.dart';
//import 'stats_tab.dart';
import './stats_pie_chart.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final List<Map<String, Object>> _pages = [
    {'page': const PieChartScreen(), 'title': 'Stats by Categories ...'},
    {'page': const StatisticsBarChartScreen(), 'title': 'Stats by Time'}
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String? ?? ''),
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget?,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.donut_large_outlined), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.stacked_bar_chart_outlined), label: 'Time')
        ],
        backgroundColor: const Color.fromARGB(255, 236, 232, 232),
        //selectedItemColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
