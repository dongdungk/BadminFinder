// ============================================
// 로그인 화면 - UI만 그리기
// ============================================
// 지금 단계: 버튼은 있지만 클릭해도 아무 일 안 일어남
// 목표: Figma 디자인대로 화면만 예쁘게 그리기

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // build: 화면을 그리는 함수
    // context: 현재 화면 정보를 담고 있는 객체
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,  // 비율 2 (아래 flex 1의 2배 크기)
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  // all(40) = 상하좌우 모두 40픽셀 여백
                  child: Image.asset(
                    'assets/images/map_img.png',
                    fit: BoxFit.contain,
                    // contain: 이미지가 영역 안에 다 보이게 (비율 유지)
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      print('구글 버튼 클릭!');
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
                        // 테두리: 회색, 1픽셀 두께
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
                          // SizedBox: 빈 공간 (여기서는 간격용)

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
                  ),

                  SizedBox(height: 12),
                  // 버튼 사이 간격

                  // ----------------------------------
                  // 카카오 로그인 버튼
                  // ----------------------------------
                  GestureDetector(
                    onTap: () {
                      print('카카오 버튼 클릭!');
                    },

                    child: Container(
                      width: double.infinity,
                      height: 56,

                      decoration: BoxDecoration(
                        color: Color(0xFFFEE500),
                        // 0xFF = 불투명도
                        // FEE500 = 카카오 노란색 (16진수 색상 코드)

                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble,
                            // Flutter 기본 아이콘 (임시로 사용)
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
                  ),

                  SizedBox(height: 12),

                  // ----------------------------------
                  // 네이버 로그인 버튼
                  // ----------------------------------
                  GestureDetector(
                    onTap: () {
                      print('네이버 버튼 클릭!');
                    },

                    child: Container(
                      width: double.infinity,
                      height: 56,

                      decoration: BoxDecoration(
                        color: Color(0xFF03C75A),
                        // 네이버 초록색
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
                  ),
                ],
              ),
            ),

            // ========================================
            // 3. 하단 영역: 배드민턴 코트 일러스트
            // ========================================
            Expanded(
              flex: 1,  // 비율 1 (상단의 절반 크기)

              child: Padding(
                padding: EdgeInsets.all(20),

                child: Image.asset(
                  'assets/images/court_illustration.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}