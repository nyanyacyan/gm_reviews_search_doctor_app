import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';
import 'package:gm_reviews_search_doctor_app/const/select_value.dart';

class NearbySearchService {
  static Future<List<Map<String, dynamic>>> fetchNearbyHospitals({
    required double lat,
    required double lng,
    required String selectedWord,
  }) async {
    final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];

    final selectType = SelectValue.medicalTypeMap[selectedWord];

    final url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
        "?location=$lat,$lng"
        "&radius=1500"
        "&type=$selectType"
        "&keyword=$selectedWord"
        "&language=ja"
        "&key=$apiKey";

    final res = await http.get(Uri.parse(url));
    if (res.statusCode != 200) {
      throw Exception('Places API request failed');
    }

    final data = json.decode(res.body);
    logger.d('APIのレスポンス: $data'); // レスポンスのログ出力
    if (data['status'] != "OK") {
      throw Exception('Places API error: ${data['status']}');
    }

    // 1. JSONから 'results' を取り出す
    final rawResults = data['results'];
    logger.d('rawResultsの型: ${rawResults.runtimeType}'); // dynamic か List?

    // 2. Listとして扱えるように変換
    final List<dynamic> resultList = rawResults as List;  // json.decodeした際にはこの箇所で as List<dynamic>にて明示する必要がある
    logger.d('resultList数: ${resultList.length}');
    logger.d('resultListの1件目: ${resultList.isNotEmpty ? resultList[0] : '空リスト'}');

    // 3. 各要素を Map<String, dynamic> に変換
    final List<Map<String, dynamic>> results = [];
    for (var element in resultList) {
      final mapElement = Map<String, dynamic>.from(element);
      logger.d('1件変換: $mapElement');
      results.add(mapElement);
    }

    // 4. 最後に return
    return results;
  }
}
