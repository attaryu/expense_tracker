import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseProvider extends ChangeNotifier {
  final List<ExpenseModel> _expenses = [
    ExpenseModel(
      amount: 25000,
      description: 'Makan Siang Ayam Bakar',
      category: 'Food',
      date: DateTime.parse('2025-12-26'),
    ),
    ExpenseModel(
      amount: 50000,
      description: 'Isi Bensin Motor',
      category: 'Transport',
      date: DateTime.parse('2025-12-23'),
    ),
    ExpenseModel(
      amount: 180000,
      description: 'Langganan Netflix & Spotify',
      category: 'Subscription',
      date: DateTime.parse('2025-12-05'),
    ),
    ExpenseModel(
      amount: 20000,
      description: 'Parkir Mall',
      category: 'Transport',
      date: DateTime.parse('2025-11-15'),
    ),
  ];

  List<String> get categories =>
      _expenses.map((expense) => expense.category).toSet().toList();

  Map<String, dynamic> getExpenses({
    bool today = false,
    bool thisWeek = false,
    bool thisMonth = false,
  }) {
    DateTime now = DateTime.now();

    if (today) {
      List<ExpenseModel> todayExpenses = _expenses
          .where(
            (expense) =>
                expense.date.year == now.year &&
                expense.date.month == now.month &&
                expense.date.day == now.day,
          )
          .toList();

      return {
        'expenses': todayExpenses,
        'total': _calculateTotalExpense(todayExpenses),
      };
    }

    if (thisWeek) {
      DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

      List<ExpenseModel> thisWeekExpenses = _expenses
          .where(
            (expense) =>
                expense.date.isAfter(startOfWeek.subtract(Duration(days: 1))) &&
                expense.date.isBefore(endOfWeek.add(Duration(days: 1))),
          )
          .toList();

      return {
        'expenses': thisWeekExpenses,
        'total': _calculateTotalExpense(thisWeekExpenses),
      };
    }

    if (thisMonth) {
      List<ExpenseModel> thisMonthExpenses = _expenses
          .where(
            (expense) =>
                expense.date.year == now.year &&
                expense.date.month == now.month,
          )
          .toList();

      return {
        'expenses': thisMonthExpenses,
        'total': _calculateTotalExpense(thisMonthExpenses),
      };
    }

    return {'expenses': _expenses, 'total': _calculateTotalExpense(_expenses)};
  }

  void add(ExpenseModel expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  void remove(ExpenseModel expense) {
    _expenses.remove(expense);
    notifyListeners();
  }

  String _calculateTotalExpense(List<ExpenseModel> expenses) {
    final double total = expenses.fold(0.0, (sum, item) => sum + item.amount);
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return formatter.format(total);
  }
}
