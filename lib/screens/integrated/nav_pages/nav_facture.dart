import 'package:flutter/material.dart';
import 'package:frontend_wepay/screens/integrated/component/form_facture.dart';
import 'package:frontend_wepay/utils/constants/colors.dart';

class NavFacturePage extends StatelessWidget {
  const NavFacturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.kPrimaryColorLight,
      body: Column(
        children: [
          Text("Invoices", style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    labelText: 'Search',
                    prefixIcon: const Icon(Icons.search_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  print("Search submitted");
                },
                child: Text(
                  "OK",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: TColors.kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFilterChip("September"),
              _buildFilterChip("Q3"),
              _buildFilterChip("2020"),
              _buildSelectedChip("Proforma"),
              _buildSelectedChip("Paid"),
              _buildSelectedChip("To Collect"),
              _buildFilterChip("Overdue"),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildDateLabel("AUGUST 2020"),
                _buildInvoiceCard("Rose Martin", "2020-08-03", "03 August", "€41.50", true),
                _buildInvoiceCard("Andy Warhol", "2020-08-01", "01 August", "€33.50", true),
                _buildDateLabel("JULY 2020"),
                _buildInvoiceCard("Andy Wendt", "2020-07-12", "24 July", "€714.00", true),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                  ),
                  builder: (BuildContext context) {
                    return const InvoiceFormSheet();
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "New Invoice",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) => Chip(
        label: Text(label),
        backgroundColor: Colors.grey.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      );

  Widget _buildSelectedChip(String label) => Chip(
        label: Text(label, style: const TextStyle(color: Colors.white)),
        backgroundColor: TColors.kPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      );

  Widget _buildDateLabel(String label) => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 8),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
        ),
      );

  Widget _buildInvoiceCard(String name, String id, String date, String amount, bool isPaid) => Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("#$id · $date"),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Paid",
                  style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      );
}
