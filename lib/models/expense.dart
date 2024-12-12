class Expense {
  final String type;
  final String category;
  final String amount;
  final String? description;
  final DateTime date;

  const Expense({
    required this.type,
    required this.category,
    this.description,
    required this.amount,
    required this.date,
  });
}
