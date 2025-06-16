//? ユニットテスト
//? imports ====================================================
import 'package:flutter_test/flutter_test.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';

// *************************************************************

class BaseUnitTest {
  void runTest(
    String description,  // テストの説明
    void Function() body, {
    void Function()? setUp,  // 呼び出し元から渡される準備処理
    void Function()? tearDown,  // 呼び出し元から渡される後処理
  }) {
    test(description, () {
      _defaultSetUp();
      setUp?.call(); // 呼び出し元から渡された準備処理
      try {
        body();
      } finally {
        tearDown?.call(); // 呼び出し元から渡された後処理
        _defaultTearDown();
      }
    });
  }
  // -------------------------------------------------------------

  void _defaultSetUp() => logInfo('[UnitTest] Setup（事前実施） 開始');

  // -------------------------------------------------------------

  void _defaultTearDown() => logInfo('[UnitTest] TearDown（後処理） 開始');

  // -------------------------------------------------------------
}
//! 呼び出し方

// import 'package:test/base_test/base_unit_test.dart';
// import 'package:test/base_test/test_setup_patterns.dart';

// final baseTest = BaseUnitTest();

// void main() {
//   baseTest.runTest(
//     'ユーザー名が正しく表示される',
//     () {
//       // ここにテストのクリア条件を明示
//       expect('Taro', equals('Taro'));
//     },
//     setUp: prepareFakeUser,
//     tearDown: resetAllMocks,
//   );
// }
