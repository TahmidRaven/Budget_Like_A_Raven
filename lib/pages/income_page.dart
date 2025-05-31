import 'package:flutter/material.dart';

class IncomePage extends StatefulWidget {
  final Function(double, String) onIncomeAdded;

  IncomePage({required this.onIncomeAdded});

  @override
  _IncomePageState createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController(text: "Paycheck"); // Default name

  void _submitIncome() {
    double? amount = double.tryParse(_amountController.text);
    if (amount != null && amount > 0) {
      widget.onIncomeAdded(amount, _nameController.text);  // Update incomeEntries in BudgetHomePage
      Navigator.pop(context); // Go back after adding income
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter a valid income amount.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Income")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Amount"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController, // Use controller to set the default name
              decoration: InputDecoration(labelText: "Income Name"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitIncome,
              child: Text("Add Income"),
            ),
          ],
        ),
      ),
    );
  }
}
