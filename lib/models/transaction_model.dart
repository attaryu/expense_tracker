class TransactionModel {
  final bool isIncome;
  final String id;
  final double amount;
  final String description;
  final String category;
  final DateTime date;

  TransactionModel({
    required this.isIncome,
    required this.amount,
    required this.description,
    required this.category,
    required this.date,
  }) : id = DateTime.now().millisecondsSinceEpoch.toString();
}
