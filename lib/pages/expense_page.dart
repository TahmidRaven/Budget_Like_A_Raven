import 'package:flutter/material.dart';

class ExpensePage extends StatefulWidget {
  final Function(double, String) onExpenseAdded;

  ExpensePage({required this.onExpenseAdded});

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController(text: "Khoroch"); // Default name

  void _submitExpense() {
    double? amount = double.tryParse(_amountController.text);
    if (amount != null && amount > 0) {
      widget.onExpenseAdded(amount, _nameController.text);
      Navigator.pop(context); // Go back after adding expense
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter a valid expense amount.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Expense")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Amount TextField with BDT symbol
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Amount",
                prefixText: "৳",  // Adding the BDT symbol as a prefix to the input field
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController, // Use controller to set the default name
              decoration: InputDecoration(labelText: "Expense Name"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitExpense,
              child: Text("Add Expense"),
            ),
          ],
        ),
      ),
    );
  }
}
