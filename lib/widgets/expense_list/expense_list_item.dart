import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:flutter/material.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem({
    super.key,
    required this.expense,
    required this.expenseProvider,
  });

  final dynamic expense;
  final ExpenseProvider expenseProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 8, top: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Tooltip(
                  message: expense.description,
                  child: Text(
                    expense.description,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  expense.formattedDate,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Text(
            expense.formattedAmount,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),

          const SizedBox(width: 8),

          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              expenseProvider.remove(expense);

              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(
                  SnackBar(
                    content: Text('Expense "${expense.description}" deleted'),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        expenseProvider.add(expense);
                      },
                    ),
                    persist: false,
                    duration: Duration(seconds: 2),
                  ),
                );
            },
          ),
        ],
      ),
    );
  }
}
