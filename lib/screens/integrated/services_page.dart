import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend_wepay/screens/integrated/route_pages.dart';
import 'package:frontend_wepay/utils/constants/colors.dart';

class ServicesPage extends StatefulWidget {
  final int numberOfServices;

  const ServicesPage({super.key, required this.numberOfServices, });

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  late List<TextEditingController> _labelControllers;
  late List<TextEditingController> _pathControllers;
  late List<TextEditingController> _paramKeyControllers;
  late List<TextEditingController> _paramValueControllers;
  late List<TextEditingController> _jsonBodyControllers;
  late List<String?> _selectedMethods;
  late List<String?> _selectedServiceTypes;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _labelControllers = List.generate(widget.numberOfServices, (_) => TextEditingController());
    _pathControllers = List.generate(widget.numberOfServices, (_) => TextEditingController());
    _paramKeyControllers = List.generate(widget.numberOfServices, (_) => TextEditingController());
    _paramValueControllers = List.generate(widget.numberOfServices, (_) => TextEditingController());
    _jsonBodyControllers = List.generate(widget.numberOfServices, (_) => TextEditingController());
    _selectedMethods = List.generate(widget.numberOfServices, (_) => null);
    _selectedServiceTypes = List.generate(widget.numberOfServices, (_) => null);

  }

  @override
  void dispose() {
    for (var controller in _labelControllers) {
      controller.dispose();
    }
    for (var controller in _pathControllers) {
      controller.dispose();
    }
    for (var controller in _paramKeyControllers) {
      controller.dispose();
    }
    for (var controller in _paramValueControllers) {
      controller.dispose();
    }
    for (var controller in _jsonBodyControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.kPrimaryColorLight,
      appBar: AppBar(
        title: Text("Services", style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ...List.generate(widget.numberOfServices, (index) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    elevation: 3,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Label centré avec largeur réduite
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 200,
              child: TextFormField(
                controller: _labelControllers[index],
                decoration: InputDecoration(
                  labelText: "Label",
                  prefixIcon: const Icon(Icons.label),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: RequiredValidator(errorText: "Label is required"),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Dropdown à gauche + titre
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Service ${index + 1}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: _selectedServiceTypes[index],
                items: ['Load item', 'Save new item', 'Configure item', 'Remove item']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedServiceTypes[index] = value!;
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Path input
          TextFormField(
            controller: _pathControllers[index],
            decoration: InputDecoration(
              labelText: "Path",
              prefixIcon: const Icon(Icons.link),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            validator: RequiredValidator(errorText: "Path is required"),
          ),
          const SizedBox(height: 10),

          // Method dropdown
          DropdownButtonFormField<String>(
            value: _selectedMethods[index],
            items: ['GET', 'POST', 'PUT', 'DELETE']
                .map((method) => DropdownMenuItem(value: method, child: Text(method)))
                .toList(),
            decoration: InputDecoration(
              labelText: "Method",
              prefixIcon: const Icon(Icons.http),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onChanged: (value) {
              setState(() {
                _selectedMethods[index] = value;
              });
            },
            validator: (value) => value == null ? "Please select a method" : null,
          ),
          const SizedBox(height: 10),

          // Param key/value pour GET, PUT, DELETE
          if (_selectedMethods[index] == 'GET' ||
              _selectedMethods[index] == 'PUT' ||
              _selectedMethods[index] == 'DELETE') ...[
            TextFormField(
              controller: _paramKeyControllers[index],
              decoration: InputDecoration(
                labelText: "Parameter Key",
                prefixIcon: const Icon(Icons.vpn_key),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _paramValueControllers[index],
              decoration: InputDecoration(
                labelText: "Parameter Value",
                prefixIcon: const Icon(Icons.text_fields),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],

          // JSON Body pour POST, PUT
          if (_selectedMethods[index] == 'POST' ||
              _selectedMethods[index] == 'PUT') ...[
            const SizedBox(height: 10),
            TextFormField(
              controller: _jsonBodyControllers[index],
              maxLines: 5,
              decoration: InputDecoration(
                labelText: "JSON Body",
                prefixIcon: const Icon(Icons.code),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ],
      ),
    ),
  );
}),

              const SizedBox(height: 20),
              Align(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      print("Service validée");
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RoutePages()),
                          );
                    } else {
                      print("Erreur de validation");
                    }
                  },
                  child: const Text(
                    "Finish",
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
