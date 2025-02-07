import 'package:flutter/material.dart';
import 'package:learnlab/features/screens/canvas_page.dart';
import 'package:learnlab/features/screens/home_page.dart';
import 'package:learnlab/features/screens/navigation_menu.dart';
import 'package:learnlab/features/screens/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LearnLab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NavigationMenu(),
    );
  }
}
