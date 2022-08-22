import 'package:flutter/material.dart';
import 'package:shortly_clean/features/shortly_clean/presentation/home/home_view.dart';

import 'core/config/dependency/injectable.dart';

void main() async {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Inter',
        // scaffoldBackgroundColor: kBackGroundColor,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}
