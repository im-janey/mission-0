import 'package:flutter/material.dart';

import '../home/app.dart';
import 'signup.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  // 이메일과 비밀번호 입력을 위한 컨트롤러
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Firebase 인증 객체 (현재 주석 처리됨)
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // 로그인 메서드
  Future<void> _logIn() async {
    try {
      // Firebase 이메일/비밀번호 로그인 (주석 처리됨)
      // UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      //   email: _emailController.text.trim(),
      //   password: _passwordController.text.trim(),
      // );

      // 로그인 성공 시 홈 화면으로 이동
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AppPage()),
      );

      // 성공 메시지 (디버깅용)
      // print("로그인 성공: ${userCredential.user?.email}");
    } catch (e) {
      // 로그인 실패 시 에러 메시지 표시
      print("로그인 실패: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('로그인 실패: 다시 입력해주세요')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // 현재 테마의 밝기를 가져옴 (다크 모드 여부 확인)
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거

        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 40),
              // 앱 로고
              SizedBox(
                width: 100,
                child: Image.asset('assets/logo.png'),
              ),
              const SizedBox(height: 30),
              Text(
                '만나서 반가워요',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              // 이메일 입력 필드
              _buildTextField(
                '이메일을 입력해주세요',
                Icons.email,
                isDarkMode: isDarkMode,
                controller: _emailController,
              ),
              const SizedBox(height: 16.0),
              // 비밀번호 입력 필드
              _buildTextField(
                '비밀번호를 입력해주세요',
                Icons.lock,
                isDarkMode: isDarkMode,
                controller: _passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 40.0),
              // 로그인 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _logIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text(
                    '로그인',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // 회원가입 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode
                        ? Colors.grey[800]
                        : Colors.grey[300], // 다크 모드 시 더 어두운 회색
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                      fontSize: 18,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 입력 필드 위젯 생성 메서드
  Widget _buildTextField(String labelText, IconData icon,
      {bool obscureText = false,
      required bool isDarkMode,
      TextEditingController? controller}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(
          icon,
          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
        ),
        filled: true,
        fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[300],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        labelStyle: TextStyle(
          color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
        ),
        floatingLabelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
      cursorColor: Theme.of(context).primaryColor,
    );
  }
}
