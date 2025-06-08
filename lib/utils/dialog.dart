//? search_result_item.dartにて作成されたカードwidgetリストを渡して表示させる
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

//* ------------------------------------------------------------

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
