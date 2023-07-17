//import 'dart:math';

import '../models/expense.dart';
import 'package:flutter/material.dart';
//import '../models/expense.dart';
//import '../data/dummy_data.dart';
import 'package:intl/intl.dart';
import './home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;

  //data controllers
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  //final _categoryController = TextEditingController();
  String? _selectedCategory;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      // Handle the selected date
      ('Selected date: $picked');
    }
  }

  final List<String> categories = [
    'productivity',
    'leisure',
    'electronics',
    'clothes',
    'investment',
    'commute / fare'
  ];

  //adding the data to a firebase collection table

  void _saveExpense() {
    final String description = _descriptionController.text;
    final double amount = double.tryParse(_amountController.text) ?? 0;
    final DateTime? date = _selectedDate;
    //final Category category = Category.values[_selectedCategoryIndex()];

    if (_formKey.currentState?.validate() ?? false) {
      final expense = Expense(
        description: description,
        amount: amount,
        date: date!,
        category: _selectedCategory!,
      );

      // Save the expense to Firebase collection
      FirebaseFirestore.instance
          .collection('newExpenses')
          .add(expense.toMap())
          .then((_) {
        // Show snackbar notification
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Notification'),
              content: const Text('New Expense Captured Successfully!'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    // Clear the form
                    _descriptionController.clear();
                    _amountController.clear();
                    _dateController.clear();
                    setState(() {
                      _selectedDate = null;
                      _selectedCategory = null;
                    });

                    // Navigate to the home screen
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      }).catchError((error) {
        // Show dialog notification if there was an error
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text('Failed to capture expense: $error'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });

        // Clear the form
      }).catchError((error) {
        // Show snackbar notification if there was an error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to capture expense: $error'),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Recent Expenses '),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Builder(
                builder: (BuildContext context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Enter information on what you spent on ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          hintText: '...enter info here ...',
                          prefixIcon: const Icon(Icons.info_outline),
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 70, 70, 70),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 2, 63, 113)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'How much did you use ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _amountController,
                        decoration: InputDecoration(
                          hintText: '... in Kshs',
                          prefixIcon: const Icon(Icons.attach_money),
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 70, 70, 70),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 2, 63, 113)),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'When was this ?  ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _dateController,
                              decoration: InputDecoration(
                                hintText: _selectedDate != null
                                    ? DateFormat('dd-MM-yyyy')
                                        .format(_selectedDate!)
                                    : 'Press the calender icon --->',
                                //prefixIcon: const Icon(Icons.calendar_view_week_outlined),
                                hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 70, 70, 70),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 2, 63, 113),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.calendar_today,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              _selectDate(context);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'What Spending Category would you place this ?  ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          hintText: 'Choose Category',
                          prefixIcon: const Icon(
                            Icons.ice_skating,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 2, 63, 113)),
                          ),
                          hintStyle: const TextStyle(color: Colors.black),
                        ),
                        value: _selectedCategory,
                        items: categories.map((String category) {
                          return DropdownMenuItem<String>(
                              value: category, child: Text(category));
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const SizedBox(height: 35),
                      Center(
                        child: SizedBox(
                          // width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _saveExpense();
                              // Navigator.of(context).pushReplacement(
                              //   MaterialPageRoute(
                              //     builder: (context) => const HomeScreen(),
                              //   ),
                              // );
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 222, 33),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 15,
                                )),
                            child: const Text(
                              'Save Expense',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ));
  }
}
