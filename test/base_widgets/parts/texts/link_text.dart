//? リンク付きのテキストwidget
//? imports ===============================================
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';
//* ------------------------------------------------------------

class LinkText extends StatelessWidget {
  final String text;
  final Uri linkUrl;

  // 以下はスタイルに関する引数（任意）
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextDecoration decoration;

  const LinkText({
    super.key,

    // 引数
    required this.text, // 表示テキスト
    required this.linkUrl, // リンク先URL
    this.fontSize = 16, // デフォルト値付き
    this.color = Colors.blue,
    this.fontWeight = FontWeight.bold,
    this.decoration = TextDecoration.underline,
  });

  // -----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    logInfo('[LinkText] ビルド開始: text="$text", linkUrl="$linkUrl"');
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(linkUrl)) {
          await launchUrl(linkUrl, mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('リンクを開けませんでした')));
        }
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          decoration: decoration,
        ),
      ),
    );
  }
}

//* ------------------------------------------------------------

class LinkTextAutoSize extends StatelessWidget {
  final String text;
  final Uri linkUrl;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextDecoration decoration;

  const LinkTextAutoSize({
    super.key,

    // 引数
    required this.text, // 表示テキスト
    required this.linkUrl, // リンク先URL
    this.fontSize = 16, // デフォルト値付き
    this.color = Colors.blue,
    this.fontWeight = FontWeight.bold,
    this.decoration = TextDecoration.underline,
  });

  // -------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    logInfo('[LinkText] ビルド開始: text="$text", linkUrl="$linkUrl"');
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(linkUrl)) {
          await launchUrl(linkUrl, mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('リンクを開けませんでした')));
        }
      },
      child: AutoSizeText(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          decoration: decoration,
        ),
        maxLines: 1, // ✅ 縮小の条件に必要
        minFontSize: 10, // ✅ 最小サイズを明示
        overflow: TextOverflow.ellipsis, // 長い時に...表示
      ),
    );
  }
}

//* ------------------------------------------------------------

class ActionLinkTextAutoSize extends StatelessWidget {
  final String text;

  // onTap 実行時に呼ばれる関数（外部から渡す）
  final VoidCallback? onTap;

  // 任意スタイル引数（必要なら残す）
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextDecoration decoration;

  const ActionLinkTextAutoSize({
    super.key,
    required this.text,
    this.onTap,
    this.fontSize = 16,
    this.color = Colors.blue,
    this.fontWeight = FontWeight.bold,
    this.decoration = TextDecoration.underline,
  });

  // -------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // ← 呼び出し元で指定された関数を実行
      child: AutoSizeText(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          decoration: decoration,
        ),
        maxLines: 1,
        minFontSize: 10,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

//* ------------------------------------------------------------
