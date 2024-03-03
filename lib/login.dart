// ignore_for_file: sort_child_properties_last, sized_box_for_whitespace

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/create.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/methods.dart';
import 'package:lottie/lottie.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoding = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back))),
      body: isLoding
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
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 150),
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
                            "Login to Continue",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Lottie.asset(
                        "assets/animation/Animation - 1709477178313.json"),
                  ),
                  SizedBox(
                    height: 40,
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
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "password",
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
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                      height: 50,
                      minWidth: 340,
                      color: Colors.black,
                      onPressed: () {
                        if (_email.text.isNotEmpty &&
                            _password.text.isNotEmpty) {
                          setState(() {
                            isLoding = true;
                          });
                          logIn(_email.text, _password.text).then((user) {
                            if (user != null) {
                              setState(() {
                                isLoding = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Homepage()));
                              log("Login Succeffully");
                            } else {
                              log(" Login Failed");
                              setState(() {
                                isLoding = false;
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
                                builder: (context) => const Create()));
                      },
                      child: const Text("Creat Account"))
                ],
              ),
            ),
    );
  }
}
