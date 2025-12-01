import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  void handleLogin() {
    String email = emailController.text.trim();
    String pass = passController.text.trim();

    if (email.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Enter both fields"))
      );
      return;
    }

    Navigator.pushReplacementNamed(
      context,
      "/dashboard",
      arguments: {"username": email},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,  // CENTER CONTENT
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    label: Text("Email"),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text("Password"),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: handleLogin,
                  child: const Text("Login"),
                ),

                const SizedBox(height: 20),

                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "New user? ",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: "Register here",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, "/register");
                            },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}