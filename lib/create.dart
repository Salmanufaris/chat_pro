import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';

import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/methods.dart';

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

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
        leading: Icon(Icons.arrow_back),
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.width / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(right: 150),
                    child: Container(
                      height: 100,
                      width: 200,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 70),
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
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _name,
                      decoration: InputDecoration(
                        labelText: "Name",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _email,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _password,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  MaterialButton(
                      child: Text(
                        "Create Account",
                        style: TextStyle(color: Colors.white),
                      ),
                      height: 50,
                      minWidth: 300,
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

                              print("Account Created Succesfully");
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Homepage()));
                            } else {
                              print("Account Created Successfulyy");
                              setState(() {
                                isLoading = false;
                              });
                            }
                          });
                        } else {
                          print("enter filds");
                        }
                      }),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Loginpage()),
                      );
                    },
                    child: Text(
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
