import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';
import 'package:gm_reviews_search_doctor_app/features/search_area_map/services/exceptions.dart';

// **********************************************************************************
//? 駅名から緯度経度を取得するGoogle Geocoding APIサービス  Build不要


// Futureを使って非同期処理を行う
// Map<String, double>の返す値を定義
Future<Map<String, double>> getStationLocation(
  String stationName,  // 引数
// asyncはawaitを使うために必要
) async {

  // 変数を定義
  final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
  final url =
      'https://maps.googleapis.com/maps/api/geocode/json?address=$stationName&language=ja&key=$apiKey';

  logDebug('Geocode API URL: $url'); // APIのURLをログ出力

  try {
    // 非同期処理
    final res = await http.get(Uri.parse(url));

    if (res.statusCode != 200) throw Exception('Geocode API failed');
    logDebug('APIのレスポンス: ${res.body}'); // レスポンスのログ出力

    final data = json.decode(res.body);
    logDebug('デコードされたデータ: $data'); // デコード後のデータのログ出力

    final status = data['status'];

    // もしステータスが "ZERO_RESULTS" ならば、駅が見つからなかったことを示す
    if (status == "ZERO_RESULTS") {
      throw StationNotFoundException(); // ← ここで投げる
    }

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
      throw StationNotFoundException(); // 駅が見つからなかった場合に例外を投げる
    }
}


// **********************************************************************************



