import './add_expense.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';
//import '../data/dummy_data.dart';
import './drawer.dart';
import 'stats_tab.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? expensesStream;

  //select screen from drawer

  void _selectScreenFromDrawer(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'Statistics') {
      final result =
          await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
        builder: (context) => const StatisticsScreen(),
      ));
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    expensesStream = FirebaseFirestore.instance
        .collection('newExpenses')
        .orderBy('date', descending: true)
        .snapshots();
  }

  //final List<Expense> expenses = initialExpenses;
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
        drawer: DrawerWidget(onSelectScreenFromDrawer: _selectScreenFromDrawer),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: expensesStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.data == null) {
              return const Center(child: Text('No data available'));
            }

            final expenses = snapshot.data!.docs.map((doc) {
              return Expense.fromMap(doc.data());
            }).toList();

            return ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: const Color.fromARGB(255, 234, 234, 234),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14, // Increase the vertical padding
                      horizontal: 14,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              expense.description,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${Expense.getFormattedMonthYear(expense.date)} (${expense.category})',
                              style: const TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Kshs. ${expense.amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Delete Expense'),
                          content: const Text(
                              'Are you sure you want to delete this Expense?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.of(ctx).pop();

                                final expensesCollection = FirebaseFirestore
                                    .instance
                                    .collection('newExpenses');

                                // Find the matching document based on expense properties
                                final matchingDocuments =
                                    await expensesCollection
                                        .where('description',
                                            isEqualTo: expense.description)
                                        .where('amount',
                                            isEqualTo: expense.amount)
                                        .where('date', isEqualTo: expense.date)
                                        .where('category',
                                            isEqualTo: expense.category)
                                        .get();

                                // Delete all matching documents (there should be only one)
                                for (final doc in matchingDocuments.docs) {
                                  await expensesCollection.doc(doc.id).delete();
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Expense deleted'),
                                  ),
                                );
                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 201, 31, 19)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
