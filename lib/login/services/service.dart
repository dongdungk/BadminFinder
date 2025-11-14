import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// hide User 안할 시 firebase User와 충돌 발생으로 패키지 안 추가기입필요
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' hide User;

class AuthService {
  // Firebase 인증 인스턴스
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Google 로그인 인스턴스
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // ========================================
  // Google 로그인
  // ========================================
  Future<User?> signInWithGoogle() async {
    try {
      // 1. Google 로그인 창 열기
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // 사용자가 로그인 취소한 경우
      if (googleUser == null) {
        return null;
      }

      // 2. Google 인증 정보 가져오기
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // 3. Firebase 인증 정보 생성
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Firebase에 로그인
      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      // 5. 로그인된 사용자 정보 반환
      return userCredential.user;

    } catch (e) {
      print('Google 로그인 에러: $e');
      return null;
    }
  }

  // ========================================
  // Kakao 로그인
  // ========================================
  Future<User?> signInWithKakao() async {
    try {
      // 1. 카카오톡 설치 여부 확인
      bool isTalkInstalled = await isKakaoTalkInstalled();

      OAuthToken token;

      if (isTalkInstalled) {
        // 카카오톡으로 로그인
        token = await UserApi.instance.loginWithKakaoTalk();
      } else {
        // 카카오 계정으로 로그인 (웹뷰)
        token = await UserApi.instance.loginWithKakaoAccount();
      }

      // 2. 카카오 사용자 정보 가져오기
      final kakaoUser = await UserApi.instance.me();

      // 3. Firebase Custom Token 방식으로 연동
      // (이 부분은 서버가 필요함 - 일단은 정보만 가져오기)
      print('카카오 로그인 성공!');
      print('닉네임: ${kakaoUser.kakaoAccount?.profile?.nickname}');
      print('이메일: ${kakaoUser.kakaoAccount?.email}');
      return null;

    } catch (e) {
      print('Kakao 로그인 에러: $e');
      return null;
    }
  }

  // ========================================
  // 로그아웃
  // ========================================
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    // Kakao 로그아웃도 필요시 추가
  }

  // ========================================
  // 현재 로그인된 사용자 가져오기
  // ========================================
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}