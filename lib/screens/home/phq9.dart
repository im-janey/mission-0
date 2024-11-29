import 'package:flutter/material.dart';

class PHQ9Page extends StatefulWidget {
  const PHQ9Page({super.key});

  @override
  State<PHQ9Page> createState() => _PH9PageState();
}

class _PH9PageState extends State<PHQ9Page> {
  final List<Map<String, dynamic>> _questions = [
    {"text": "이름이 무엇인가요?", "type": "text"},
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
  ];

  int _currentQuestionIndex = 0;
  final Map<int, String> _answers = {};
  final TextEditingController _textController = TextEditingController();

  void _nextQuestion([String? response]) {
    // 로그 추가
    print(
        "Current Question Index: $_currentQuestionIndex, Response: $response");
    setState(() {
      if (response != null) {
        _answers[_currentQuestionIndex] = response;
      }

      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        print("Moving to next question: $_currentQuestionIndex");
        _textController.clear();
      } else {
        print("All questions answered");
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
            // 리스트 아이콘 동작
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // 설정 버튼 동작
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

            // 답변 영역
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
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(80, 60), // 최소 크기: 가로 200, 세로 60
                        padding: EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10), // 버튼 내부 패딩
                        textStyle: TextStyle(fontSize: 18), // 글씨 크기ㅇㅁㄴㅇㄹ
                      ),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: (currentQuestion["choices"] as List<String>)
                    .map((choice) => Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: 5), // 위아래 패딩
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                                  Size(180, 60), // 최소 크기: 가로 180, 세로 60
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 40), // 버튼 내부 패딩
                              textStyle: TextStyle(fontSize: 24), // 글씨 크기
                            ),
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
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(180, 60), // 최소 크기: 가로 200, 세로 60
                    padding: EdgeInsets.symmetric(
                        vertical: 15, horizontal: 40), // 버튼 내부 패딩
                    textStyle: TextStyle(fontSize: 24), // 글씨 크기
                  ),
                  child: const Text("다음"),
                ),
              ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
