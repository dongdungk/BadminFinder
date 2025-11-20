// lib/router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seokju/community/view/survey/survey_complete_page.dart';
import 'package:seokju/community/view/survey/survey_result_page.dart';
import 'package:seokju/community/view/survey/survey_vote_page.dart';
import 'community/model/competition/competition_model.dart';
import 'community/view/competition/competition_details_page.dart';
import 'community/view/competition/competition_page.dart';
import 'community/view/freeboard/freeboard_page.dart';
import 'community/view/freeboard/freeboard_post_page.dart';
import 'community/view/freeboard/freeboard_writing_page.dart';
import 'community/view/news/news_page.dart';
import 'community/view/news/news_see_more_page.dart';
import 'community/view/survey/survey_page.dart';
import 'map/view/main_screen.dart'; // 4단계에서 수정할 MainScreen
import 'map/view/map_main_screen.dart';
import '/map/view/favorite_screen.dart';
import '/map/view/search_screen.dart';
import '/tagging/view/tagging_main_screen.dart';
import '/tagging/view/tagging_success_screen.dart';

// 1. 앱의 최상위 네비게이터 키
final _rootNavigatorKey = GlobalKey<NavigatorState>();

// 2. 셸(MainScreen) 내부의 각 탭을 위한 네비게이터 키
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'ShellHome');
final _shellNavigatorStatsKey = GlobalKey<NavigatorState>(debugLabel: 'ShellStats');
final _shellNavigatorEditKey = GlobalKey<NavigatorState>(debugLabel: 'ShellEdit');
final _shellNavigatorCommunityKey = GlobalKey<NavigatorState>(debugLabel: 'ShellCommunity');
final _shellNavigatorProfileKey = GlobalKey<NavigatorState>(debugLabel: 'ShellProfile');

// 3. GoRouter 설정
final goRouter = GoRouter(
  initialLocation: '/', // 앱이 시작될 때 첫 페이지
  navigatorKey: _rootNavigatorKey,

  routes: [
    // 4. StatefulShellRoute: 하단 탭 바를 감싸는 셸 라우트
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // 이 navigationShell 객체를 MainScreen에 전달합니다.
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        // --- 탭 0: 홈 ---
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: '/', // 탭의 루트
              builder: (context, state) => const MapMainScreen(),
              routes: [
                // '홈' 탭에서 이동할 하위 페이지들
                GoRoute(
                  path: 'favorites', // '/favorites'
                  builder: (context, state) => const FavoritesScreen(),
                ),
                GoRoute(
                  path: 'search', // '/search'
                  builder: (context, state) => const SearchScreen(),
                ),
              ],
            ),
          ],
        ),

        // --- 탭 1: 통계 ---
        StatefulShellBranch(
          navigatorKey: _shellNavigatorStatsKey,
          routes: [
            GoRoute(
              path: '/stats',
              builder: (context, state) => const Center(child: Text('통계 화면')),
            ),
          ],
        ),

        // --- 탭 2: 입출입 ---
        StatefulShellBranch(
          navigatorKey: _shellNavigatorEditKey,
          routes: [
            GoRoute(
              path: '/edit',
              builder: (context, state) => const TaggingMainScreen(),
              routes: [
                // '입출입' 탭에서 이동할 하위 페이지
                GoRoute(
                  path: 'tagging_success', // '/edit/tagging_success'
                  builder: (context, state) => const TaggingSuccessScreen(),
                ),
              ],
            ),
          ],
        ),

        // --- 탭 3: 커뮤니티 ---
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCommunityKey,
          routes: [
            GoRoute(
              path: '/community',
              builder: (context, state) => const FreeBoardPage(),
              routes: [
                // 자유게시판 목록
                GoRoute(
                  path: 'freeboard',
                  builder: (context, state) => const FreeBoardPage(),
                ),

                // 게시글 상세페이지 (ID 없음)
                GoRoute(
                  path: 'freeboard/post',
                  builder: (context, state) => const FreeBoardPostPage(),
                ),

                // 글작성
                GoRoute(
                  path: 'freeboard/write',
                  builder: (context, state) => const FreeBoarCommentPage(),
                ),

                // 대회
                GoRoute(
                  path: 'competition',
                  builder: (context, state) => const CompetitionPage(),
                ),
                GoRoute(
                  path: 'competition/details',
                  builder: (context, state) {
                    final comp = state.extra as CompetitionModel;
                    return CompetitionDetailPage(comp: comp);
                  },
                ),


                // 뉴스
                GoRoute(
                  path: 'news',
                  builder: (context, state) => const NewsPage(),
                  routes: [
                    GoRoute(
                      path: 'seemore',
                      builder: (context, state) {
                        final article = state.extra as Map<String, dynamic>;
                        return NewsSeeMorePage(article: article);
                      },
                    ),
                  ],
                ),

                // 설문
                GoRoute(
                  path: 'survey',
                  builder: (context, state) => const SurveyPage(),
                ),
                // 설문 투표 중
                GoRoute(
                  path: 'survey/vote',
                  builder: (context, state) => SurveyVotePage(),
                ),
                // 설문 투표 완료
                GoRoute(
                  path: 'survey/complete',
                  builder: (context, state) => SurveyCompletePage(),
                ),
                // 설문 투표 결과
                GoRoute(
                  path: 'survey/result',
                  builder: (context, state) => SurveyResultPage(),
                ),
              ],
            ),
          ],
        ),

        // --- 탭 4: 내 정보 ---
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProfileKey,
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const Center(child: Text('내 정보 화면')),
            ),
          ],
        ),
      ],
    ),
  ],
);