// lib/auth/view/login_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
// ⭐️ [필수] Future.delayed 사용을 위해 dart:async를 암시적으로 사용합니다.
// import 'dart:async';

// ViewModel 경로
import '../viewmodel/login_viewmodel.dart';


class LoginPage extends StatefulWidget {

  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 현재 로그인(true) 모드인지, 회원가입(false) 모드인지 구분.lll 123123123132,123123
  bool _isLoginMode = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ========================================
  // 공통 로그인 처리 함수 (Email/Pass)
  // ========================================
  void _processAuth(BuildContext context, LoginViewModel viewModel) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이메일과 비밀번호를 입력해주세요.')),
      );
      return;
    }

    bool success;
    if (_isLoginMode) {
      success = await viewModel.signInWithEmail(email, password);
    } else {
      success = await viewModel.signUpWithEmail(email, password);
    }

    if (success) {
      print('${_isLoginMode ? "로그인" : "회원가입"} 성공! (0.5초 후 강제 전환)');

      // ⭐️⭐️⭐️ [최종 FIX 1] Future.delayed를 사용한 전환 ⭐️⭐️⭐️
      if (!context.mounted) return;
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!context.mounted) return;
        context.go('/');
      });

    } else {
      // 로그인/회원가입 실패 - ViewModel의 에러 메시지 표시
      if (viewModel.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(viewModel.errorMessage!)),
        );
        viewModel.clearError(); // 에러 메시지 초기화
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<LoginViewModel>(
          builder: (context, viewModel, child) {
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // 1. 상단 영역 (일러스트)
                      SizedBox(height: 50),
                      Image.asset(
                        'assets/panda.webp',
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 30),

                      Text(
                          '환영합니다!',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                      ),
                      SizedBox(height: 30),

                      // 2. 이메일/비밀번호 입력 필드
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: '이메일',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: '비밀번호',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: Icon(Icons.lock),
                          hintText: _isLoginMode ? null : '6자 이상 입력해주세요',
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 24),

                      // 3. 로그인/회원가입 버튼
                      ElevatedButton(
                        onPressed: viewModel.isLoading
                            ? null
                            : () => _processAuth(context, viewModel),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 56),
                          backgroundColor: Color(0xFF5A4FCF), // 브랜드 색상 가정
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(
                          _isLoginMode ? '로그인 하기' : '회원가입 하기',
                          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 12),

                      // 로그인/회원가입 모드 전환 버튼
                      TextButton(
                        onPressed: viewModel.isLoading
                            ? null
                            : () {
                          setState(() {
                            _isLoginMode = !_isLoginMode;
                            viewModel.clearError();
                          });
                        },
                        child: Text(
                          _isLoginMode ? '계정이 없으신가요? 회원가입 하러가기' : '이미 계정이 있으신가요? 로그인 하러가기',
                          style: TextStyle(color: Color(0xFF5A4FCF)),
                        ),
                      ),

                      SizedBox(height: 30),

                      // 4. 소셜 로그인 구분선
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text('또는 소셜 계정으로 시작하기', style: TextStyle(color: Colors.grey)),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: 20),

                      // 5. Google 로그인 버튼 (기존 로직)
                      _buildGoogleButton(context, viewModel),

                      SizedBox(height: 50), // 하단 여백

                    ],
                  ),
                ),

                // 로딩 인디케이터
                if (viewModel.isLoading)
                  Container(
                    color: Colors.black26,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ========================================
  // Google 로그인 버튼 함수
  // ========================================
  Widget _buildGoogleButton(BuildContext context, LoginViewModel viewModel) {
    return GestureDetector(
      onTap: viewModel.isLoading ? null : () async {
        bool success = await viewModel.signInWithGoogle();

        if (success) {
          print('Google 로그인 성공! (0.5초 후 강제 전환)');

          // ⭐️⭐️⭐️ [최종 FIX 2] Future.delayed를 사용한 전환 ⭐️⭐️⭐️
          Future.delayed(const Duration(milliseconds: 500), () {
            if (!context.mounted) return;
            context.go('/');
          });

        } else {
          // 로그인 실패 - 에러 메시지 표시
          if (viewModel.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(viewModel.errorMessage!)),
            );
            viewModel.clearError(); // 에러 메시지 초기화
          }
        }
      },
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/google_logo.png',
              width: 24,
              height: 24,
            ),
            SizedBox(width: 12),
            Text(
              'Google로 시작하기',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}