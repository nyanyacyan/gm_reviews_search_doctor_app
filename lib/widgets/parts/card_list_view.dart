//? cardをリスト表示するための汎用ウィジェット
//? imports ===============================================
import 'package:flutter/material.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';
//* ------------------------------------------------------------

class CardListView<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext, T card) cardBuilder;

  const CardListView({
    super.key,

    // 引数
    required this.items, // リストに表示するアイテムのリスト
    required this.cardBuilder, // 各アイテムをカードとして表示するためのビルダーメソッド
  });

  @override
  Widget build(BuildContext context) {
    // cardBuilderによって生成されたものをリスト化して表示する
    logger.d('[SearchResultList] ビルド完了: places.length=${items.length}');

    // ListView.builder() がそのリストの長さを見て、必要な分だけWidgetを生成
    return ListView.builder(
      itemCount: items.length, // リストの長さを指定
      itemBuilder: (context, index)// 各アイテム(widget)を生成する
      => cardBuilder(context, items[index]) // cardBuilderを使ってアイテムをカードとして表示する
    );
  }
}
