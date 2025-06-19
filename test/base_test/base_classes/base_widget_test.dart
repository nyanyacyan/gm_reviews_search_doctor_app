//? ユニットテスト
//? imports ====================================================
import 'package:flutter_test/flutter_test.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';

// *************************************************************

class BaseWidgetTest {
  void runTest(
    //  引数
    String description,
    Future<void> Function(WidgetTester tester) body, {
    void Function()? setUp,
    void Function()? tearDown,
  }) {
    testWidgets(description, (WidgetTester tester) async {
      _defaultSetUp();
      setUp?.call(); // 任意の準備処理

      try {
        await body(tester); // WidgetTesterを使ったテスト処理
      } finally {
        _defaultTearDown();
        tearDown?.call(); // 任意の後処理
      }
    });
  }

  // -------------------------------------------------------------

  void _defaultSetUp() => logInfo('[WidgetTest] Setup（事前実施）開始');
  // -------------------------------------------------------------

  void _defaultTearDown() => logInfo('[WidgetTest] TearDown（後処理）開始');

  // -------------------------------------------------------------
}

// //! 呼び出し方
// final baseWidgetTest = BaseWidgetTest();

// void main() {
//   baseWidgetTest.runTest(
//     '検索画面が正しく表示される',
//     (tester) async {
//       await tester.pumpWidget(const MySearchApp());
//       expect(find.text('検索'), findsOneWidget);
//     },
//   );
// }
