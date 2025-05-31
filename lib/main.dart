import 'package:flutter/material.dart';
import 'pages/budget_home.dart';  // Import the main budget home page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Like A Raven',
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          color: Color.fromARGB(255, 27, 27, 60), // Lavender AppBar color
          centerTitle: true, // Center the app title
          titleTextStyle: TextStyle(
            fontFamily: 'SpaceGrotesk', // Apply Space Grotesk to AppBar title
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.green, // Default button color
          textTheme: ButtonTextTheme.primary, // White text color for buttons
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(fontFamily: 'SpaceGrotesk', fontSize: 32, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontFamily: 'SpaceGrotesk', fontSize: 28, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontFamily: 'SpaceGrotesk', fontSize: 24, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontFamily: 'SpaceGrotesk', fontSize: 16), // Body text style
          bodyMedium: TextStyle(fontFamily: 'SpaceGrotesk', fontSize: 14), // Body text style for smaller text
        ),
      ),
      home: BudgetHomePage(), // Set BudgetHomePage as the starting screen
    );
  }
}
