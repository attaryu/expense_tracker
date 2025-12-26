import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/widgets/empty_message.dart';
import 'package:expense_tracker/widgets/expense_list/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Consumer<ExpenseProvider>(
        builder: (context, value, child) {
          final expenseData = value.getExpenses();

          if (expenseData['expenses'].length == 0) {
            return EmptyMessage(
              'No expenses yet.',
              height: MediaQuery.of(context).size.height - 100,
            );
          }

          return ExpenseList(
            expenseData: expenseData,
            expenseProvider: value,
            cardLabel: 'Total Spending in History',
            listLabel: 'Expenses History',
          );
        },
      ),
    );
  }
}
