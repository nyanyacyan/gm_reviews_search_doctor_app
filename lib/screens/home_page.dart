import 'package:flutter/material.dart';
import 'package:gm_reviews_search_doctor_app/const/strings.dart';
import 'package:gm_reviews_search_doctor_app/widgets/filter_dropdown.dart';
import 'package:gm_reviews_search_doctor_app/widgets/result_display.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';


// ボタンや入力などがあるものは「StatefulWidget]
// 状態を持つ場合にはState<HomePage> createState() => _HomePageState();が必要
// 対象の画面を更新するために呼び出したいクラスを作成する必要がある
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 変数を定義して初期化する
  String selectedKeyword = '小児科';
  String stationName = '';

  void _onSearch(String newStationName, String medicalType) {
    // 新しい値を受け取って全体の変数を更新させる→NearbyHospitalListの値が更新される
    // setState() を呼ぶことで Flutterが自動的に build() を再実行（再レンダリング） してくれます。
    // 発火があった際に必ず必要になるコールバック関数
    setState(() {
      // 発火があった際に、以下の変数を更新する
      selectedKeyword = medicalType;
      stationName = newStationName;
      logger.d('検索キーワード: $selectedKeyword, 駅名: $stationName');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchInputSection(
              initialKeyword: selectedKeyword,
              onSearch: _onSearch,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: NearbyHospitalList(
                stationName: stationName,
                keyword: selectedKeyword,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
