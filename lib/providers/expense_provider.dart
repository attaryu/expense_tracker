import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseProvider extends ChangeNotifier {
  final List<ExpenseModel> _expenses = [];

  List<String> get categories =>
      _expenses.map((expense) => expense.category).toSet().toList();

  double get totalExpense {
    return _expenses.fold(0.0, (total, expense) => total + expense.amount);
  }

  void add(ExpenseModel expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  void remove(ExpenseModel expense) {
    _expenses.remove(expense);
    notifyListeners();
  }
}
