import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend_wepay/utils/constants/colors.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _businessNameController;
  late TextEditingController _phoneController;
  late GlobalKey<FormState> _formkey;
  bool _isObscure = true;
  bool _isObscureConfirm = true;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _businessNameController = TextEditingController();
    _phoneController = TextEditingController();
    _formkey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _businessNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.kPrimaryColor,
      body: Column(
        children: [
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Create Account",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                color: TColors.kLightGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
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

                        // First name
                        const Text("First Name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _firstNameController,
                          decoration: _buildInputDecoration("First Name", Icons.person),
                          validator: RequiredValidator(errorText: "First name is required"),
                        ),

                        const SizedBox(height: 20),

                        // Last name
                        const Text("Last Name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _lastNameController,
                          decoration: _buildInputDecoration("Last Name", Icons.person_outline),
                          validator: RequiredValidator(errorText: "Last name is required"),
                        ),

                        const SizedBox(height: 20),

                        // Business name
                        const Text("Business Name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _businessNameController,
                          decoration: _buildInputDecoration("Business Name", Icons.business),
                          validator: RequiredValidator(errorText: "Business name is required"),
                        ),

                        const SizedBox(height: 20),

                        // Phone
                        const Text("Phone Number", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: _buildInputDecoration("Phone", Icons.phone),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Phone is required"),
                            MinLengthValidator(8, errorText: "Enter a valid phone number")
                          ]),
                        ),

                        const SizedBox(height: 20),

                        // Email
                        const Text("Email or Username", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _emailController,
                          decoration: _buildInputDecoration("Email or Username", Icons.email_outlined),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Email is required"),
                            EmailValidator(errorText: "Enter a valid email"),
                          ]),
                        ),

                        const SizedBox(height: 20),

                        // Password
                        const Text("Password", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isObscure,
                          decoration: _buildPasswordInput("Password", _isObscure, () {
                            setState(() => _isObscure = !_isObscure);
                          }),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Password is required"),
                            MinLengthValidator(8, errorText: "Minimum 8 characters"),
                            MaxLengthValidator(15, errorText: "Maximum 15 characters"),
                          ]),
                        ),

                        const SizedBox(height: 20),

                        // Confirm password
                        const Text("Confirm Password", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _isObscureConfirm,
                          decoration: _buildPasswordInput("Confirm Password", _isObscureConfirm, () {
                            setState(() => _isObscureConfirm = !_isObscureConfirm);
                          }),
                          validator: (val) {
                            if (val == null || val.isEmpty) return "Confirmation required";
                            if (val != _passwordController.text) return "Passwords do not match";
                            return null;
                          },
                        ),

                        const SizedBox(height: 60),
                        Align(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  print("Success");
                                } else {
                                  print("Failure");
                                }
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white),
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

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  InputDecoration _buildPasswordInput(String label, bool isObscure, VoidCallback toggle) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      labelText: label,
      prefixIcon: const Icon(Icons.lock),
      suffixIcon: IconButton(
        icon: Icon(isObscure ? CupertinoIcons.eye_slash : CupertinoIcons.eye),
        onPressed: toggle,
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}


