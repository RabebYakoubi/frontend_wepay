// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:frontend_wepay/screens/login_page.dart';
// import 'package:frontend_wepay/screens/password_page.dart';
// import 'package:frontend_wepay/utils/constants/colors.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: kLightGrey,
//         body: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 50),
//           width: double.infinity,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Image avec taille réduite
//               SizedBox(
//                 height: 110,
//                 child: Image.asset("assets/images/WePay-Logo.png"),
//               ),
//               const SizedBox(height: 70),

//               // Boutons rapprochés et centrés
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   CupertinoButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => LoginPage()),
//                       );
//                     },
//                     color: kPrimaryColor,
//                     borderRadius: BorderRadius.circular(30),
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     child: const Text(
//                       "Log In",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 23,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   CupertinoButton(
//                     onPressed: () {},
//                     color: kPrimaryColorLight,
//                     borderRadius: BorderRadius.circular(30),
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     child: const Text(
//                       "Sign Up",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 23,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 12),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => PasswordPage()),
//                       );
//                     },
//                     child: Text(
//                       "Forget Password?",
//                       style: TextStyle(
//                         color: kPrimaryColor,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
