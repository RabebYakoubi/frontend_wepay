import 'package:flutter/material.dart';
//import 'package:frontend_wepay/screens/launch.dart';
import 'package:frontend_wepay/screens/test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Test(),
    );
  }
}



