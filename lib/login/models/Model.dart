class UserModel {
  final String uid;
  final String email;
  final String? name;
  final String? profileImage;

  UserModel({
    required this.uid,
    required this.email,
    this.name,          // 선택 (안 넣어도 됨)
    this.profileImage,  // 선택
  });

  // ------------------------------------------
  // 사용 예시
  // ------------------------------------------
  /*
  // 객체 만들기
  UserModel user = UserModel(
    uid: 'abc123',
    email: 'kangji@example.com',
    name: '강지',
    profileImage: 'https://example.com/photo.jpg',
  );

  // 값 꺼내 쓰기
  print(user.email);  // 'kangji@example.com' 출력
  print(user.name);   // '강지' 출력
  */

  // ------------------------------------------
  // JSON → UserModel 변환
  // ------------------------------------------
  // 언제 필요?: 서버나 Firebase에서 데이터 받을 때
  // JSON: { "uid": "abc", "email": "test@test.com" } 형태

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // factory: 객체를 만들어서 반환하는 특별한 생성자
    // Map<String, dynamic>: 키-값 쌍 (딕셔너리)
    //   예: { "name": "강지", "age": 25 }

    return UserModel(
      uid: json['uid'] as String,
      // json['uid']: JSON에서 'uid' 키의 값 가져오기
      // as String: String 타입으로 확실히 지정

      email: json['email'] as String,
      name: json['name'] as String?,
      // as String?: String이거나 null

      profileImage: json['profileImage'] as String?,
    );
  }

  /*
  사용 예시:

  Map<String, dynamic> jsonData = {
    'uid': 'abc123',
    'email': 'test@test.com',
    'name': '강지'
  };

  UserModel user = UserModel.fromJson(jsonData);
  print(user.email);  // 'test@test.com'
  */

  // ------------------------------------------
  // UserModel → JSON 변환
  // ------------------------------------------
  // 언제 필요?: 서버에 데이터 보낼 때

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,           // this.uid를 'uid' 키에 저장
      'email': email,
      'name': name,
      'profileImage': profileImage,
    };
  }

  /*
  사용 예시:

  UserModel user = UserModel(
    uid: 'abc123',
    email: 'test@test.com',
  );

  Map<String, dynamic> json = user.toJson();
  // { 'uid': 'abc123', 'email': 'test@test.com', ... }
  */

  // ------------------------------------------
  // 디버깅용 문자열 출력
  // ------------------------------------------
  @override
  String toString() {
    // toString: 객체를 print할 때 보기 좋게 출력
    return 'UserModel(uid: $uid, email: $email, name: $name)';
    // $변수: 문자열 안에 변수 값 넣기
  }

/*
  사용 예시:

  UserModel user = UserModel(uid: 'abc', email: 'test@test.com');
  print(user);
  // 출력: UserModel(uid: abc, email: test@test.com, name: null)
  */
}