import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController cpass = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    cpass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(
                label: Text("Email"),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: pass,
              obscureText: true,
              decoration: const InputDecoration(
                label: Text("Password"),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: cpass,
              obscureText: true,
              decoration: const InputDecoration(
                label: Text("Confirm Password"),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Registered")));
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}