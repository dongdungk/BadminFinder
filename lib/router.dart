// lib/router.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
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

import '/static/view/local_status.dart';
import '/static/view/search_gym.dart';
import '/static/view/facilities_status.dart';
import '/static/view/compare_status.dart';
import '/static/view/status_tabbar.dart';
import 'login/view/login_view.dart'; // router.dart에서 LoginPage를 사용하기 위해 필요
import 'map/view/main_screen.dart';
import 'map/view/map_main_screen.dart';
import 'map/view/favorite_screen.dart';
import 'map/view/search_screen.dart';
import 'map/view/facility_detail_screen.dart';
import 'map/view/facility_review_screen.dart';
import 'map/view/facility_photo_screen.dart';

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
final _shellNavigatorProfileKey = GlobalKey<NavigatorState>(debugLabel: 'ShellProfile');

// ------------------------------
// GoRouter
// ------------------------------
final goRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,

  redirect: (BuildContext context, GoRouterState state) {
    final user = context.read<User?>();
    final isLoggedIn = user != null;
    final isLoggingIn = state.uri.toString() == '/login';

    if (isLoggedIn) {
      return isLoggingIn ? '/' : null;
    } else {
      return isLoggingIn ? null : '/login';
    }
  },

  routes: [
    // ------------------------------
    // 로그인
    // ------------------------------
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),

    // ------------------------------
    // 탭 구조
    // ------------------------------
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [

        // ------------------------------
        // 탭 0: 홈
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
        // 탭 1: 통계
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
        // 탭 2: 입출입
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
        // 탭 3: 커뮤니티
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
                GoRoute(
                  path: 'write',
                  builder: (context, state) => const FreeBoarCommentPage(),
                ),

                // 🔹 대회
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
                ),
                GoRoute(
                  path: 'survey/vote',
                  builder: (context, state) => SurveyVotePage(),
                ),
                GoRoute(
                  path: 'survey/complete',
                  builder: (context, state) => SurveyCompletePage(),
                ),
                GoRoute(
                  path: 'survey/result',
                  builder: (context, state) => SurveyResultPage(),
                ),
              ],
            ),
          ],
        ),

        // ------------------------------
        // 탭 4: 내 정보
        // ------------------------------
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
    ),

    // ------------------------------
    // 시설 상세 상위 페이지
    // ------------------------------
    GoRoute(
      path: '/facility/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return FacilityDetailScreen(facilityId: id);
      },
    ),

    GoRoute(
      path: '/facility/:id/reviews',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return FacilityReviewScreen(facilityId: id);
      },
    ),

    GoRoute(
      path: '/facility/:id/photos',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return FacilityPhotoScreen(facilityId: id);
      },
    ),
  ],
);
