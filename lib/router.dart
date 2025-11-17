import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'community/view/news/news_see_more_page.dart';
import 'home/home_page.dart';
import 'stats/stats_page.dart';
import 'entry/entry_page.dart';
import 'mypage/my_page.dart';

// Community
import 'community/view/freeboard/freeboard_page.dart';
import 'community/view/freeboard/freeboard_post_page.dart';
import 'community/view/freeboard/freeboard_writing_page.dart';

import 'community/view/competition/competition_page.dart';
import 'community/view/competition/competition_details_page.dart';
import 'community/view/news/news_page.dart';
import 'community/view/survey/survey_page.dart';


final router = GoRouter(
  initialLocation: '/home',

  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            onTap: navigationShell.goBranch,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: '통계'),
              BottomNavigationBarItem(icon: Icon(Icons.login), label: '입출입'),
              BottomNavigationBarItem(icon: Icon(Icons.people), label: '커뮤니티'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: '내정보'),
            ],
          ),
        );
      },

      branches: [
        //홈
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),

        //통계
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/stats',
              builder: (context, state) => const StatsPage(),
            ),
          ],
        ),

        //입출입
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/entry',
              builder: (context, state) => const EntryPage(),
            ),
          ],
        ),

        //커뮤니티
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/community',
              builder: (context, state) => const FreeBoardPage(),
              routes: [
                //자유게시판 목록
                GoRoute(
                  path: 'freeboard',
                  builder: (context, state) => const FreeBoardPage(),
                ),
                //게시글 상세페이지
                GoRoute(
                  path: 'freeboard/post',
                  builder: (context, state) => const FreeBoardPostPage(),
                ),
                //글작성
                GoRoute(
                  path: 'freeboard/write',
                  builder: (context, state) => const FreeBoardWritingPage(),
                ),

                //대회
                GoRoute(
                  path: 'competition',
                  builder: (context, state) => const CompetitionPage(),
                ),
                //대회 상세정보
                GoRoute(
                  path: 'competition/details',
                  builder: (context, state) => const CompetitionDetailsPage(),
                ),

                //뉴스
                GoRoute(
                  path: 'news',
                  builder: (context, state) => const NewsPage(),
                ),
                //뉴스 자세히보기
                GoRoute(
                  path: 'news/seemore',
                  builder: (context, state) => const NewsSeeMorePage(),
                ),

                //설문
                GoRoute(
                  path: 'survey',
                  builder: (context, state) => const SurveyPage(),
                ),
              ],
            ),
          ],
        ),

        //내 정보
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/mypage',
              builder: (context, state) => const MyPage(),
            ),
          ],
        ),
      ],
    )
  ],
);
