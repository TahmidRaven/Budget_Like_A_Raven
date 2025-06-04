import 'package:flutter/material.dart';
import 'expense.dart';  // Import Expense model

class ExpenseListPage extends StatelessWidget {
  final List<Expense> expenseEntries;

  ExpenseListPage({required this.expenseEntries});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense List'),
        backgroundColor: Color.fromARGB(255, 27, 27, 60), // Same as AppBar color
      ),
      body: expenseEntries.isEmpty
          ? Center(child: Text('No expense entries added yet.'))
          : ListView.builder(
              itemCount: expenseEntries.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  child: ListTile(
                    title: Text(expenseEntries[index].name),
                    subtitle: Text('৳${expenseEntries[index].amount}'),
                  ),
                );
              },
            ),
    );
  }
}
