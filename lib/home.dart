import 'package:flutter/material.dart';
import 'package:flutter_application_1/methods.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(Icons.logout)),
        title: Text("Homescreen"),
        centerTitle: true,
      ),
    );
  }
}
