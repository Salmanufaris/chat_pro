import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/login.dart';

Future<User?> createAccount(String name, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = userCredential.user;

    if (user != null) {
      print("Account created successfully");
      await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .set({"name": name, "email": email, "status": "unavailable"});
      return user;
    } else {
      print("Account creation failed");
      return null;
    }
  } catch (e) {
    print("Error creating account: $e");
    return null;
  }
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    User user = userCredential.user!;
    if (user != null) {
      print("Login Successful");
      return user;
    } else {
      print("Login failed");
      return null;
    }
  } catch (e) {
    print("Error Signing In: $e");
    return null;
  }
}

Future logout(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    await _auth.signOut().then((user) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Loginpage()));
    });
  } catch (e) {
    print(e);
  }
}
