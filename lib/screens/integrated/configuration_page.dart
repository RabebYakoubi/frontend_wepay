import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend_wepay/screens/integrated/services_page.dart';
import 'package:frontend_wepay/utils/constants/colors.dart';

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
  late GlobalKey<FormState> _formkey;

  bool _isObscure = true;
  //bool _isObscureConfirm = true;

  @override
  void initState() {
    super.initState();
    _labelleController = TextEditingController();
    _urlController = TextEditingController();
    _nbserviceController = TextEditingController();
    _codesecuriteController = TextEditingController();
    _selectedType = null;
    _selectedSecurityType = null;
    _formkey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _labelleController.dispose();
    _urlController.dispose();
    _nbserviceController.dispose();
    _codesecuriteController.dispose();
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

                        // Labelle
                        const Text("Label", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _labelleController,
                          decoration: _buildInputDecoration("Label", Icons.label),
                          validator: RequiredValidator(errorText: "Label is required"),
                        ),

                        const SizedBox(height: 20),

                        // Type Dropdown
                        const Text("Type", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: _selectedType,
                          items: ['Rest',' Soap', 'Graphql']
                              .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                              .toList(),
                          decoration: _buildInputDecoration("Select Type", Icons.category),
                          onChanged: (value) => setState(() => _selectedType = value),
                          validator: (value) => value == null ? "Please select a type" : null,
                        ),

                        const SizedBox(height: 20),

                      if (_selectedType == 'Rest') ...[
                        // URL
                        const Text("API URL", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _urlController,
                          decoration: _buildInputDecoration("URL", Icons.link),
                          validator: RequiredValidator(errorText: "URL is required"),
                        ),

                        const SizedBox(height: 20),

                        // Number of Services
                        const Text("Number of Services", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _nbserviceController,
                          keyboardType: TextInputType.number,
                          decoration: _buildInputDecoration("Number of Services", Icons.confirmation_number),
                          validator: RequiredValidator(errorText: "Champ requis"),
                        ),

                        const SizedBox(height: 20),

                        // Type de sécurité
                        const Text("Security Type", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: _selectedSecurityType,
                          items: ['JWT', 'OAuth2', 'API Key','Bearer']
                              .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                              .toList(),
                          decoration: _buildInputDecoration("Security Type", Icons.security),
                          onChanged: (value) => setState(() => _selectedSecurityType = value),
                          validator: (value) => value == null ? "Please select a type" : null,
                        ),

                        const SizedBox(height: 20),

                        // Code sécurité
                        _buildSecurityCodeField(),
                    ],
                        const SizedBox(height: 60),

                        Align(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                int nbServices = int.tryParse(_nbserviceController.text) ?? 0;
                                print("Configuration validée");
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  ServicesPage(numberOfServices: nbServices)),
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

  Widget _buildSecurityCodeField() {
  if (_selectedSecurityType == null) return const SizedBox();

  switch (_selectedSecurityType) {
    case 'JWT':
    case 'Bearer':
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

    case 'OAuth2':
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("OAuth2 Token",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _codesecuriteController,
                  decoration: _buildInputDecoration("Access Token", Icons.lock_outline),
                  validator: RequiredValidator(errorText: "Champ requis"),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Ici, tu peux implémenter la logique de récupération du token OAuth2 via une API.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Fetching OAuth2 token...")),
                  );
                },
                child: const Text("Get Token"),
              )
            ],
          ),
        ],
      );

    case 'API Key':
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("API Key",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          TextFormField(
            controller: _codesecuriteController,
            decoration: _buildInputDecoration("Enter API Key", Icons.vpn_key),
            validator: RequiredValidator(errorText: "Champ requis"),
          ),
        ],
      );

    default:
      return const SizedBox();
  }
}

}
