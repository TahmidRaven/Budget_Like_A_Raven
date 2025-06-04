class Income {
  final int id;
  final String name;
  final double amount;

  Income({required this.id, required this.name, required this.amount});

  // Convert an Income object into a Map. This is used for database insertion.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
    };
  }

  // Convert a Map to an Income object. This is used for converting retrieved data from the database.
  factory Income.fromMap(Map<String, dynamic> map) {
    return Income(
      id: map['id'],
      name: map['name'],
      amount: map['amount'],
    );
  }

  @override
  String toString() {
    return 'Income{id: $id, name: $name, amount: $amount}';
  }
}
