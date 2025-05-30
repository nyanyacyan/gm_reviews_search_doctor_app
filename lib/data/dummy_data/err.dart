//? エラーがあった際にUIをそのままでダミーとしてのデータを返すためのクラス


class DummyDataError {
  // ダミーのPlace APIのデータ
  static Map<String, dynamic> placeAPIError() => {
    'name': '⚠️ 通信エラー',
    'vicinity': 'APIに接続されてない可能性があります',
    'rating': null,
    'user_ratings_total': 0,
    'lat': null,
    'lng': null,
    'place_id': null,
  };
}
