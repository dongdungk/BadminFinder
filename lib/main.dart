import 'package:flutter/material.dart';
import 'login/view/view.dart';

void main() {
  // main: 앱이 시작될 때 맨 처음 실행되는 함수
  runApp(MyApp());
  // runApp: Flutter 앱 실행
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // MaterialApp: Flutter 앱의 최상위 위젯
      // Material Design 스타일 적용

      title: 'BadmintonGo',
      // 앱 이름 (멀티태스킹 화면에 표시)

      theme: ThemeData(
        primarySwatch: Colors.blue,
        // 기본 테마 색상
      ),

      home: LoginPage(),
      // home: 앱이 시작될 때 보여줄 첫 화면
    );
  }
}

/* ## 📝 **개념 정리**

### Widget이란?
```
화면에 보이는 모든 것 = Widget

예시:
- Text: 글자
- Image: 이미지
- Container: 박스
- Column: 세로 배치
- Row: 가로 배치
- Button: 버튼
```

### 레이아웃 구조
```
LoginPage
├─ Scaffold (전체 틀)
├─ SafeArea (안전 영역)
├─ Column (세로 배치)
├─ Expanded (상단 영역)
│  └─ Image (지도)
├─ Padding (중간 영역)
│  └─ Column
│     ├─ 구글 버튼
│     ├─ 카카오 버튼
│     └─ 네이버 버튼
└─ Expanded (하단 영역)
└─ Image (코트)
```

### Model 객체 사용 흐름
```
1. 정의: class UserModel { ... }
2. 생성: UserModel user = UserModel(...)
3. 사용: user.email, user.name
4. 변환: JSON ↔ UserModel

 */