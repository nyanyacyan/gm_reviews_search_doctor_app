// screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:gm_reviews_search_doctor_app/const/strings.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';


class WidgetSearchInput extends StatefulWidget {
  const WidgetSearchInput({super.key});

  @override
  State<WidgetSearchInput> createState() => _WidgetSearchInput();
}

class _WidgetSearchInput extends State<WidgetSearchInput> {
  // ここに定義する物があればする

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appTitle)),
      body: const Center(child: Text('ホームページです')),
    );
  }
}
