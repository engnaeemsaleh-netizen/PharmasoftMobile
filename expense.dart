
class Expense {
  final int? id;
  final String title;
  final double amount;
  final String ts; // ISO date-time

  Expense({this.id, required this.title, required this.amount, required this.ts});

  factory Expense.fromMap(Map<String, dynamic> m) => Expense(
    id: m['id'] as int?,
    title: m['title'] as String,
    amount: (m['amount'] as num).toDouble(),
    ts: m['ts'] as String,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'amount': amount,
    'ts': ts,
  };
}
