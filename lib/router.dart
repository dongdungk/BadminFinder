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
import '/static/view/local_status.dart';
import '/static/view/search_gym.dart';
import '/static/view/facilities_status.dart';
import '/static/view/compare_status.dart';
import '/static/view/status_tabbar.dart';
import 'map/view/main_screen.dart'; // 4단계에서 수정할 MainScreen
import 'map/view/map_main_screen.dart';
import 'tagging/view/tagging_main_screen.dart';
import 'community/view/freeboard/freeboard_page.dart';
import 'map/view/favorite_screen.dart';
import 'map/view/search_screen.dart';
import 'tagging/view/tagging_success_screen.dart';
import 'map/view/facility_detail_screen.dart';
import 'map/view/facility_review_screen.dart';
import 'map/view/facility_photo_screen.dart';
import 'community/view/freeboard/freeboard_post_page.dart';
import 'community/view/freeboard/freeboard_writing_page.dart';

// --- GLOBAL NAVIGATION KEYS ---
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'ShellHome');
final _shellNavigatorStatsKey =
GlobalKey<NavigatorState>(debugLabel: 'ShellStats');
final _shellNavigatorEditKey = GlobalKey<NavigatorState>(debugLabel: 'ShellEdit');
final _shellNavigatorCommunityKey =
GlobalKey<NavigatorState>(debugLabel: 'ShellCommunity');
final _shellNavigatorProfileKey =
GlobalKey<NavigatorState>(debugLabel: 'ShellProfile');

// --- GO ROUTER DEFINITION ---
final goRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,

  // ⭐️⭐️⭐️ [핵심] 인증 상태에 따른 리디렉션 로직 ⭐️⭐️⭐️
  redirect: (BuildContext context, GoRouterState state) {
    final user = context.read<User?>();
    final isLoggedIn = user != null;
    final isLoggingIn = state.uri.toString() == '/login';

    // A. 로그인되어 있을 때:
    if (isLoggedIn) {
      // 로그인했는데 로그인 페이지로 가려고 한다면 -> 홈으로 강제 이동
      return isLoggingIn ? '/' : null;
    }
    // B. 로그아웃 상태일 때:
    else {
      // 로그아웃 상태인데 로그인 페이지가 아니라면 -> /login으로 강제 이동
      return isLoggingIn ? null : '/login';
    }
  },

  routes: [
    // ⭐️ [필수] 로그인 페이지 경로 추가 (최상위, 탭 바 없음)
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),

    // --- 8-A. 하단 탭 바가 있는 셸(Shell) 경로 ---
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        // --- 탭 0: 홈 (map) ---
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const MapMainScreen(),
              routes: [
                GoRoute(
                  path: 'search', // '/search'
                  builder: (context, state) => const SearchScreen(),
                ),
                GoRoute(
                  path: 'favorites', // '/favorites'
                  builder: (context, state) => const FavoritesScreen(),
                ),
              ],
            ),
          ],
        ),

        // --- 탭 1: 통계 (stats) ---
        StatefulShellBranch(
          navigatorKey: _shellNavigatorStatsKey,
          routes: [
            GoRoute(
              path: '/stats',
              builder: (context, state) =>
              const Center(child: Text('통계 화면')),
              path: '/static',
              builder: (context, state) => const StatusTabbar(),
              routes:[
                GoRoute(
                  path: 'compare',
                  builder: (context, state) => const GymCompareStatPage(),
                ),
                GoRoute(
                  path: 'facilities',
                  builder: (context, state) => const FacilitiesStatusPage(),
                ),
                GoRoute(
                  path: 'LocalStat',
                  builder: (context, state) => const LocalStatusPage(),
                ),
                GoRoute(
                  path: 'SearchGym',
                  builder: (context, state) => const SearchGymPage(),
                ),
              ]
            ),
          ],
        ),

        // --- 탭 2: 입출입 (edit/tagging) ---
        StatefulShellBranch(
          navigatorKey: _shellNavigatorEditKey,
          routes: [
            GoRoute(
              path: '/edit',
              builder: (context, state) => const TaggingMainScreen(),
              routes: [
                GoRoute(
                  path: 'tagging_success', // '/edit/tagging_success'
                  builder: (context, state) => const TaggingSuccessScreen(),
                ),
              ],
            ),
          ],
        ),

        // --- 탭 3: 커뮤니티 (community) ---
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCommunityKey,
          routes: [
            GoRoute(
              path: '/community', // 커뮤니티 탭의 첫 화면
              builder: (context, state) => const FreeBoardPage(),
              routes: [
                GoRoute(
                  path: 'post', // '/community/post'
                  builder: (context, state) => const FreeBoardPostPage(),
                ),
                GoRoute(
                  path: 'write', // '/community/write'
                  builder: (context, state) => const FreeBoardWritingPage(),
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

        // --- 탭 4: 내 정보 (profile) ---
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProfileKey,
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) =>
              const Center(child: Text('내 정보 화면')),
            ),
          ],
        ),
      ],
    ), // ⭐️ StatefulShellRoute 끝

    // --- 8-B. 셸(탭 바)을 덮는 최상위 경로들 ---
    GoRoute(
      path: '/facility/:id',
      builder: (context, state) {
        final facilityId = state.pathParameters['id']!;
        return FacilityDetailScreen(facilityId: facilityId);
      },
    ),
    GoRoute(
      path: '/facility/:id/reviews',
      builder: (context, state) {
        final facilityId = state.pathParameters['id']!;
        return FacilityReviewScreen(facilityId: facilityId);
      },
    ),
    GoRoute(
      path: '/facility/:id/photos',
      builder: (context, state) {
        final facilityId = state.pathParameters['id']!;
        return FacilityPhotoScreen(facilityId: facilityId);
      },
    ),
  ],
);