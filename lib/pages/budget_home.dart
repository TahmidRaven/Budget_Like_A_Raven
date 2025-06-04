import 'package:flutter/material.dart';
import 'income.dart';  // Import Income model
import 'expense.dart';  // Import Expense model
import 'income_page.dart';  // Import IncomePage
import 'expense_page.dart';  // Import ExpensePage
import 'income_list_page.dart';  // Import IncomeListPage
import 'expense_list_page.dart';  // Import ExpenseListPage
import 'database_helper.dart';  // Import DatabaseHelper

class BudgetHomePage extends StatefulWidget {
  @override
  _BudgetHomePageState createState() => _BudgetHomePageState();
}

class _BudgetHomePageState extends State<BudgetHomePage> {
  double totalIncome = 0.0;
  double totalExpenses = 0.0;

  List<Income> incomeEntries = [];
  List<Expense> expenseEntries = [];

  final DatabaseHelper dbHelper = DatabaseHelper.instance; // Database helper

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Load data from the database
  Future<void> _loadData() async {
    List<Income> incomes = await dbHelper.getIncomes();
    List<Expense> expenses = await dbHelper.getExpenses();

    setState(() {
      incomeEntries = incomes;
      expenseEntries = expenses;
      totalIncome = incomeEntries.fold(0.0, (sum, entry) => sum + entry.amount);
      totalExpenses = expenseEntries.fold(0.0, (sum, entry) => sum + entry.amount);
    });
  }

  // Insert new income
  void addIncome(double amount, String name) async {
    Income income = Income(id: 0, name: name, amount: amount);
    await dbHelper.insertIncome(income);
    _loadData();  // Reload data from the database after insertion
  }

  // Insert new expense
  void addExpense(double amount, String name) async {
    Expense expense = Expense(id: 0, name: name, amount: amount);
    await dbHelper.insertExpense(expense);
    _loadData();  // Reload data from the database after insertion
  }

  // Clear all balances
  void clearAll() async {
    await dbHelper.clearAllData();  // Clear all data from the database
    _loadData();  // Reload data from the database after clearing
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
                    '৳${remainingBalance.toStringAsFixed(2)}', // Change $ to ৳
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
          // Recent Income Entries Section
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
                    title: Text(incomeEntries[index].name),
                    subtitle: Text('৳${incomeEntries[index].amount}'), // Change $ to ৳
                  ),
                );
              },
            ),
          ),
          // Recent Expense Entries Section
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
                    title: Text(expenseEntries[index].name),
                    subtitle: Text('৳${expenseEntries[index].amount}'), // Change $ to ৳
                  ),
                );
              },
            ),
          ),
          // Clear All Button to Reset Data
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
              // Add income logic
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IncomePage(onIncomeAdded: addIncome),
                ),
              );
            },
            shape: CircleBorder(),
            child: Icon(Icons.add),
            backgroundColor: const Color.fromARGB(255, 17, 94, 19),
            tooltip: 'Add Income',
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              // Add expense logic
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExpensePage(onExpenseAdded: addExpense),
                ),
              );
            },
            shape: CircleBorder(),
            child: Icon(Icons.remove),
            backgroundColor: const Color.fromARGB(255, 152, 92, 3),
            tooltip: 'Add Expense',
          ),
        ],
      ),
    );
  }
}
