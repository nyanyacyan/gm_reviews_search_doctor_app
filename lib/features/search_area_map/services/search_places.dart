// search_places.dart の先頭
import 'package:gm_reviews_search_doctor_app/features/search_area_map/services/geocode_service.dart';
import 'package:gm_reviews_search_doctor_app/features/search_area_map/services/nearby_search_service.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';

Future<List<Map<String, dynamic>>> getPlaces({
  required String station,
  required String category,
}) async {
  try {
    // ① 駅名から緯度・経度を取得
    final location = await GeocodeService.getStationLocation(station);
    final lat = location['lat']!;
    final lng = location['lng']!;

    // ② その座標から病院情報を取得
    final results = await NearbySearchService.fetchNearbyHospitals(
      lat: lat,
      lng: lng,
      selectedWord: category,
    );

    return results;
  } catch (e, stackTrace) {
    logger.e('[searchPlaces] エラー: $e');
    logger.e('[searchPlaces] StackTrace: $stackTrace');
    throw Exception('検索に失敗しました: $e');
  }
}
