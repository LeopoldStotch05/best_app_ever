import 'package:best_app_ever/app/screens/main_screen.dart';
import 'package:flutter/material.dart';

/// MaterialApp widget
class App extends StatelessWidget {
  /// Initializes [key] for subclasses.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MainScreen(),
    );
  }
}
