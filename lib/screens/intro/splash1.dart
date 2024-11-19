import 'dart:async';

import 'package:flutter/material.dart';

import 'splash2.dart';

class Splash1 extends StatefulWidget {
  const Splash1({super.key});

  @override
  State<Splash1> createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {
  double _planePositionX = -100; // 비행기 초기 위치

  @override
  void initState() {
    super.initState();

    // 비행기 애니메이션 시작
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _planePositionX = MediaQuery.of(context).size.width; // 화면 밖으로 이동
      });
    });

    // 5초 후 화면 전환
    Timer(const Duration(milliseconds: 5000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Splash2()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100], // 하늘 배경색
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    width: 220,
                    child: Image.asset('assets/logo.png'), // 제미재미 Jeme-Zemi
                  ),
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(seconds: 4),
            curve: Curves.easeInOut,
            left: _planePositionX,
            top: MediaQuery.of(context).size.height * 0.3, // 비행기 높이
            child: SizedBox(
              width: 100, // 비행기 크기
              child: Image.asset('assets/plane.png'), // 비행기 이미지
            ),
          ),
        ],
      ),
    );
  }
}
