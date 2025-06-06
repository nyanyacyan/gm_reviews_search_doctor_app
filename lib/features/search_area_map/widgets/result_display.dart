//? search_result_item.dartにて作成されたカードwidgetリストを渡して表示させる
//? imports ===============================================
import 'package:flutter/material.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';
import 'parts/search_result_item.dart';

//* ------------------------------------------------------------

class ResultDisplay extends StatelessWidget {
  final List<Map<String, dynamic>> places;
  final ScrollController scrollController;

  const ResultDisplay({
    super.key,

    // 引数
    required this.places,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    logger.d('[SearchResultList] ビルド開始: places.length=${places.length}');
    logger.i('places; $places');

    // 並び替え：評価）
    places.sort((a, b) {
      final aRating = (a['rating'] ?? 0).toDouble();
      final bRating = (b['rating'] ?? 0).toDouble();
      return bRating.compareTo(aRating);
    });

    // 空だった場合
    if (places.isEmpty) {
      return const Center(child: Text('検索結果はありません'));
    }
    // SearchResultItemによって生成されたものをリスト化して表示する
    logger.d('[SearchResultList] ビルド完了: places.length=${places.length}');
    // ListView.builder() がそのリストの長さを見て、必要な分だけWidgetを生成
    return ListView.builder(
      controller: scrollController, // スクロールコントローラーを指定
      itemCount: places.length, // リストの長さを指定
      itemBuilder: (context, index) {
        // 各アイテム(widget)を生成する
        return HospitalInfoCard(place: places[index]);
      },
    );
  }
}

//* ------------------------------------------------------------
