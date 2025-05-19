import 'package:flutter/material.dart';
import 'package:frontend_wepay/screens/launch/login_page.dart';
import 'package:frontend_wepay/screens/launch/password_page.dart';
import 'package:frontend_wepay/screens/launch/signup_page.dart';
import 'package:frontend_wepay/utils/constants/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: TColors.kLightGrey,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image avec taille réduite
              SizedBox(
                height: 110,
                child: Image.asset("assets/images/WePay-Logo.png"),
              ),
              const SizedBox(height: 70),
              // Boutons rapprochés et centrés
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    child:  Text(
                      "Log In",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: TColors.white,fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignupPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.kPrimaryColorLight,
                    ),
                    child: Text(
                      "Sign Up",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: TColors.white,fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PasswordPage()),
                      );
                    },
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                        color: TColors.kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
