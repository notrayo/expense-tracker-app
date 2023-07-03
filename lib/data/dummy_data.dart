import '../models/expense.dart';

final List<Expense> initialExpenses = [
  Expense(
    description: 'First Purchase',
    amount: 300,
    date: DateTime.now(),
    category: Category.leisure,
  ),
  Expense(
      description: 'Nike SBs',
      amount: 1800,
      date: DateTime(2022, 4, 22),
      category: Category.clothes)
];
