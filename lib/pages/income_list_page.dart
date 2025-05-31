import 'package:flutter/material.dart';

class IncomeListPage extends StatelessWidget {
  final List<Map<String, String>> incomeEntries;

  IncomeListPage({required this.incomeEntries});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Income List'),
        backgroundColor: Color.fromARGB(255, 27, 27, 60), // Same as AppBar color
      ),
      body: incomeEntries.isEmpty
          ? Center(child: Text('No income entries added yet.'))
          : ListView.builder(
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
    );
  }
}
