import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("History")),
      body: const Center(
        child: Text("히스토리 내용이 여기에 표시됩니다."),
      ),
    );
  }
}
