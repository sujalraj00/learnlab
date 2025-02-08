import 'package:flutter/material.dart';
import 'package:learnlab/features/screens/canvas_page.dart';
import 'package:learnlab/features/screens/home_page.dart';
import 'package:learnlab/features/screens/navigation_menu.dart';
import 'package:learnlab/features/screens/settings_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
