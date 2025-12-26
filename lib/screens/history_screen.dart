import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/widgets/empty_message.dart';
import 'package:expense_tracker/widgets/expense_list_item.dart';
import 'package:expense_tracker/widgets/total_spending_card.dart';
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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TotalSpendingCard(
                label: 'Total Spending in History',
                total: expenseData['total'],
              ),

              SizedBox(height: 24),

              Text(
                'Expenses History',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),

              SizedBox(height: 16),

              ListView.separated(
                padding: EdgeInsets.only(bottom: 32),
                itemCount: expenseData['expenses'].length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final expense = expenseData['expenses'][index];

                  return ExpenseListItem(
                    expense: expense,
                    expenseProvider: value,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
