import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset("assets/images/logApp.png", height: 30),
        actions: [
          IconButton(icon: Icon(Icons.home), onPressed: () {}),
          IconButton(icon: Icon(Icons.person), onPressed: () {}),
        ],
      ),
      body: Center(child: Text('Content here')),
    );
  }
}