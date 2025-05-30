//? レスポンスが空だった際にUIをそのままでダミーとしてのデータを返すためのクラス


class DummyEmptyError {
  // ダミーのPlace APIのデータ
  static Map<String, dynamic> placeAPIEmpty() => {
      'name': '該当なし',
      'vicinity': '周辺に該当する施設は見つかりませんでした',
      'rating': null,
      'user_ratings_total': 0,
      'lat': null,
      'lng': null,
      'place_id': null,
    };
}
