import 'package:flutter/material.dart';
import '../models/onboarding_page_model.dart';

class OnBoardingController {
  final List<OnBoardingPageModel> pages = [
    OnBoardingPageModel(
      title: 'Welcome To\nExpense Manager',
      imagePath: 'assets/images/image1.png',
    ),
    OnBoardingPageModel(
      title: '¿Are You Ready To\nTake Control Of\nYour Finances?',
      imagePath: 'assets/images/image2.png',
    ),
  ];

  void goToNextPage(PageController controller, int currentPage) {
    if (currentPage < pages.length - 1) {
      controller.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut);
    }
  }
}
