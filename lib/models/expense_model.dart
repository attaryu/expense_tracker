import 'package:intl/intl.dart';

class ExpenseModel {
  final String id;
  final double amount;
  final String description;
  final String category;
  final DateTime date;

  ExpenseModel({
    required this.amount,
    required this.description,
    required this.category,
    required this.date,
  }) : id = DateTime.now().millisecondsSinceEpoch.toString();

  String get formattedDate {
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    return formatter.format(date);
  }

  String get formattedAmount {
    final NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 0,
    );
    return currencyFormatter.format(amount);
  }
}
