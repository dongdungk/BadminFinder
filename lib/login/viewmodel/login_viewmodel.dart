// lib/login/viewmodel/login_viewmodel.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ⭐️ [Project-Relative Path]
import '../service/auth_service.dart';

class LoginViewModel extends ChangeNotifier {

  final AuthService _authService;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  User? _user;
  User? get user => _user;

  // ⭐️ [DI FIX] 생성자로 AuthService를 주입 받음
  LoginViewModel(this._authService);

  // ========================================
  // Google 로그인
  // ========================================
  Future<bool> signInWithGoogle() async {
    try {
      _setLoading(true);
      _errorMessage = null;

      final user = await _authService.signInWithGoogle();

      if (user != null) {
        _user = user;
        _setLoading(false);
        print('Google 로그인 성공!');
        return true;
      } else {
        _errorMessage = '로그인이 취소되었습니다.';
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _errorMessage = 'Google 로그인 실패: $e';
      _setLoading(false);
      print('Google 로그인 실패: $e');
      return false;
    }
  }

  // ========================================
  // [추가] 이메일/비밀번호 회원가입
  // ========================================
  Future<bool> signUpWithEmail(String email, String password) async {
    try {
      _setLoading(true);
      _errorMessage = null;

      final user = await _authService.signUpWithEmail(email: email, password: password);

      if (user != null) {
        _user = user;
        _setLoading(false);
        print('이메일 회원가입 성공! 사용자: ${user.email}');
        return true;
      }
      return false;

    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _setLoading(false);
      return false;
    }
  }

  // ========================================
  // [추가] 이메일/비밀번호 로그인
  // ========================================
  Future<bool> signInWithEmail(String email, String password) async {
    try {
      _setLoading(true);
      _errorMessage = null;

      final user = await _authService.signInWithEmail(email: email, password: password);

      if (user != null) {
        _user = user;
        _setLoading(false);
        print('이메일 로그인 성공! 사용자: ${user.email}');
        return true;
      }
      return false;

    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _setLoading(false);
      return false;
    }
  }

  // ========================================
  // 로그아웃
  // ========================================
  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }

  // 헬퍼 메서드 (생략)
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  bool get isLoggedIn => _user != null;
}