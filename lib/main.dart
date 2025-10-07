import 'package:flutter/material.dart';
import 'package:todoapp/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: ToDoListScreen(),
      //home: TestScreen(),
    );
  }
}
