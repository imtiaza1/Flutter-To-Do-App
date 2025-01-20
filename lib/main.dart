import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'home.dart';

void main() async{
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[900], // Dark blue
          foregroundColor: Colors.white, // White text/icons
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Vibrant blue
            foregroundColor: Colors.white, // White text
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue, // Vibrant blue text
            side: BorderSide(color: Colors.blue), // Blue border
          ),
        ),
      ),

      home: HomePage(),
    );
  }
}

