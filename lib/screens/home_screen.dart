import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/widgets/empty_message.dart';
import 'package:expense_tracker/widgets/expense_list_item.dart';
import 'package:expense_tracker/widgets/total_spending_card.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

enum TimePeriod {
  today('Today'),
  thisWeek('This Week'),
  thisMonth('This Month');

  final String label;
  const TimePeriod(this.label);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TimePeriod _selectedPeriod = TimePeriod.today;
  final groupButtonController = GroupButtonController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GroupButton(
            controller: groupButtonController,
            onSelected: (value, index, isSelected) =>
                setState(() => _selectedPeriod = TimePeriod.values[index]),
            buttons: TimePeriod.values.map((e) => e.label).toList(),
            buttonBuilder: (selected, value, context) => Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  width: 1.5,
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.black.withValues(alpha: 0.6),
                ),
              ),
              child: Text(
                value,
                style: selected
                    ? TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      )
                    : TextStyle(
                        color: Colors.black.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
              ),
            ),
            options: GroupButtonOptions(
              mainGroupAlignment: MainGroupAlignment.start,
              spacing: 6,
              runSpacing: 6,
            ),
          ),

          SizedBox(height: 24),

          Consumer<ExpenseProvider>(
            builder: (context, value, child) {
              final expenseData = value.getExpenses(
                today: _selectedPeriod == TimePeriod.today,
                thisWeek: _selectedPeriod == TimePeriod.thisWeek,
                thisMonth: _selectedPeriod == TimePeriod.thisMonth,
              );

              if (expenseData['expenses'].length == 0) {
                final height = MediaQuery.of(context).size.height - 200;

                return EmptyMessage(
                  'No expenses for ${_selectedPeriod.label.toLowerCase()}.',
                  height: height,
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TotalSpendingCard(total: expenseData['total']),

                  SizedBox(height: 24),

                  Text(
                    'Expenses',
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
                    itemBuilder: (context, index) => ExpenseListItem(
                      expense: expenseData['expenses'][index],
                      expenseProvider: value,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
