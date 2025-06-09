//? dialogを表示するための関数を定義
//? imports ====================================================
// 大元にあるmaterial系が利用するクラスや関数がある→showDialog(), AlertDialogなど
import 'package:flutter/material.dart';
//* ------------------------------------------------------------
// ダイヤログを出力するグローバル関数

Future<void> showInfoDialog({
  required BuildContext context,
  required String title,
  required String message,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('閉じる'),
          ),
        ],
      );
    },
  );
}

// -------------------------------------------------------------
// カスタムダイアログを表示する関数
Future<void> showCustomDialog({
  required BuildContext context,
  required String title,
  required String message,
  TextStyle? titleTextStyle,
  TextStyle? messageTextStyle,
  String buttonText = '閉じる',
  TextStyle? buttonTextStyle,
  VoidCallback? onClose,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: titleTextStyle ??
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        content: Text(
          message,
          style: messageTextStyle ??
              const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onClose != null) onClose();
            },
            child: Text(
              buttonText,
              style: buttonTextStyle ?? const TextStyle(fontSize: 14),
            ),
          ),
        ],
      );
    },
  );
}

// *************************************************************
// エラーを表示するダイアログ

Future<void> showErrorDialog({
  required BuildContext context,
  required String message,
}) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('エラー', style: TextStyle(color: Colors.red)),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('閉じる'),
        ),
      ],
    ),
  );
}

// *************************************************************
// 確認ダイアログを表示する関数

Future<bool> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('いいえ'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('はい'),
        ),
      ],
    ),
  );
  return result ?? false;
}

// *************************************************************
// ローディングダイアログを表示する関数

Future<void> showLoadingDialog(BuildContext context) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
}

// *************************************************************
