//? dialogを表示するための関数を定義
//? imports ====================================================
// 大元にあるmaterial系が利用するクラスや関数がある→showDialog(), AlertDialogなど
import 'package:flutter/material.dart';
//* ------------------------------------------------------------
// スナックバーを表示する関数

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

