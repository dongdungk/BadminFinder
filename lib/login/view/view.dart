import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModel/ViewModel.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<LoginViewModel>(
          builder: (context, viewModel, child) {
            return Stack(
              children: [
                // 메인 컨텐츠
                Column(
                  children: [
                    // ========================================
                    // 1. 상단 영역: 지도 일러스트
                    // ========================================
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(40),
                          child: Image.asset(
                            'assets/images/map_img.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),

                    // ========================================
                    // 2. 중간 영역: 로그인 버튼들
                    // ========================================
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          // Google 로그인 버튼
                          _buildGoogleButton(context, viewModel),

                          SizedBox(height: 12),

                          // Kakao 로그인 버튼
                          _buildKakaoButton(context, viewModel),

                          SizedBox(height: 12),

                          // Naver 로그인 버튼
                          _buildNaverButton(context, viewModel),
                        ],
                      ),
                    ),

                    // ========================================
                    // 3. 하단 영역: 배드민턴 코트 일러스트
                    // ========================================
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Image.asset(
                          'assets/images/court_img.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
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
  // Google 로그인 버튼
  // ========================================
  Widget _buildGoogleButton(BuildContext context, LoginViewModel viewModel) {
    return GestureDetector(
      onTap: viewModel.isLoading ? null : () async {
        bool success = await viewModel.signInWithGoogle();

        if (success) {
          // 로그인 성공 - 메인 화면으로 이동
          print('Google 로그인 성공! 메인 화면으로 이동');
          // TODO: Navigator.pushReplacement로 메인 화면 이동
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => MainPage()),
          // );
        } else {
          // 로그인 실패 - 에러 메시지 표시
          if (viewModel.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(viewModel.errorMessage!)),
            );
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
              'assets/images/google_logo.png',
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

  // ========================================
  // Kakao 로그인 버튼
  // ========================================
  Widget _buildKakaoButton(BuildContext context, LoginViewModel viewModel) {
    return GestureDetector(
      onTap: viewModel.isLoading ? null : () async {
        bool success = await viewModel.signInWithKakao();

        if (success) {
          // 로그인 성공
          print('Kakao 로그인 성공!');
          // TODO: 메인 화면으로 이동
        } else {
          // 로그인 실패
          if (viewModel.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(viewModel.errorMessage!)),
            );
          }
        }
      },
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: Color(0xFFFEE500),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble,
              color: Colors.black87,
              size: 24,
            ),
            SizedBox(width: 12),
            Text(
              '카카오로 시작하기',
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

  // ========================================
  // Naver 로그인 버튼
  // ========================================
  Widget _buildNaverButton(BuildContext context, LoginViewModel viewModel) {
    return GestureDetector(
      onTap: viewModel.isLoading ? null : () async {
        bool success = await viewModel.signInWithNaver();

        if (success) {
          // 로그인 성공
          print('Naver 로그인 성공!');
          // TODO: 메인 화면으로 이동
        } else {
          // 로그인 실패
          if (viewModel.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(viewModel.errorMessage!)),
            );
          }
        }
      },
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: Color(0xFF03C75A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'N',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 12),
            Text(
              '네이버로 시작하기',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}