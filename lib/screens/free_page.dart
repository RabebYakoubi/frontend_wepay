import 'package:flutter/material.dart';
import 'package:frontend_wepay/utils/constants/colors.dart';

class FreePaiementPage extends StatefulWidget {
  const FreePaiementPage({super.key});

  @override
  State<FreePaiementPage> createState() => _FreePaiementPageState();
}

class _FreePaiementPageState extends State<FreePaiementPage> {
String amount = "0";

void addDigit(String digit) {
  setState(() {
    if (amount == "0" && digit != ".") {
      amount = digit;
    } else {
      amount += digit;
    }
  });
}

void deleteLastDigit() {
  setState(() {
    if (amount.length <= 1) {
      amount = "0";
    } else {
      amount = amount.substring(0, amount.length - 1);
    }
  });
}

void validateAmount() {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // L'image en haut
            Image.asset(
              'assets/images/WePay-Logo-mini.png',
              height: 100,
            ),
            const SizedBox(height: 16),
            // Le texte
            Text(
              'Wave Card',
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Image.asset(
              'assets/icons/sans-contact.png',
                height: 150, // augmente la hauteur
                width: 150,  // optionnel, pour forcer une largeur
                fit: BoxFit.contain,
            ),
          ],
        ),
      );
    },
  );
}


Widget buildNumberPad() {
  final List<String> keys = [
    '1', '2', '3',
    '4', '5', '6',
    '7', '8', '9',
    '.', '0', '→'
  ];

  return Expanded(
    child: GridView.builder(
      padding: const EdgeInsets.only(top: 60),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.5, // largeur / hauteur
      ),
      itemCount: keys.length,
      itemBuilder: (context, index) {
        final key = keys[index];
        return ElevatedButton(
          onPressed: () {
            if (key == '→') {
              validateAmount();
            } else {
              addDigit(key);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: TColors.buttonPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(20),
          ),
          child: Text(
            key,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        );
      },
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Transfer",
            style: Theme.of(context).textTheme.headlineMedium!,
),
        actions: [
          IconButton(icon: Icon(Icons.home), onPressed: () {}),
          IconButton(icon: Icon(Icons.person), onPressed: () {}),
        ],
      ),
      backgroundColor: TColors.kPrimaryColorLight,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Text(
                    "Enter amount",
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "$amount TND",
                          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: deleteLastDigit,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[600],
                            ),
                            padding: const EdgeInsets.all(10),
                            child: const Icon(
                              Icons.backspace,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Please enter the amount you want to transfer",
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),

                  const SizedBox(height: 20),
                  buildNumberPad(),
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
