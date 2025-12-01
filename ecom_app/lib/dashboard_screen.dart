import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final String username;

  const DashboardScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: Center(
        child: Text(
          "Hi, $username 👋",
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}