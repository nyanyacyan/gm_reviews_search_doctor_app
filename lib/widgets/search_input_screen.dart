//? キーワードとdropdownの値を返すwidget
//? imports ===============================================
import 'package:flutter/material.dart';
import 'package:gm_reviews_search_doctor_app/widgets/parts/input_text_field.dart';
import 'package:gm_reviews_search_doctor_app/widgets/parts/dropdown_select.dart';
import 'package:gm_reviews_search_doctor_app/widgets/parts/buttons/base_btn.dart';
//* ------------------------------------------------------------

class SearchInputScreen extends StatelessWidget {
  // インスタンス変数
  final String labelText;
  final String hintText;
  final String inputText;
  final String selectedFilterValue;
  final List<String> items;
  final String errMsgDropdownEmpty;
  final String btnLabelName;
  final String defaultFilterValue;
  final void Function(BuildContext context, String newValue) onDropdownChanged;
  final VoidCallback onSearchPressed;
  final void Function(String inputText) onChangedInputText;

  const SearchInputScreen({
    super.key,

    // 引数
    required this.labelText,  // 入力欄のラベル→例）指定したい駅名を入力してください。
    required this.hintText,  // 入力欄に薄く表示されるテキスト→例） 渋谷
    required this.inputText,  // 入力欄の初期値
    required this.selectedFilterValue,  // ドロップダウンの初期値
    required this.items,  // ドロップダウンの選択肢リスト
    required this.errMsgDropdownEmpty, // デフォルトの選択肢が選ばれたときのメッセージ
    required this.btnLabelName, // 検索ボタンのラベル
    required this.defaultFilterValue, // ドロップダウンのデフォルト値
    required this.onDropdownChanged,  // ドロップダウンの選択肢が変更されたときの処理
    required this.onSearchPressed,  // 検索ボタンが押されたときの処理
    required this.onChangedInputText,  // 入力欄のテキストが変更されたときの処理
  });

//* ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 入力欄（左寄せ）
        InputTextField(
          labelText: labelText,
          hintText: hintText,
          inputData: inputText,
          onChanged: onChangedInputText,
        ),
        const SizedBox(height: 16),

        // 絞り込み選択（ドロップダウン）
        Center(
          child: SizedBox(
            width: 245,
            child: DropdownSelect(
              selectedValue: selectedFilterValue,
              items: items,
              onChanged: (newValue) {
                if (newValue != null) {
                  onDropdownChanged(context, newValue);
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 16),

        // 検索ボタン
        Center(
          child: BaseBtn(
            btnLabel: btnLabelName,
            onPressedFunc: onSearchPressed,
            backgroundColor: Colors.blue,
            characterColor: Colors.white,
          ),
        )
      ],
    );
  }
}
