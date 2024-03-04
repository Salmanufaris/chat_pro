// ignore_for_file: no_leading_underscores_for_local_identifiers, deprecated_member_use, avoid_print, unnecessary_null_comparison

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/login_screen.dart';

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
      log("Account created successfully");
      user.updateProfile(displayName: name);

      await _firestore.collection("users").doc(_auth.currentUser!.uid).set({
        "name": name,
        "email": email,
        "status": "unavailable",
        "uid": _auth.currentUser!.uid,
      });
      return user;
    } else {
      log("Account creation failed");
      return null;
    }
  } catch (e) {
    log("Error creating account: $e");
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
      log("Login Successful");
      return user;
    } else {
      log("Login failed");
      return null;
    }
  } catch (e) {
    log("Error Signing In: $e");
    return null;
  }
}

Future logout(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    await _auth.signOut().then((user) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Loginpage()));
    });
  } catch (e) {
    print(e);
  }
}
