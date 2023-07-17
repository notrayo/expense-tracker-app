//import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const uuid = Uuid();

enum Category { productivity, leisure, food, commute, clothes }

class Expense {
  final String id;
  final String description;
  final double amount;
  final DateTime date;
  final String category;

  Expense({
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
    //required String formattedDate}
  }) : id = uuid.v4();

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'amount': amount,
      'date': date,
      'category': category,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    final expenseDate = (map['date'] as Timestamp).toDate();
    //final formattedDate = '${_getMonthName(expenseDate.month)} ${expenseDate.year}';
    return Expense(
      description: map['description'],
      amount: map['amount'],
      category: map['category'],
      date: expenseDate,
      //formattedDate: formattedDate
    );
  }

  static String getFormattedMonthYear(DateTime date) {
    final monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    final month = monthNames[date.month - 1];
    final day = date.day.toString();
    final year = date.year.toString();

    return '$month $day, $year';
  }

  factory Expense.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final expenseDate = (data['date'] as Timestamp).toDate();
    return Expense(
      description: data['description'],
      amount: data['amount'],
      category: data['category'],
      date: expenseDate,
    );
  }
}
