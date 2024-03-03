import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/create.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/login.dart';

class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return Homepage();
    } else {
      return Create();
    }
  }
}
