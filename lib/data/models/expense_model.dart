class ExpenseModel {
  const ExpenseModel({
    this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.description,
  });

  final int? id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final String? description;

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title.trim(),
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
      'description': description?.trim(),
    };
  }

  factory ExpenseModel.fromMap(Map<String, Object?> map) {
    return ExpenseModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      amount: (map['amount'] as num).toDouble(),
      category: map['category'] as String,
      date: DateTime.parse(map['date'] as String),
      description: map['description'] as String?,
    );
  }

  ExpenseModel copyWith({
    int? id,
    String? title,
    double? amount,
    String? category,
    DateTime? date,
    String? description,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      description: description ?? this.description,
    );
  }
}
