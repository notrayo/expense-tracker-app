//import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { productivity, leisure, food, commute, clothes }

class Expense {
  final String id;
  final String description;
  final double amount;
  final DateTime date;
  final String category;

  Expense(
      {required this.description,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'amount': amount,
      'date': date,
      'category': category,
    };
  }
}
