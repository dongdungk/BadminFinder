import 'package:flutter/material.dart';

import 'static/view/status_tabbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Status',
      //home: const SearchGymPage(),
      //home: const FacilitiesStatusPage(),
      //home: const GymCompareStatPage(),
      //home: const LocalStatus()
      // home: const StatusMain(),
      home: StatusTabbar(),
    );

  }
}



