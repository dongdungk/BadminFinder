import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart'; // context.read<T>() 사용을 위해 필수

// ⭐️ [필수 임포트] AuthService와 ReviewModel
import 'login/service/auth_service.dart';
import 'map/model/facility_review_model.dart';

// Community Model & Views
import 'package:seokju/community/model/competition/competition_model.dart';
import 'package:seokju/community/view/survey/survey_complete_page.dart';
import 'package:seokju/community/view/survey/survey_result_page.dart';
import 'package:seokju/community/view/survey/survey_vote_page.dart';
import 'package:seokju/community/view/competition/competition_details_page.dart';
import 'package:seokju/community/view/competition/competition_page.dart';
import 'package:seokju/community/view/freeboard/freeboard_page.dart';
import 'package:seokju/community/view/freeboard/freeboard_post_page.dart';
import 'package:seokju/community/view/freeboard/freeboard_writing_page.dart';
import 'package:seokju/community/view/news/news_page.dart';
import 'package:seokju/community/view/news/news_see_more_page.dart';
import 'package:seokju/community/view/survey/survey_page.dart';

// Static Views
import '/static/view/local_status.dart';
import '/static/view/search_gym.dart';
import '/static/view/facilities_status.dart';
import '/static/view/compare_status.dart';
import '/static/view/status_tabbar.dart';

// Login Views
import 'login/view/login_view.dart'; // LoginPage

// Map & Tagging Views
import 'map/view/main_screen.dart';
import 'map/view/map_main_screen.dart';
import 'map/view/favorite_screen.dart';
import 'map/view/search_screen.dart';
import 'map/view/facility_detail_screen.dart';
import 'map/view/facility_review_screen.dart';
import 'map/view/facility_photo_screen.dart';
import 'map/view/facility_review_edit_screen.dart';

import 'tagging/view/tagging_main_screen.dart';
import 'tagging/view/tagging_success_screen.dart';

// ------------------------------
// Navigation Keys
// ------------------------------
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'ShellHome');
final _shellNavigatorStatsKey = GlobalKey<NavigatorState>(debugLabel: 'ShellStats');
final _shellNavigatorEditKey = GlobalKey<NavigatorState>(debugLabel: 'ShellEdit');
final _shellNavigatorCommunityKey = GlobalKey<NavigatorState>(debugLabel: 'ShellCommunity');
//
final _shellNavigatorProfileKey = GlobalKey<NavigatorState>(debugLabel: 'ShellProfile');

//
final AuthService _authService = AuthService();


// ------------------------------
// GoRouter Definition
// ------------------------------
final goRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,

  //
  redirect: (BuildContext context, GoRouterState state) {
    // 1. StreamProvider를 통해 비동기 상태를 읽습니다.
    final streamUser = context.read<User?>();
    // 2. AuthService를 통해 현재 로그인된 유저 상태를 동기적으로 확인합니다.
    final directUser = _authService.getCurrentUser();

    // 3. 둘 중 하나라도 User 객체를 가지고 있다면 로그인된 상태로 간주합니다.
    final isLoggedIn = streamUser != null || directUser != null;

    final isLoggingIn = state.uri.toString() == '/login';

    //
    final goingToHome = state.fullPath == '/';

    if (isLoggedIn) {
      // A. 로그인되어 있을 때:
      if (isLoggingIn) {
        // 로그인 페이지 접근 시 -> 홈으로 이동
        return '/';
      }
      return null; // 이미 로그인 상태이므로 리디렉션 없음
    } else {
      // B. 로그아웃 상태일 때 (충돌 발생 지점)
      if (isLoggingIn) {
        // 로그인 페이지에 있다면 리디렉션 없음
        return null;
      }

      // ⭐️ [핵심 FIX] 로그아웃 상태여도 홈으로 가려는 요청은 허용 (상태 반영 시간 확보)
      if (goingToHome) {
        return null;
      }

      // 그 외의 모든 페이지 접근은 /login으로 강제 복귀
      return '/login';
    }
  },
  // ⭐️⭐️⭐️ -------------------------------------------------- ⭐️⭐️⭐️


  routes: [
    // ------------------------------
    // 로그인 (최상위)
    // ------------------------------
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),

    // ------------------------------
    // 탭 구조 (StatefulShellRoute)
    // ------------------------------
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [

        // ------------------------------
        // 탭 0: 홈 (map)
        // ------------------------------
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const MapMainScreen(),
              routes: [
                GoRoute(
                  path: 'search',
                  builder: (context, state) => const SearchScreen(),
                ),
                GoRoute(
                  path: 'favorites',
                  builder: (context, state) => const FavoritesScreen(),
                ),
              ],
            ),
          ],
        ),

        // ------------------------------
        // 탭 1: 통계 (static)
        // ------------------------------
        StatefulShellBranch(
          navigatorKey: _shellNavigatorStatsKey,
          routes: [
            GoRoute(
              path: '/static',
              builder: (context, state) => const StatusTabbar(),
              routes: [
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
              ],
            ),
          ],
        ),

        // ------------------------------
        // 탭 2: 입출입 (edit/tagging)
        // ------------------------------
        StatefulShellBranch(
          navigatorKey: _shellNavigatorEditKey,
          routes: [
            GoRoute(
              path: '/edit',
              builder: (context, state) => const TaggingMainScreen(),
              routes: [
                GoRoute(
                  path: 'tagging_success',
                  builder: (context, state) => const TaggingSuccessScreen(),
                ),
              ],
            ),
          ],
        ),

        // ------------------------------
        // 탭 3: 커뮤니티 (community)
        // ------------------------------
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCommunityKey,
          routes: [
            GoRoute(
              path: '/community',
              builder: (context, state) => const FreeBoardPage(),
              routes: [
                // 🔹 자유게시판
                GoRoute(
                  path: 'post',
                  builder: (context, state) => const FreeBoardPostPage(),
                ),

                // 🔹 대회
                GoRoute(
                  path: 'competition',
                  builder: (context, state) => const CompetitionPage(),
                  routes: [
                    GoRoute(
                      path: 'details',
                      builder: (context, state) {
                        final comp = state.extra as CompetitionModel;
                        return CompetitionDetailPage(comp: comp);
                      },
                    ),
                  ],
                ),

                // 🔹 뉴스
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

                // 🔹 설문
                GoRoute(
                  path: 'survey',
                  builder: (context, state) => const SurveyPage(),
                  routes: [
                    GoRoute(
                      path: 'vote',
                      builder: (context, state) => SurveyVotePage(),
                    ),
                    GoRoute(
                      path: 'complete',
                      builder: (context, state) => SurveyCompletePage(),
                    ),
                    GoRoute(
                      path: 'result',
                      builder: (context, state) => SurveyResultPage(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // ------------------------------
        // 탭 4: 내 정보 (profile)
        // ------------------------------
        StatefulShellBranch(
          // ⭐️ [FIXED] 올바른 키 타입 사용
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
    ),

    // ------------------------------
    // 시설 상세 (탭 바를 덮는 최상위 페이지)
    // ------------------------------
    GoRoute(
        path: '/facility/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return FacilityDetailScreen(facilityId: id);
        },
        routes: [
          // 🔹 리뷰 목록
          GoRoute(
              path: 'reviews',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return FacilityReviewScreen(facilityId: id);
              },
              routes: [
                // 🔹 리뷰 수정 (새로운 경로)
                GoRoute(
                  path: 'edit/:reviewId', // /facility/:id/reviews/edit/:reviewId
                  builder: (context, state) {
                    final reviewId = state.pathParameters['reviewId']!;

                    // extra로 전달받은 ReviewModel을 사용
                    final reviewToEdit = state.extra as ReviewModel;

                    return ReviewEditScreen(
                      reviewId: reviewId,
                      reviewToEdit: reviewToEdit,
                    );
                  },
                ),
              ]
          ),

          // 🔹 사진 목록
          GoRoute(
            path: 'photos',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return FacilityPhotoScreen(facilityId: id);
            },
          ),
        ]
    ),
  ],
);