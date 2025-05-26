  
import 'package:flutter/material.dart';
import 'package:frontend_wepay/screens/integrated/nav_pages/nav_client.dart';
import 'package:frontend_wepay/screens/integrated/nav_pages/nav_facture.dart';
import 'package:frontend_wepay/screens/integrated/nav_pages/nav_panier.dart';
import 'package:frontend_wepay/screens/integrated/nav_pages/nav_product.dart';
import 'package:frontend_wepay/screens/profil_page.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

import '../../utils/constants/colors.dart';

class RoutePages extends StatefulWidget {
  const RoutePages({super.key});

  @override
  State<RoutePages> createState() => _RoutePagesState();
}

class _RoutePagesState extends State<RoutePages> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    NavProductPage(),
    NavPanierPage(),
    NavClientPage(),
    NavFacturePage(),
  ];
  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    bool isLight = brightness == Brightness.light;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset("assets/images/WePay-Logo-mini.png", height: 50),
          actions: [
          IconButton(icon: Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilPage()),
            );
          }),
        ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: GNav(
            gap: 10,
            padding: EdgeInsets.all(12),
            color: isLight ? TColors.secondary : TColors.kPrimaryColorLight,
            activeColor: TColors.kPrimaryColor,
            duration: Duration(milliseconds: 600),
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: [
              GButton(
                // backgroundColor: TColors.buttonDisabled,
                icon: Icons.storefront,
                text: "Product",
              ),

              GButton(
                // backgroundColor: TColors.buttonDisabled,
                icon: Icons.shopping_cart,
                text: "Shopping cart",
              ),
              GButton(
                // backgroundColor: TColors.buttonDisabled,
                icon: Icons.people,
                text: "Client",
              ),
              GButton(
                // backgroundColor: TColors.buttonDisabled,
                icon: Icons.receipt_long,
                text: "Invoice ",
              ),
            ],
          ),
        ),
        body: _pages[_selectedIndex],
      ),
    );
  }
}