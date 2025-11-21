import 'package:flutter/material.dart';
import '../../model/freeboard/post_model.dart';

class FreeBoardViewModel extends ChangeNotifier {
  final List<PostModel> _posts = [];

  List<PostModel> get posts => List.unmodifiable(_posts);

  PostModel? _selectedPost;
  PostModel? get selectedPost => _selectedPost;

  //게시글 선택
  void selectPost(PostModel post) {
    _selectedPost = post;
    notifyListeners();
  }

  //조회수 증가
  void increaseViews(String postId) {
    final index = _posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      _posts[index].views++;
      notifyListeners();
    }
  }


  //좋아요 증가 기능
  void likePost(String postId) {
    final index = _posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      _posts[index].likes++;
      notifyListeners();
    }
  }

  //초기 데이터
  void loadInitialData() {
    if (_posts.isNotEmpty) return;

    _posts.addAll([
      PostModel(
        id: "1",
        icon: "🔍",
        title: "오늘 저녁 7시 배드민턴 치실 분!",
        content: "체육관에서 복식 게임하실 분 구합니다",
        time: "15분 전",
        views: 81,
        likes: 3,
      ),
      PostModel(
        id: "2",
        icon: "🏸",
        title: "배드민턴 동호회 정기 모임 안내",
        content: "이번 주 토요일 오전 10시 체육관에서 모임 있습니다!",
        time: "15분 전",
        views: 61,
        likes: 4,
      ),
      PostModel(
        id: "3",
        icon: '🏸',
        title: '라켓 추천 부탁드려요',
        content: '초보자인데 어떤 라켓 사는 게 좋을까요?',
        time: '20분 전',
        views: 54,
        likes: 2,
      ),
      PostModel(
        id: "4",
        icon: '💪',
        title: '스매시 잘 치는 법 알려주세요',
        content: '스매시를 쳐도 힘이 없고 각도가 안 나와요 ㅠㅠ',
        time: '30분 전',
        views: 109,
        likes: 6,
      ),
      PostModel(
        id: "5",
        icon: '🏆',
        title: '배드민턴 대회 출전 모집!!',
        content:
        '다음 달 대학 리그전 나갈 분들 모집합니다!\n1등 상금 50만원, 2등 30만원입니다',
        time: '30분 전',
        views: 119,
        likes: 8,
      ),
      PostModel(
        id: "6",
        icon: '🏸',
        title: '서브 넣을 때 자꾸 네트에 걸려요',
        content: '롱 서브 연습하는데 계속 네트에 걸리네요.\n혹시 팁 있으신 분 계신가요?',
        time: '10/31',
        views: 92,
        likes: 3,
      ),
      PostModel(
        id: "7",
        icon: '⭐',
        title: '백핸드 클리어 드디어 성공!',
        content: '3개월 연습한 보람이 있네요 ㅋㅋ',
        time: '1시간 전',
        views: 98,
        likes: 9,
      ),
      PostModel(
        id: "8",
        icon: '🏟️',
        title: '체육관 예약 어떻게 하나요?',
        content: '학교 체육관 배드민턴 코트 예약 방법 아시는 분?',
        time: '1시간 전',
        views: 118,
        likes: 8,
      ),

    ]);

    notifyListeners();
  }

  // 게시글 추가
  void addPost(String icon, String title, String content) {
    _posts.insert(
      0,
      PostModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        icon: icon,
        title: title,
        content: content,
        time: "방금 전",
        views: 0,
        likes: 0,
      ),
    );
    notifyListeners();
  }
}
