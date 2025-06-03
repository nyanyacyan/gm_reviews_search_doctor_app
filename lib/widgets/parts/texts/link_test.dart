//? リンク付きのテキストwidget
//? imports ===============================================
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
    required this.text,      // 表示テキスト
    required this.linkUrl,   // リンク先URL
    this.fontSize = 16,      // デフォルト値付き
    this.color = Colors.blue,
    this.fontWeight = FontWeight.bold,
    this.decoration = TextDecoration.underline,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(linkUrl)) {
          await launchUrl(linkUrl, mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('リンクを開けませんでした')),
          );
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
