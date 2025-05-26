import 'dart:io';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class InvoiceFormSheet extends StatefulWidget {
  const InvoiceFormSheet({super.key});

  @override
  State<InvoiceFormSheet> createState() => _InvoiceFormSheetState();
}

class _InvoiceFormSheetState extends State<InvoiceFormSheet> {
  String? _selectedName;
  final _quantityController = TextEditingController();
  final _amountController = TextEditingController();
  final _vatController = TextEditingController();
  final _discountController = TextEditingController();
  DateTime? _selectedDate;
  File? _attachment;
  final _formKey = GlobalKey<FormState>();

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  double _calculateTotal() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    final vat = double.tryParse(_vatController.text) ?? 0;
    final discount = double.tryParse(_discountController.text) ?? 0;

    final withVAT = amount + (amount * vat / 100);
    final withDiscount = withVAT - (withVAT * discount / 100);
    return withDiscount;
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickAttachment() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) setState(() => _attachment = File(pickedFile.path));
  }

  void _showPreviewDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Invoice Preview"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Client: $_selectedName"),
              Text("Date: ${_selectedDate != null ? DateFormat.yMMMd().format(_selectedDate!) : 'Not selected'}"),
              Text("Amount (Excl. VAT): ${_amountController.text} €"),
              Text("VAT: ${_vatController.text} %"),
              Text("Discount: ${_discountController.text} %"),
              Text("Total (Incl. VAT): ${_calculateTotal().toStringAsFixed(2)} €"),
              const SizedBox(height: 10),
              _attachment != null
                  ? Image.file(_attachment!, height: 100)
                  : const Text("No attachment"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _amountController.dispose();
    _vatController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("New Invoice", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedName,
                items: ['Alice', 'Bob', 'Charlie']
                    .map((name) => DropdownMenuItem(value: name, child: Text(name)))
                    .toList(),
                decoration: _buildInputDecoration("Select Name", Icons.person),
                onChanged: (value) => setState(() => _selectedName = value),
                validator: (value) => value == null ? "Please select a name" : null,
              ),

              const SizedBox(height: 20),
              TextFormField(
                decoration: _buildInputDecoration("Product", Icons.shopping_cart),
                validator: RequiredValidator(errorText: "Required field"),
              ),

              const SizedBox(height: 20),
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: _buildInputDecoration("Quantity", Icons.confirmation_number),
                validator: RequiredValidator(errorText: "Required field"),
              ),

              const SizedBox(height: 20),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: _buildInputDecoration("Amount (Excl. VAT) (€)", Icons.euro),
                validator: RequiredValidator(errorText: "Required field"),
              ),

              const SizedBox(height: 20),
              TextFormField(
                controller: _vatController,
                keyboardType: TextInputType.number,
                decoration: _buildInputDecoration("VAT (%)", Icons.percent),
              ),

              const SizedBox(height: 20),
              TextFormField(
                controller: _discountController,
                keyboardType: TextInputType.number,
                decoration: _buildInputDecoration("Discount (%)", Icons.discount),
              ),

              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.date_range),
                title: Text(_selectedDate != null
                    ? DateFormat.yMMMd().format(_selectedDate!)
                    : "Select a date"),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _pickDate,
                ),
              ),

              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _pickAttachment,
                icon: const Icon(Icons.attach_file),
                label: const Text("Add Attachment"),
              ),
              if (_attachment != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text("Selected file: ${_attachment!.path.split('/').last}"),
                ),

              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _showPreviewDialog,
                icon: const Icon(Icons.remove_red_eye),
                label: const Text("Preview"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print("Form validated!");
                    Navigator.pop(context);
                  }
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
