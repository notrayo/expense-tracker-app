import './add_expense.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../data/dummy_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> expenses = initialExpenses;
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Recent Expenses ...'),
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
          body: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: ((context, index) {
                final expense = expenses[index];
                return ListTile(
                  title: Text(
                    expense.description,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle:
                      Text('Amount: \$${expense.amount.toStringAsFixed(2)}'),
                  //trailing: Text(expense.date.toString()),
                );
              }))),
    );
  }
}
