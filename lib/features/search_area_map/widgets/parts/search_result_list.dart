//? search_result_item.dartにて作成されたカードwidgetリストを渡して表示させる
//? imports ===============================================
import 'package:flutter/material.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';
import 'search_result_item.dart';
//* ------------------------------------------------------------

class SearchResultList extends StatelessWidget {
  final List<Map<String, dynamic>> places;

  const SearchResultList({
    super.key,

    // 引数
    required this.places
  });

  @override
  Widget build(BuildContext context) {
    logger.d('[SearchResultList] ビルド開始: places.length=${places.length}');
    // 空だった場合
    if (places.isEmpty) {
      return const Center(child: Text('検索結果はありません'));
    }
    // SearchResultItemによって生成されたものをリスト化して表示する
    logger.d('[SearchResultList] ビルド完了: places.length=${places.length}');
    // ListView.builder() がそのリストの長さを見て、必要な分だけWidgetを生成
    return ListView.builder(
      itemCount: places.length,  // リストの長さを指定
      itemBuilder: (context, index) {  // 各アイテム(widget)を生成する
        return SearchResultItem(place: places[index]);
      },
    );
  }
}

//* ------------------------------------------------------------
