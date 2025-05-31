import 'package:flutter/material.dart';
import 'income_page.dart';
import 'expense_page.dart';
import 'income_list_page.dart'; // Import Income List Page
import 'expense_list_page.dart'; // Import Expense List Page

class BudgetHomePage extends StatefulWidget {
  @override
  _BudgetHomePageState createState() => _BudgetHomePageState();
}

class _BudgetHomePageState extends State<BudgetHomePage> {
  double totalIncome = 0.0;
  double totalExpenses = 0.0;

  // Empty lists for income and expense entries
  List<Map<String, String>> incomeEntries = [];
  List<Map<String, String>> expenseEntries = [];

  // Function to update income and expenses
  void updateIncome(double amount, String name) {
    setState(() {
      totalIncome += amount;
      incomeEntries.insert(0, {'name': name, 'amount': amount.toString()});
    });
  }

  void updateExpenses(double amount, String name) {
    setState(() {
      totalExpenses += amount;
      expenseEntries.insert(0, {'name': name, 'amount': amount.toString()});
    });
  }

  // Function to clear all balances and entries
  void clearAll() {
    setState(() {
      totalIncome = 0.0;
      totalExpenses = 0.0;
      incomeEntries.clear();
      expenseEntries.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    double remainingBalance = totalIncome - totalExpenses;

    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Like A Raven'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 27, 27, 60), // Lavender color for the AppBar
      ),
      body: Column(
        children: [
          // Top Navigation Bar
          Container(
            color: const Color.fromARGB(255, 13, 73, 136),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {} // Home page functionality (if needed)
                ),
                IconButton(
                  icon: Icon(Icons.money_off),
                  onPressed: () {
                    // Navigate to ExpenseListPage and pass the expenseEntries
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpenseListPage(expenseEntries: expenseEntries),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.account_balance_wallet),
                  onPressed: () {
                    // Navigate to IncomeListPage and pass the incomeEntries
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IncomeListPage(incomeEntries: incomeEntries),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // Centered Balance in a Card
          Card(
            elevation: 8,
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            color: Color.fromARGB(255, 27, 27, 60),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Remaining Balance',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '\$${remainingBalance.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: remainingBalance < 0 ? Colors.red : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Recent Income Entries
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Recent Incomes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: incomeEntries.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  child: ListTile(
                    title: Text(incomeEntries[index]['name']!),
                    subtitle: Text('\$${incomeEntries[index]['amount']}'),
                  ),
                );
              },
            ),
          ),
          // Recent Expense Entries
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Recent Expenses',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenseEntries.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  child: ListTile(
                    title: Text(expenseEntries[index]['name']!),
                    subtitle: Text('\$${expenseEntries[index]['amount']}'),
                  ),
                );
              },
            ),
          ),
          // Clear All Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: clearAll,
              child: Text('Clear All Balance'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 26, 64, 138), // Red color for danger
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IncomePage(onIncomeAdded: updateIncome),
                ),
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            tooltip: 'Add Income',
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExpensePage(onExpenseAdded: updateExpenses),
                ),
              );
            },
            child: Icon(Icons.remove),
            backgroundColor: Colors.red,
            tooltip: 'Add Expense',
          ),
        ],
      ),
    );
  }
}
