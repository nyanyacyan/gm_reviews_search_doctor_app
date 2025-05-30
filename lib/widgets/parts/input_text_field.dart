import 'package:flutter/material.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';

class InputTextField extends StatefulWidget {
  final String? labelText;
  final String hintText;
  final String inputData;
  final void Function(String) onChanged;

  const InputTextField({
    super.key,
    this.labelText,
    required this.hintText,
    required this.inputData,
    required this.onChanged, // ここに変数に代入を加える、テキストフィールドに入力がなかったときのことをいれる
  });

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // 初期値を設定してcontroller生成
    _controller = TextEditingController(text: widget.inputData);
  }

  // disposeを実行された際にTextEditingControllerを破棄するように追加
  // disposeメソッドが実行されるタイミングは基本決まっている→Widgetツリーから削除されてたとき
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logger.d('InputTextField:\n hintText: ${widget.hintText}\n inputData: ${widget.inputData}');
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        border: const OutlineInputBorder(),
      ),
      onChanged: widget.onChanged,
    );
  }
}
