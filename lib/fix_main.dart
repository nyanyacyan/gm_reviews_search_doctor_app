import 'package:flutter/material.dart';
import 'package:gm_reviews_search_doctor_app/const/strings.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.materialTitle, // ← システム上のアプリ名
      home: const HomePage(),
    );
  }
}
