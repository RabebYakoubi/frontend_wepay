import 'package:flutter/material.dart';
import 'package:frontend_wepay/screens/integrated/configuration_page.dart';
import 'package:frontend_wepay/screens/integrated/route_pages.dart';
import 'package:frontend_wepay/utils/theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home:  const ConfigurationPage(),
    );
  }
}



