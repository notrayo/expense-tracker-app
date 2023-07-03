import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { productivity, leisure, food, commute, clothes }

class Expense {
  final String id;
  final String description;
  final double amount;
  final DateTime date;
  final Category category;

  Expense(
      {required this.description,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
}
