import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:misson_0/screens/home/setting.dart';

import 'history.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _questions = [
    {"text": "이름이 무엇인가요?", "type": "text"},
    // (생략된 질문들)
  ];

  int _currentQuestionIndex = 0;
  final Map<int, String> _answers = {};
  final TextEditingController _textController = TextEditingController();

  void _nextQuestion([String? response]) {
    setState(() {
      if (response != null) {
        _answers[_currentQuestionIndex] = response;
      }

      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _textController.clear();
      } else {
        _showCompletionDialog();
      }
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("질문 완료"),
          content: const Text("모든 질문이 완료되었습니다!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _currentQuestionIndex = 0;
                  _answers.clear();
                  _textController.clear();
                });
              },
              child: const Text("처음으로"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HistoryPage()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Menu()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 200),
            Expanded(
              flex: 3,
              child: Center(
                child: Lottie.asset(
                  'assets/Animation - 1732720971734.json',
                  width: 350,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                currentQuestion["text"] as String,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue.shade700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            if (currentQuestion["type"] == "text")
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: const InputDecoration(
                          labelText: "답변을 입력하세요",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_textController.text.isNotEmpty) {
                          _nextQuestion(_textController.text);
                        }
                      },
                      child: const Text("다음"),
                    ),
                  ],
                ),
              )
            else if (currentQuestion["type"] == "choice")
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: (currentQuestion["choices"] as List<String>)
                    .map((choice) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ElevatedButton(
                            onPressed: () => _nextQuestion(choice),
                            child: Text(choice),
                          ),
                        ))
                    .toList(),
              )
            else if (currentQuestion["type"] == "next")
              Center(
                child: ElevatedButton(
                  onPressed: () => _nextQuestion(),
                  child: const Text("다음"),
                ),
              ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
