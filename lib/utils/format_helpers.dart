//? dialogを表示するための関数を定義
//? imports ====================================================
// 大元にあるmaterial系が利用するクラスや関数がある→showDialog(), AlertDialogなど
import 'package:intl/intl.dart';
//* ------------------------------------------------------------
// 日付をフォーマットするためのパッケージ

String formatDate(DateTime dateTime) {
  return DateFormat('yyyy/MM/dd').format(dateTime);
}

// *************************************************************
