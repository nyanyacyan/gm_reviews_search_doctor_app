import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';

// **********************************************************************************
//? 駅名から緯度経度を取得するGoogle Geocoding APIサービス  Build不要

class GeocodeService {
  static Future<Map<String, double>> getStationLocation(
    String stationName,
  ) async {
    final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$stationName&language=ja&key=$apiKey';

    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode != 200) throw Exception('Geocode API failed');
      logDebug('APIのレスポンス: ${res.body}'); // レスポンスのログ出力

      final data = json.decode(res.body);
      logDebug('デコードされたデータ: $data'); // デコード後のデータのログ出力

      final status = data['status'];
      if (status != "OK") throw Exception('Geocode API status=$status');

      final location = data['results'][0]['geometry']['location'];

      // Map<String, double>→Stringはkeyの型 → doubleはvalueの型
      // doubleは小数点もありの型
      final Map<String, double> stationLocation = {
        'lat': location['lat'],
        'lng': location['lng'],
      };

      logDebug(
        '取得した緯度経度: ${stationLocation['lat']} ${stationLocation['lng']}',
      ); // 取得した緯度経度のログ出力

      //! 駅の緯度経度から周辺情報を取得するためにこの緯度と経度を使ってPlace APIを呼び出す必要がある
      return stationLocation;
    } catch (e, stackTrace) {
      logger.e('Geocode APIエラー: $e');
      logger.e('StackTrace: $stackTrace');
      throw Exception('Geocode APIエラー: $e');
    }
  }
}

// **********************************************************************************
