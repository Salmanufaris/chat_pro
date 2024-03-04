import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/views/ac_create_screen.dart';

import 'package:flutter_application_1/views/home_screen.dart';

// ignore: use_key_in_widget_constructors
class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return const Homepage();
    } else {
      return const Create();
    }
  }
}
