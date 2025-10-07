import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: ClampingScrollPhysics(),
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(title: Text(index.toString()));
        },
      ),
    );
  }
}
