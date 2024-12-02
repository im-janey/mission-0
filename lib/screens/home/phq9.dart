import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:misson_0/screens/home/phq9_history.dart';

import 'setting.dart';

class PHQ9Page extends StatefulWidget {
  const PHQ9Page({super.key});

  @override
  State<PHQ9Page> createState() => _PH9PageState();
}

class _PH9PageState extends State<PHQ9Page> {
  final List<Map<String, dynamic>> _questions = [
    {"text": "이름이 무엇인가요?", "type": "text"},
    {"text": "나이가 몇 살인가요?", "type": "text"},
    {
      "text": "성별이 어떻게 되나요?",
      "type": "choice",
      "choices": ["남성", "여성", "기타"]
    },
    {
      "text": "예수님 믿으세요?",
      "type": "choice",
      "choices": ["네", "아니요"]
    },
    {
      "text": "1) 일 또는 여가 활동을 하는 데 흥미나 즐거움을 느끼지 못함",
      "type": "choice",
      "choices": [
        "전혀 방해 받지 않았다",
        "며칠 동안 방해 받았다",
        "7일 이상 방해 받았다",
        "거의 매일 방해 받았다"
      ]
    },
    {
      "text": "2) 기분이 가라앉거나, 우울하거나, 희망이 없음",
      "type": "choice",
      "choices": [
        "전혀 방해 받지 않았다",
        "며칠 동안 방해 받았다",
        "7일 이상 방해 받았다",
        "거의 매일 방해 받았다"
      ]
    },
    {
      "text": "3) 잠이 들거나 계속 잠을 자는 것이 어려움, 또는 잠을 너무 많이 잠",
      "type": "choice",
      "choices": [
        "전혀 방해 받지 않았다",
        "며칠 동안 방해 받았다",
        "7일 이상 방해 받았다",
        "거의 매일 방해 받았다"
      ]
    },
    {
      "text": "4) 피곤하다고 느끼거나 기운이 거의 없음",
      "type": "choice",
      "choices": [
        "전혀 방해 받지 않았다",
        "며칠 동안 방해 받았다",
        "7일 이상 방해 받았다",
        "거의 매일 방해 받았다"
      ]
    },
    {
      "text": "5) 입맛이 없거나 과식을 함",
      "type": "choice",
      "choices": [
        "전혀 방해 받지 않았다",
        "며칠 동안 방해 받았다",
        "7일 이상 방해 받았다",
        "거의 매일 방해 받았다"
      ]
    },
    {
      "text": "6) 자신을 부정적으로 봄. 혹은 자신이 실패자라고 느끼거나 자신 또는 가족을 실망시킴",
      "type": "choice",
      "choices": [
        "전혀 방해 받지 않았다",
        "며칠 동안 방해 받았다",
        "7일 이상 방해 받았다",
        "거의 매일 방해 받았다"
      ]
    },
    {
      "text": "7) 신문을 읽거나 텔레비전 보는 것과 같은 일에 집중하는 것이 어려움",
      "type": "choice",
      "choices": [
        "전혀 방해 받지 않았다",
        "며칠 동안 방해 받았다",
        "7일 이상 방해 받았다",
        "거의 매일 방해 받았다"
      ]
    },
    {
      "text":
          "8) 다른 사람들이 주목할 정도로 너무 느리게 움직이거나 말을 함. 또는 반대로 평상시보다 많이 움직여서, 너무 안절부절못하거나 들떠 있음",
      "type": "choice",
      "choices": [
        "전혀 방해 받지 않았다",
        "며칠 동안 방해 받았다",
        "7일 이상 방해 받았다",
        "거의 매일 방해 받았다"
      ]
    },
    {
      "text": "9) 자신이 죽는 것이 더 낫다고 생각하거나 어떤 식으로든 자신을 해칠 것이라고 생각함",
      "type": "choice",
      "choices": [
        "전혀 방해 받지 않았다",
        "며칠 동안 방해 받았다",
        "7일 이상 방해 받았다",
        "거의 매일 방해 받았다"
      ]
    },
    {
      "text": "진단 결과",
      "type": "result",
      "calculate": (answers) {
        // 사용자 응답에 기반하여 점수를 계산합니다.
        int score = 0;
        for (int i = 4; i <= 12; i++) {
          final choice = answers[i] ?? "";
          if (choice == "며칠 동안 방해 받았다") score += 1;
          if (choice == "7일 이상 방해 받았다") score += 2;
          if (choice == "거의 매일 방해 받았다") score += 3;
        }
        if (score < 5) {
          return "현재 상태는 양호합니다.";
        } else if (score < 10) {
          return "경미한 우울감이 느껴질 수 있습니다.";
        } else {
          return "전문가와 상담이 필요할 수 있습니다.";
        }
      }
    },
    {"text": "기도제목이 있다면 무엇인가요?", "type": "text"},
    {
      "text": "다시 한번 묻겠습니다. 예수님 믿으세요?",
      "type": "choice",
      "choices": ["네", "아니요"]
    },
  ];

  int _currentQuestionIndex = 0;
  final Map<int, String> _answers = {};
  final TextEditingController _textController = TextEditingController();

  final Map<String, int> _scoreMap = {
    "전혀 방해 받지 않았다": 0,
    "며칠 동안 방해 받았다": 1,
    "7일 이상 방해 받았다": 2,
    "거의 매일 방해 받았다": 3,
  };

  /// 다음 질문으로 이동
  void _handleNextQuestion([String? response]) {
    if (response != null) {
      _answers[_currentQuestionIndex] = response;
    }

    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _textController.clear();
      } else {
        _saveToFirestore(); // 모든 질문 완료 시 Firestore에 저장
      }
    });
  }

  Future<void> _saveToFirestore() async {
    try {
      final int totalScore = _calculateTotalScore();
      final String diagnosis = _getDiagnosis(totalScore);

      // Firestore에 데이터를 저장
      await FirebaseFirestore.instance.collection('phq9_responses').add({
        'responses':
            _answers.map((key, value) => MapEntry(key.toString(), value)),
        'totalScore': totalScore,
        'diagnosis': diagnosis,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // 진단 결과 대화상자 표시
      _showFinalScoreDialog(totalScore, diagnosis);
    } catch (e) {
      print("Error saving to Firestore: $e");
    }
  }

  /// 총 점수 계산
  int _calculateTotalScore() {
    return _answers.entries
        .where((entry) => _scoreMap.containsKey(entry.value))
        .fold(0, (sum, entry) => sum + (_scoreMap[entry.value] ?? 0));
  }

  /// 진단 결과 가져오기
  String _getDiagnosis(int score) {
    if (score < 5) return "우울증 없음";
    if (score < 10) return "경증 우울증";
    if (score < 15) return "중등도 우울증";
    if (score < 20) return "중등도-중증 우울증";
    return "중증 우울증";
  }

  /// 결과 다이얼로그 표시
  void _showFinalScoreDialog(int totalScore, String diagnosis) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("결과 확인"),
          content: Text(
            "총 점수: $totalScore\n진단 결과: $diagnosis",
            style: const TextStyle(fontSize: 18),
          ),
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
              MaterialPageRoute(builder: (context) => const PHQ9History()),
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
      body:
          // 캐릭터와 질문 영역
          Center(
        child: Column(
          children: [
            const SizedBox(height: 200),
            // 말풍선 카드
            Stack(
              alignment: Alignment.topCenter,
              children: [
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
              ],
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
                        _handleNextQuestion(
                            _textController.text); // 비어있어도 넘어가도록 설정
                      },
                      child: const Text("다음"),
                    ),
                  ],
                ),
              )
            else if (currentQuestion["type"] == "choice")
              Column(
                children: (currentQuestion["choices"] as List<String>)
                    .map(
                      (choice) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ElevatedButton(
                          onPressed: () => _handleNextQuestion(choice),
                          child: Text(choice),
                        ),
                      ),
                    )
                    .toList(),
              )
            else if (currentQuestion["type"] == "result")
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "진단 결과:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // 결과 계산 함수 호출 (answers는 이전 질문들의 응답이 저장된 목록으로 가정)
                    Text(
                      currentQuestion["calculate"](
                          _answers), // calculate 함수에서 결과를 동적으로 반환
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _handleNextQuestion(""); // 결과 이후에도 계속 진행
                      },
                      child: const Text("다음"),
                    ),
                  ],
                ),
              ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
