import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';

import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/methods.dart';
import 'package:lottie/lottie.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const Icon(Icons.arrow_back),
      ),
      body: isLoading
          ? Center(
              child: SizedBox(
                height: size.height / 20,
                width: size.width / 20,
                child: const CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(right: 120),
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      height: 70,
                      width: 200,
                      child: const Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 70),
                            child: Text(
                              "Welcome",
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Text(
                            "Create Account to Continue",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Lottie.asset(
                        "assets/animation/Animation - 1709477178313.json"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: TextFormField(
                      controller: _name,
                      decoration: InputDecoration(
                        labelText: "Name",
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: TextFormField(
                      controller: _email,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: TextFormField(
                      controller: _password,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                      // ignore: sort_child_properties_last
                      child: const Text(
                        "Create Account",
                        style: TextStyle(color: Colors.white),
                      ),
                      height: 50,
                      minWidth: 330,
                      color: Colors.black,
                      onPressed: () {
                        if (_name.text.isNotEmpty &&
                            _email.text.isNotEmpty &&
                            _password.text.isNotEmpty) {
                          setState(() {
                            isLoading = true;
                          });
                          createAccount(_name.text, _email.text, _password.text)
                              .then((user) {
                            if (user != null) {
                              setState(() {
                                isLoading = false;
                              });

                              log("Account Created Succesfully");
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Homepage()));
                            } else {
                              log("Account Created Successfulyy");
                              setState(() {
                                isLoading = false;
                              });
                            }
                          });
                        } else {
                          log("enter filds");
                        }
                      }),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Loginpage()),
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
