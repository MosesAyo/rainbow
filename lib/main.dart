import 'package:flutter/material.dart';
import 'app/view/onboarding.dart';
// import 'app/view/view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Rainbow',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const OnBoardingPage());
  }
}
