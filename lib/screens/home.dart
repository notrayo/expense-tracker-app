import './add_expense.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses App ...'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddExpense(),
                    ));
              },
              icon: const Icon(
                Icons.add,
                size: 30,
              ))
        ],
      ),
      body: const Center(
        child: Text('expenses here ...'),
      ),
    );
  }
}
