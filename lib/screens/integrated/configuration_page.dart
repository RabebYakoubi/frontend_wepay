import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend_wepay/screens/integrated/services_page.dart';
import 'package:frontend_wepay/utils/constants/colors.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants/save.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  late TextEditingController _labelleController;
  late String? _selectedType;
  late TextEditingController _urlController;
  late TextEditingController _nbserviceController;
  late String? _selectedSecurityType;
  late TextEditingController _codesecuriteController;
  late TextEditingController _consumerKeyController;
  late TextEditingController _consumerSecretController;
  late GlobalKey<FormState> _formkey;

  bool _isObscure = true;


  void initializevalue()async{
  setState(() {
    _labelleController.text = 'Aziza';
    _selectedType = 'Rest';
    _urlController.text = 'https://fakestoreapi.com/';
    _nbserviceController.text = '1';
    _selectedSecurityType = 'JWT';

  });

  }


final _storage = FlutterSecureStorage();

  Future<void> clearServiceData() async {
    await _storage.delete(key: 'services_data');
    await SecureStorageHelper.clearAll();

    setState(() {});
  }



  @override
  void initState() {
    super.initState();
    _labelleController = TextEditingController();
    _urlController = TextEditingController();
    _nbserviceController = TextEditingController();
    _codesecuriteController = TextEditingController();
    _consumerKeyController = TextEditingController();
    _consumerSecretController = TextEditingController();
    _selectedType = null;
    _selectedSecurityType = null;
    _formkey = GlobalKey<FormState>();
    initializevalue();
  }

  @override
  void dispose() {
    _labelleController.dispose();
    _urlController.dispose();
    _nbserviceController.dispose();
    _codesecuriteController.dispose();
    _consumerKeyController.dispose();
    _consumerSecretController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.kPrimaryColor,
      appBar: AppBar(
        title: Text(
          "Configure API",
          style: Theme.of(context).textTheme.headlineMedium!,
        ),
      ),
      body: Column(
        children: [
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
                        const Text("Label", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _labelleController,
                          decoration: _buildInputDecoration("Label", Icons.label),
                          validator: RequiredValidator(errorText: "Label is required"),
                        ),
                        const SizedBox(height: 20),
                        const Text("Type", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: _selectedType,
                          items: ['Rest', 'Soap', 'Graphql']
                              .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                              .toList(),
                          decoration: _buildInputDecoration("Select Type", Icons.category),
                          onChanged: (value) => setState(() => _selectedType = value),
                          validator: (value) => value == null ? "Please select a type" : null,
                        ),
                        const SizedBox(height: 20),

                        if (_selectedType == 'Rest') ...[

                          const Text("API URL", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          TextFormField(
                            controller: _urlController,
                            decoration: _buildInputDecoration("URL", Icons.link),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer l\'URL';
                              }
                              if (!value.startsWith('http://') && !value.startsWith('https://')) {
                                return 'The URL must start with http:// or https://';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 20),
                          const Text("Number of Services", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _nbserviceController,
                            keyboardType: TextInputType.number,
                            decoration: _buildInputDecoration("Number of Services", Icons.confirmation_number),
                            validator: RequiredValidator(errorText: "Champ requis"),
                          ),

                          const SizedBox(height: 20),
                          const Text("Security Type", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            value: _selectedSecurityType,
                            items: ['JWT', 'OAuth 1.0', 'OAuth 2.0', 'API Key', 'Bearer Token', 'Basic Auth', 'No Auth']
                                .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                                .toList(),
                            decoration: _buildInputDecoration("Security Type", Icons.security),
                            onChanged: (value) => setState(() => _selectedSecurityType = value),
                            validator: (value) => value == null ? "Please select a type" : null,
                          ),
                          const SizedBox(height: 20),
                          _buildAuthFields(),
                        ],
                        const SizedBox(height: 60),
                        Align(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                print('inside the valoidation');

                                int nbServices = int.tryParse(_nbserviceController.text) ?? 0;
                                print("Configuration validée");

                                if (_selectedType == 'Rest') {
                                  final url = _urlController.text;
                                  final headers = {
                                    'Authorization': _selectedSecurityType == 'Bearer' || _selectedSecurityType == 'JWT'
                                        ? 'Bearer ${_codesecuriteController.text}'
                                        : _selectedSecurityType == 'API Key'
                                            ? 'Api-Key ${_codesecuriteController.text}'
                                            : '',
                                  };

                                  try {
                                    // final response = await http.get(Uri.parse(url), headers: headers);
                                    final response = await http.get(
                                      Uri.parse(url),
                                      // body: body,
                                      headers: headers,
                                    ).timeout(const Duration(seconds: 20));
                                    if (response.statusCode == 200){
                                      print('the api is fine with ${response.statusCode} Status code');
                                    }else {
                                      print('the api failed');
                                    }


                                  } catch (e) {
                                    print('Erreur lors de l\'appel API : $e');
                                  }
                                }




                                await clearServiceData();



                                await SecureStorageHelper.save('labelle', _labelleController.text);
                                await SecureStorageHelper.save('type', _selectedType ?? "");
                                await SecureStorageHelper.save('url',  _urlController.text);
                                await SecureStorageHelper.save('nbservice', _nbserviceController.text);
                                await SecureStorageHelper.save('securityType', _selectedSecurityType?? '');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ServicesPage(numberOfServices: nbServices),
                                  ),
                                );
                              } else {
                                print("Erreur de validation");
                              }




                            },
                            child: const Text(
                              "Save",
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

  // Ajoute cette méthode dans ton _ConfigurationPageState

Widget _buildAuthFields() {
  switch (_selectedSecurityType) {
    case 'No Auth':
      return const SizedBox();

    case 'API Key':
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Key"),
          TextFormField(
            controller: _consumerKeyController,
            decoration: _buildInputDecoration("Key", Icons.key),
          ),
          const SizedBox(height: 10),
          const Text("Value"),
          TextFormField(
            controller: _codesecuriteController,
            decoration: _buildInputDecoration("Value", Icons.code),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: "Header",
            items: ["Header", "Query Param"]
                .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                .toList(),
            onChanged: (value) {},
            decoration: _buildInputDecoration("Add to", Icons.tune),
          )
        ],
      );

case 'Bearer Token':
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Token ${_selectedSecurityType!}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          TextFormField(
            controller: _codesecuriteController,
            obscureText: _isObscure,
            decoration: _buildPasswordInput("Token", _isObscure, () {
              setState(() => _isObscure = !_isObscure);
            }),
            validator: RequiredValidator(errorText: "Champ requis"),
          ),
        ],
      );

    case 'Basic Auth':
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Username"),
          TextFormField(
            controller: _consumerKeyController,
            decoration: _buildInputDecoration("Username", Icons.person),
          ),
          const SizedBox(height: 10),
          const Text("Password"),
          TextFormField(
            controller: _consumerSecretController,
            obscureText: _isObscure,
            decoration: _buildPasswordInput("Password", _isObscure, () {
              setState(() => _isObscure = !_isObscure);
            }),
          ),
        ],
      );

    case 'OAuth 1.0':
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Consumer Key"),
          TextFormField(
            controller: _consumerKeyController,
            decoration: _buildInputDecoration("Consumer Key", Icons.key),
          ),
          const Text("Consumer Secret"),
          TextFormField(
            controller: _consumerSecretController,
            decoration: _buildInputDecoration("Consumer Secret", Icons.lock),
          ),
          const Text("Access Token"),
          TextFormField(
            controller: _codesecuriteController,
            decoration: _buildInputDecoration("Access Token", Icons.token),
          ),
        ],
      );

    case 'OAuth 2.0':
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Access Token"),
          TextFormField(
            controller: _codesecuriteController,
            decoration: _buildInputDecoration("Access Token", Icons.token),
          ),
        ],
      );

    case 'JWT':
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Access Token (JWT)"),
      TextFormField(
        controller: _codesecuriteController,
        decoration: _buildInputDecoration("Access Token", Icons.vpn_key),
      ),
      const SizedBox(height: 10),
      const Text("Refresh Token (optionnel)"),
      TextFormField(
        decoration: _buildInputDecoration("Refresh Token", Icons.refresh),
      ),
      const SizedBox(height: 10),
      const Text("Expiration (en secondes)"),
      TextFormField(
        decoration: _buildInputDecoration("Expires In", Icons.timer),
        keyboardType: TextInputType.number,
      ),
    ],
  );

  


    default:
      return const SizedBox();
  }
}


}
