// search_places.dart の先頭
import 'package:gm_reviews_search_doctor_app/features/search_area_map/services/geocode_service.dart';
import 'package:gm_reviews_search_doctor_app/features/search_area_map/services/nearby_search_service.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';
import 'package:gm_reviews_search_doctor_app/features/search_area_map/services/exceptions.dart';

Future<List<Map<String, dynamic>>> getPlaces({
  // 引数
  required String station,
  required String category,
}) async {
  try {
    // 変数を定義
    // ① 駅名から緯度・経度を取得
    final location = await getStationLocation(station);
    final lat = location['lat']!;
    final lng = location['lng']!;

    // ② その座標から病院情報を取得
    final results = await NearbySearchService.fetchNearbyHospitals(
      lat: lat,
      lng: lng,
      selectedWord: category,
    );

    if (results.isEmpty) {
      logger.w('[searchPlaces] 検索結果がありません: $station, $category');
      throw Exception('NoHospitalsFound');
    }

    return results;

  // そのまま例外を再スロー
  } on StationNotFoundException {
    rethrow;

  // そのまま例外を再スロー
  } on NoHospitalsFoundException {
    rethrow;

  // その他の例外をキャッチしてログ出力
  } catch (e, stackTrace) {
    logger.e('[searchPlaces] エラー: $e');
    logger.e('[searchPlaces] StackTrace: $stackTrace');
    throw Exception('検索に失敗しました: $e');
  }
}



