//? Cardの見た目のスタイルを定義するウィジェット
//? imports ====================================================
import 'package:flutter/material.dart';
//* ------------------------------------------------------------

class StyledCard extends StatelessWidget {
  final Widget child;                      // 中に配置するウィジェット（必須）
  final EdgeInsetsGeometry padding;        // 内側の余白（パディング）
  final EdgeInsetsGeometry margin;         // 外側の余白（マージン）
  final double elevation;                  // 影の強さ（高さ）
  final Color? backgroundColor;            // 背景色（null の場合はデフォルト色）
  final Color? shadowColor;                // 影の色（未指定時はTheme依存）
  final BorderRadius? borderRadius;        // 角の丸み（未指定時は半径8の角丸）

  const StyledCard({
    super.key,
    required this.child,                   // コンテンツとして配置するWidget
    this.padding = const EdgeInsets.all(8),         // パディング（デフォルト：8ピクセル）
    this.margin = const EdgeInsets.symmetric(vertical: 8), // マージン（デフォルト：上下8ピクセル）
    this.elevation = 2,                              // 影の高さ（デフォルト：2）
    this.backgroundColor,                            // 背景色（未設定可）
    this.shadowColor,                                // 影の色（未設定可）
    this.borderRadius,                               // カードの角の丸み（未設定可）
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      margin: margin,
      color: backgroundColor,
      shadowColor: shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
