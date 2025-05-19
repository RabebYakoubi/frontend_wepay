import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend_wepay/utils/constants/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formkey;
  bool _isObscure = true;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formkey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.kPrimaryColor,
      body: Column(
        children: [
          const SizedBox(height: 150),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Welcome",
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
                          "Email or username",
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: "Email or username",
                            prefixIcon: const Icon(Icons.email_outlined),
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Email is required"),
                            EmailValidator(errorText: "Enter a valid email"),
                          ]),
                        ),
                        const SizedBox(height: 20),
                          Text(
                          "Password",
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? CupertinoIcons.eye_slash
                                    : CupertinoIcons.eye,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Password is required"),
                            MinLengthValidator(8,
                                errorText: "Minimum 8 characters"),
                            MaxLengthValidator(15,
                                errorText: "Maximum 15 characters"),
                          ]),
                        ),
                        const SizedBox(height: 80),
                        Align(
                          child: ElevatedButton(
                              onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                  print("Success");
                                } else {
                                  print("Failure");
                                }
                              },
                              child:  Text(
                                "Log In",
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: TColors.white),
                              ),
                            ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: TextButton(
                            onPressed: () {},
                            child:  Text(
                              "Forget Password?",
                              style:Theme.of(context).textTheme.titleSmall!.copyWith(color: TColors.dark),
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
