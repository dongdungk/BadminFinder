// lib/login/service/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // ========================================
  // 1. Google 로그인 (회원가입/로그인 통합)
  // ========================================
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      return userCredential.user;

    } on FirebaseAuthException catch (e) {
      print('Google 로그인 에러: ${e.code}');
      return null;
    } catch (e) {
      print('Google 로그인 일반 에러: $e');
      return null;
    }
  }

  // ========================================
  // 2. [추가] 이메일/비밀번호 회원가입
  // ========================================
  Future<User?> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String errorMessage = '회원가입 실패: 알 수 없는 오류';
      if (e.code == 'weak-password') {
        errorMessage = '비밀번호가 너무 약합니다. 6자리 이상을 사용하세요.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = '이미 사용 중인 이메일입니다.';
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('회원가입 중 일반 오류 발생');
    }
  }

  // ========================================
  // 3. [추가] 이메일/비밀번호 로그인
  // ========================================
  Future<User?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String errorMessage = '로그인 실패: 알 수 없는 오류';
      if (e.code == 'user-not-found') {
        errorMessage = '등록되지 않은 이메일입니다.';
      } else if (e.code == 'wrong-password') {
        errorMessage = '비밀번호가 일치하지 않습니다.';
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('로그인 중 일반 오류 발생');
    }
  }

  // ========================================
  // 로그아웃 및 상태 감지
  // ========================================
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // ⭐️ Stream: 실시간 로그인 상태 변경 감지
  Stream<User?> get userChanges => _auth.authStateChanges();
}