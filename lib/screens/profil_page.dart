import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend_wepay/screens/launch/home_page.dart';
import 'package:frontend_wepay/utils/constants/colors.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final nom = TextEditingController(text: "Yakoubi");
  final prenom = TextEditingController(text: "Rabeb");
  final phoneNum = TextEditingController(text: "50982111");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.kPrimaryColorLight,
      appBar: AppBar(
        title: Text(
          "Profil",
          style: Theme.of(context).textTheme.headlineMedium!,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
                height: 110,
                child: Image.asset("assets/images/WePay-Logo.png"),
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
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage("assets/images/user.png"),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: nom,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: "First name",
                            prefixIcon: const Icon(Icons.person_outline_rounded),
                          ),
                          validator:
                              MultiValidator([
                                RequiredValidator(
                                  errorText: "*  Please enter your First name",
                                ),
                              ]).call,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: prenom,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: "Last name",

                            prefixIcon: const Icon(Icons.person_outline_rounded),
                          ),

                          validator:
                              MultiValidator([
                                RequiredValidator(
                                  errorText: "* Please enter your Last name",
                                ),
                              ]).call,
                        ),
                        const SizedBox(height: 10),
                        IntlPhoneField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: phoneNum,
                          keyboardType: TextInputType.phone,

                          decoration: InputDecoration(labelText: 'Phone number'),

                          initialCountryCode: 'TN',
                          onChanged: (phone) {},
                          validator:
                              MultiValidator([
                                RequiredValidator(
                                  errorText: "* Please enter your Phone number",
                                ),
                              ]).call,
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.kPrimaryColorLight,
                          ),
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('User has been updated successfully.'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text('Error')));
                            }
                          },
                          child: Text("Edit my profile"),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                builder: ((context) => const HomePage()),
                              ),
                              (route) => false,
                            );
                          },
                          child: Text("Log out"),
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

  // InputDecoration _buildInputDecoration(String label, IconData icon) {
  //   return InputDecoration(
  //     filled: true,
  //     fillColor: Colors.white,
  //     labelText: label,
  //     prefixIcon: Icon(icon),
  //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
  //   );
  // }
}
