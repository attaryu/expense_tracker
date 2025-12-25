import 'package:expense_tracker/models/transaction_model.dart';
import 'package:flutter/material.dart';

class TransactionProvider extends ChangeNotifier {
  final List<TransactionModel> _transactions = [];

  List<String> get categories =>
      _transactions.map((transaction) => transaction.category).toSet().toList();
  double get totalIncome => _calculateTotal(isIncome: true);
  double get totalExpense => _calculateTotal(isIncome: false);

  double _calculateTotal({required bool isIncome}) {
    return _transactions
        .where((transaction) => transaction.isIncome == isIncome)
        .fold(0.0, (total, transaction) => total + transaction.amount);
  }

  void add(TransactionModel transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }

  void update(
    TransactionModel oldTransaction,
    TransactionModel newTransaction,
  ) {
    final index = _transactions.indexOf(oldTransaction);

    if (index != -1) {
      _transactions[index] = newTransaction;
      notifyListeners();
    }
  }

  void remove(TransactionModel transaction) {
    _transactions.remove(transaction);
    notifyListeners();
  }
}
