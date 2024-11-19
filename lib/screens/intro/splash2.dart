import 'package:flutter/material.dart';

import '../home/app.dart';

class Splash2 extends StatefulWidget {
  const Splash2({super.key});

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            children: const [
              _SplashPage(
                imagePath: 'assets/logo.png',
                mainText: '제미재미 JeMe-ZeMi',
                subText: 'Jesus & Me, #Zero Misson',
              ),
              _SplashPage(
                imagePath: 'assets/world.png',
                mainText: '시작해볼까요?',
                subText: '당신의 미션트립에 함께할게요',
              ),
            ],
          ),
          Positioned(
            bottom: 150,
            child: _PageIndicator(
              pageCount: 2,
              currentPage: _currentPage,
            ),
          ),
          if (_currentPage == 1)
            Positioned(
              bottom: 60,
              child: _StartButton(onPressed: () {}),
            ),
        ],
      ),
    );
  }
}

class _SplashPage extends StatelessWidget {
  final String imagePath;
  final String mainText;
  final String subText;

  const _SplashPage({
    required this.imagePath,
    required this.mainText,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 220),
        Image.asset(imagePath, width: 350, height: 250),
        const SizedBox(height: 30),
        Text(
          mainText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          subText,
          style: const TextStyle(fontSize: 15, color: Colors.black),
        ),
      ],
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final int pageCount;
  final int currentPage;

  const _PageIndicator({
    required this.pageCount,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentPage
                ? Theme.of(context).primaryColor
                : Colors.grey,
          ),
        ),
      ),
    );
  }
}

class _StartButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _StartButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // HomePage로 네비게이트
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      },
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13.0),
        ),
        minimumSize: const Size(330, 60),
      ),
      child: const Text(
        '시작하기',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
