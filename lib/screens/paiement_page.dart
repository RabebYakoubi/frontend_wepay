import 'package:flutter/material.dart';
import 'package:frontend_wepay/screens/free/free_page.dart';
import 'package:frontend_wepay/screens/integrated/configuration_page.dart';
import 'package:frontend_wepay/utils/constants/colors.dart';

class PaiementPage extends StatefulWidget {
  const PaiementPage({super.key});

  @override
  State<PaiementPage> createState() => _PaiementPageState();
}

class _PaiementPageState extends State<PaiementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.kPrimaryColorLight,
      body: Column(
        children: [
          const SizedBox(height: 150),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Image.asset(
                "assets/images/WePay-Logo.png",
                width: 300,
              ),
            ),
          ),
          const SizedBox(height: 70),
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
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 120),
                    ElevatedButton(
                      onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FreePaiementPage()),
                      );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 70),
                      ),
                      child: Text(
                        "Free Payment",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: TColors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Show a dialog
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Select a component"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.business),
                                  title: const Text("CRM"),
                                  onTap: () {
                                    Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                          MaterialPageRoute(
                                          builder: (context) => ConfigurationPage(),)
                                      );
                                  },
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.point_of_sale),
                                  title: const Text("Caisse"),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 70),
                      ),
                      child: Text(
                        "Integrated Payment",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: TColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
