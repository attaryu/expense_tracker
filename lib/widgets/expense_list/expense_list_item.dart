import 'package:expense_tracker/core/constants/breakpoint.dart';
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

  void _deleteHandler(BuildContext context) {
    expenseProvider.remove(expense);

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text('Expense "${expense.description}" deleted'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () => expenseProvider.add(expense),
          ),
          persist: false,
          duration: Duration(seconds: 5),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (BreakPoint.isMobile(width)) {
      return Dismissible(
        key: ValueKey(expense.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        onDismissed: (_) => _deleteHandler(context),
        child: _renderList(context),
      );
    }

    return _renderList(context);
  }

  Container _renderList(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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

          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: BreakPoint.isTablet(width) || BreakPoint.isMobile(width)
                  ? 75
                  : 120,
            ),
            child: Tooltip(
              message: expense.formattedAmount,
              child: Text(
                expense.formattedAmount,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          if (!BreakPoint.isMobile(width)) _renderDeleteButton(context),
        ],
      ),
    );
  }

  Row _renderDeleteButton(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8),

        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () => _deleteHandler(context),
        ),
      ],
    );
  }
}
