//? 検索ボタン関係を格納するファイル
//? imports ===============================================
import 'package:flutter/material.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';
//* ------------------------------------------------------------

class BaseBtn extends StatelessWidget {
  // 変数を定義する
  final String btnLabel; // ボタンのラベル
  final Color backgroundColor; // ボタンの背景色（定数として定義されている色を使用）
  final Color characterColor; // ボタンの文字色（定数として定義されている色を使用）
  final VoidCallback onPressedFunc; // ボタンが押されたときの処理

  // dartではクラスを定義した際には必ずコンストラクタが必要
  // クラスで定義されている変数（インスタンス変数）はコンストラクタでthis.を使って受け渡しする必要がある
  const BaseBtn({
    super.key, // このクラスでのkeyを受け渡しするように定義（あることでwidgetの場所などをわかりやすくできる）
    required this.btnLabel,
    required this.backgroundColor,
    required this.characterColor,
    required this.onPressedFunc,
  });

  @override
  Widget build(BuildContext context) {
    logDebug(
      'BlueSearchBtn: btnLabel: $btnLabel, backgroundColor: $backgroundColor, characterColor: $characterColor',
    );
    return SizedBox(
      width: 200,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: const Size.fromHeight(8),
          backgroundColor: backgroundColor,
          foregroundColor: characterColor,
        ),
        onPressed: onPressedFunc,
        child: Text(
          btnLabel,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

//* ------------------------------------------------------------
