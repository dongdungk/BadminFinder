import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/service.dart';

class LoginViewModel extends ChangeNotifier {
  // AuthService 인스턴스
  final AuthService _authService = AuthService();

  // ========================================
  // 상태 관리 변수들
  // ========================================

  // 로딩 상태 (버튼 클릭 중인지)
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // 에러 메시지
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // 로그인된 사용자
  User? _user;
  User? get user => _user;

  // ========================================
  // Google 로그인
  // ========================================
  Future<bool> signInWithGoogle() async {
    try {
      // 로딩 시작
      _setLoading(true);
      _errorMessage = null;

      // AuthService를 통해 Google 로그인 실행
      final user = await _authService.signInWithGoogle();

      if (user != null) {
        // 로그인 성공
        _user = user;
        _setLoading(false);

        print('Google 로그인 성공!');
        print('사용자 이름: ${user.displayName}');
        print('이메일: ${user.email}');

        return true;
      } else {
        // 로그인 취소
        _errorMessage = '로그인이 취소되었습니다.';
        _setLoading(false);
        return false;
      }

    } catch (e) {
      // 에러 발생
      _errorMessage = 'Google 로그인 실패: $e';
      _setLoading(false);
      print(_errorMessage);
      return false;
    }
  }

  // ========================================
  // Kakao 로그인
  // ========================================
  Future<bool> signInWithKakao() async {
    try {
      // 로딩 시작
      _setLoading(true);
      _errorMessage = null;

      // AuthService를 통해 Kakao 로그인 실행
      final user = await _authService.signInWithKakao();

      if (user != null) {
        // 로그인 성공 (현재는 null 반환 - 서버 연동 필요)
        _user = user;
        _setLoading(false);

        print('Kakao 로그인 성공!');
        return true;
      } else {
        // 현재는 카카오 정보만 가져옴
        _setLoading(false);

        // 임시: 카카오는 정보만 가져오고 성공 처리
        print('Kakao 사용자 정보 가져오기 완료');
        return true;
      }

    } catch (e) {
      // 에러 발생
      _errorMessage = 'Kakao 로그인 실패: $e';
      _setLoading(false);
      print(_errorMessage);
      return false;
    }
  }

  // ========================================
  // Naver 로그인 (나중을 위한 준비)
  // ========================================
  Future<bool> signInWithNaver() async {
    // TODO: Naver 로그인 구현
    _errorMessage = 'Naver 로그인은 아직 구현되지 않았습니다.';
    notifyListeners();
    return false;
  }

  // ========================================
  // 로그아웃
  // ========================================
  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }

  // ========================================
  // 헬퍼 메서드
  // ========================================

  // 로딩 상태 변경
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();  // UI에 변경 알림
  }

  // 에러 메시지 초기화
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // 현재 로그인 상태 확인
  bool get isLoggedIn => _user != null;
}