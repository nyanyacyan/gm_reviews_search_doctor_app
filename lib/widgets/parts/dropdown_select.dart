//? dropdownを選択するwidget
//? imports ===============================================
import 'package:flutter/material.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';
//* ------------------------------------------------------------

class DropdownSelect extends StatelessWidget {
  // ドロップダウンの選択肢を管理するためのインスタンス変数
  final String selectedValue;
  final List<String> items;
  final void Function(String?) onChanged;


  const DropdownSelect({
    super.key,

    // 引数
    required this.selectedValue,  // 初期値
    required this.items,  // ドロップダウンの選択肢リスト
    required this.onChanged,  // 選択肢が変更されたときのコールバック関数→値を変数で渡す→初期値のままだったエラーを出す
  });

//* ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    logger.d('DropdownSelect: selectedValue: $selectedValue, items: $items');
    return DropdownButton<String>(
      value: selectedValue,
      isExpanded: true, // 幅いっぱいに広げたいとき
      onChanged: onChanged,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
