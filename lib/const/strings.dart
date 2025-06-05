// strings.dart

class AppStrings {
  // static const →どこからでも呼び出せる定数
  static const String materialTitle = '口コミドクター';
  static const String appTitle = '口コミドクター';
  static const String searchHint = '駅名を入力してください';
  static const String dropDownSelectHint = '希望の診療科を選択してください';
  static const String searchButton = '検索';
  static const String textMapButton = 'GoogleMapで開く';
}


class WidgetStrings {
  static const String searchButton = '検索';
  static const String mapButton = 'GoogleMapで開く';
  static const String noData = 'データがありません';
  static const String errorMessage = 'エラーが発生しました';
  static const String initialValue = '選択してください';
}

class MainWidgetStrings {
  static const String appTitle = '口コミドクター';
  static const String initialValue = '選択してください';
  static const String searchBtnLabel = '検索';
  static const String searchInputScreenTitle = '駅名を入力入力してください';
  static const String inputHintText = '例）新橋';
  static const String errMsgDropdownEmpty = '診療科を選択してください';

  static const String searchResultScreenTitle = '検索結果';
  static const String searchResultEmptyMessage = '検索結果は見つかりませんでした';
  static const String searchResultErrorMessage = '検索に失敗しました';
  static const String errMsgSearchFailed = '検索に失敗しました'; // 通信失敗等
}
