import 'package:flutter/material.dart';
import 'package:mobile_oat/src/pages/current_time_page.dart';
import 'package:mobile_oat/src/pages/welcome_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPage);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: const [
          WelcomeScreen(),
          CurrentTime()
        ],
      ),
    );
  }
}
