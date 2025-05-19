import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend_wepay/screens/launch/boarding.dart';
import 'package:frontend_wepay/utils/constants/colors.dart';

class Launch extends StatefulWidget {
  const Launch({super.key});

  @override
  State<Launch> createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {
    @override
  void initState() {
    super.initState();
    // Attendre 3 secondes avant de passer à la page suivante
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BoardingView()),
      );
    });
}


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:TColors.kPrimaryColorLight,
        body: Center(
          child: Image.asset(
            "assets/images/WePay-Logo.png",
            width: 300,
          ),
        ),
      ),
    );
  }
}


