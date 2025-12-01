// lib/services/firebase_services.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  // ADD USER
  Future<void> addUser(String name, String city, int salary) async {
    await users.add({
      'name': name,
      'city': city,
      'salary': salary,
      'createdAt': DateTime.now(), // FIXED - No NULL timestamp issue
    });
  }

  // READ USERS
  Stream<QuerySnapshot> readUsers() {
    return users.snapshots(); // FIXED - No ordering problem
  }

  // UPDATE USER
  Future<void> updateUser(
      String id, String name, String city, int salary) async {
    await users.doc(id).update({
      'name': name,
      'city': city,
      'salary': salary,
    });
  }

  // DELETE USER
  Future<void> deleteUser(String id) async {
    await users.doc(id).delete();
  }
}
