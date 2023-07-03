import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../data/dummy_data.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  //referencing the dummy data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('what did you spend ? '),
      ),
      body: const Center(
        child: Text('data will be entered here ...'),
      ),
    );
  }
}
