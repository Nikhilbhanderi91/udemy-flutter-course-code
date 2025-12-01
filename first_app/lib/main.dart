import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('This is first app'),
        ),
        body: Container(
          color: Colors.amber,
          child: const Center(
            child: Text('Hello from my first app'),
          ),
        ),
      ),
    );
  }
}