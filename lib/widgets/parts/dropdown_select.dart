import 'package:flutter/material.dart';

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



  @override
  Widget build(BuildContext context) {
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
