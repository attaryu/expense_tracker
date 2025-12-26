import 'package:expense_tracker/core/constants/breakpoint.dart';
import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/widgets/expense_list/expense_list_item.dart';
import 'package:expense_tracker/widgets/total_spending_card.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expenseData,
    required this.expenseProvider,
    this.cardLabel = 'Spend so far',
    this.listLabel = 'Expenses',
  });

  final Map<String, dynamic> expenseData;
  final ExpenseProvider expenseProvider;
  final String cardLabel;
  final String listLabel;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (BreakPoint.isMobile(width)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _renderTotalSpendingCard(),

          const SizedBox(height: 24),

          Text(
            listLabel,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 16),

          _renderList(),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _renderTotalSpendingCard()),

        const SizedBox(width: 16),

        Expanded(
          flex: BreakPoint.isTablet(width) ? 1 : 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                listLabel,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 12),

              _renderList(),
            ],
          ),
        ),
      ],
    );
  }

  TotalSpendingCard _renderTotalSpendingCard() =>
      TotalSpendingCard(
        total: expenseData['total'],
        label: cardLabel,
      );

  ListView _renderList() {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 32),
      itemCount: expenseData['expenses'].length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) => ExpenseListItem(
        expense: expenseData['expenses'][index],
        expenseProvider: expenseProvider,
      ),
    );
  }
}
