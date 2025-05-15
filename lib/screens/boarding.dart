import 'package:flutter/material.dart';
import 'package:frontend_wepay/screens/home_page.dart';
import '../controllers/onboarding_controller.dart';
import 'package:frontend_wepay/utils/constants/colors.dart';

class BoardingView extends StatefulWidget {
  const BoardingView({super.key});

  @override
  State<BoardingView> createState() => _BoardingViewState();
}

class _BoardingViewState extends State<BoardingView> {
  final controller = OnBoardingController();
  final pageController = PageController();
  int currentPage = 0;

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: TColors.kPrimaryColor,
    body: Column(
      children: [
        const SizedBox(height: 170),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            controller.pages[currentPage].title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              color: TColors.kPrimaryColorLight,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFE8F5E9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: controller.pages.length,
                    onPageChanged: (index) =>
                        setState(() => currentPage = index),
                    itemBuilder: (context, index) {
                      final page = controller.pages[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(page.imagePath, height: 220),
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(controller.pages.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                      width: currentPage == index ? 12 : 8,
                      height: currentPage == index ? 12 : 8,
                      decoration: BoxDecoration(
                        color: currentPage == index ? TColors.kPrimaryColor : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: TextButton(
                    onPressed: () {
                      if (currentPage == controller.pages.length - 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
                      } else {
                        controller.goToNextPage(pageController, currentPage);
                      }
                    },
                    child: Text(
                      currentPage == controller.pages.length - 1
                          ? 'Get Started'
                          : 'Next',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
}
