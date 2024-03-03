import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/authenticate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyANVe5qPZyiNjYG0yhxZdcjeGhFAs_lG4E',
    appId: '1:401882858246:android:f3e2d20e39b85f434fd487',
    messagingSenderId: '401882858246',
    projectId: 'chatapp-263df',
    storageBucket: 'chatapp-263df.appspot.com',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Authenticate(
            // key: null,
            ));
  }
}
