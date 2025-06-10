//? main.dart
//? imports ====================================================
import 'package:flutter/material.dart';
import 'package:gm_reviews_search_doctor_app/utils/global_keys.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gm_reviews_search_doctor_app/const/strings.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';
import 'screens/main_screen.dart';

// -------------------------------------------------------------

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLogger(); // logger を初期化

  //? dart-define で渡された ENV 変数から読み込む .env ファイルを指定
  const envFile = String.fromEnvironment('ENV', defaultValue: '.env.android');
  await dotenv.load(fileName: envFile); // .envからAPIキーなどを読み込む

  runApp(const MyApp());
}

// *************************************************************

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // -------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // グローバルナビゲーションキーを設定
      title: AppStrings.materialTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainScreen(),
    );
  }
}

// *************************************************************
