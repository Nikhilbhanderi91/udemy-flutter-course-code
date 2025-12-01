// lib/screen/home_screen.dart


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final salaryController = TextEditingController();

  final FirebaseServices service = FirebaseServices();
  String? selectedId;

  void clearFields() {
    nameController.clear();
    cityController.clear();
    salaryController.clear();
    selectedId = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Management")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: cityController,
                  decoration: const InputDecoration(labelText: "City"),
                ),
                TextField(
                  controller: salaryController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Salary"),
                ),
                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        cityController.text.isNotEmpty &&
                        salaryController.text.isNotEmpty) {
                      
                      if (selectedId == null) {
                        service.addUser(
                          nameController.text,
                          cityController.text,
                          int.parse(salaryController.text),
                        );
                      } else {
                        service.updateUser(
                          selectedId!,
                          nameController.text,
                          cityController.text,
                          int.parse(salaryController.text),
                        );
                      }

                      clearFields();
                    }
                  },
                  child: Text(selectedId == null ? "Add User" : "Update User"),
                ),
              ],
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: service.readUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No Users Found"));
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, i) {
                    final doc = docs[i];
                    final data = doc.data() as Map<String, dynamic>;

                    return Card(
                      child: ListTile(
                        title: Text(data['name']),
                        subtitle: Text("${data['city']} • ₹${data['salary']}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // EDIT BUTTON
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                setState(() {
                                  selectedId = doc.id;
                                  nameController.text = data['name'];
                                  cityController.text = data['city'];
                                  salaryController.text =
                                      data['salary'].toString();
                                });
                              },
                            ),
                            // DELETE BUTTON
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                service.deleteUser(doc.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
