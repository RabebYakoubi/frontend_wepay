import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend_wepay/screens/launch/signup_page.dart';
import 'package:frontend_wepay/utils/constants/colors.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  late TextEditingController _emailController;
  late GlobalKey<FormState> _formkey;

  @override
  void initState() {
    _emailController = TextEditingController();
    _formkey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.kPrimaryColor,
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(height: 90),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Forget Password",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                color: TColors.kLightGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 50),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: TColors.kLightGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                          Text(
                          "Email",
                          style: Theme.of(context).textTheme.titleMedium!,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: "email@example.com",
                            prefixIcon: const Icon(Icons.email_outlined),
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Email is required"),
                            EmailValidator(errorText: "Enter a valid email"),
                          ]),
                        ),
                
                        const SizedBox(height: 80),
                        Align(
                          child: ElevatedButton(
                            onPressed: () {
                                if (_formkey.currentState!.validate()) {
                              //     Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => const SecurityPage()),
                              // );
                                  print("Success");
                                } else {
                                  print("Failure");
                                }
                            },
                            child: const Text(
                              "Next Step",
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: TextButton(
                            onPressed: () {
                                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignupPage()),
                      );
                            },
                            child:  Text(
                              "Sign Up?",
                              style:Theme.of(context).textTheme.titleSmall!,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
