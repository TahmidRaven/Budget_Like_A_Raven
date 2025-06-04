class Expense {
  final int id;
  final String name;
  final double amount;

  Expense({required this.id, required this.name, required this.amount});

  // Convert an Expense object into a Map. This is used for database insertion.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
    };
  }

  // Convert a Map to an Expense object. This is used for converting retrieved data from the database.
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      name: map['name'],
      amount: map['amount'],
    );
  }

  @override
  String toString() {
    return 'Expense{id: $id, name: $name, amount: $amount}';
  }
}
