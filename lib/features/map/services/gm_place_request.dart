import 'dart:convert' show json;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';

// **********************************************************************************
//? gm_placeへのリクエストを行うクラス


class GMPlaceRequest {
  // staticを入れることによって直接呼び出せるようにする
  // インスタンス化は基本しないほうが良い→どこででも呼び出せる＋メモリ消費が少ない
  static Future<Uri> findPlaceWebsiteOrMapUrl(String placeId) async {
    final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
    final detailsUrl =
        'https://maps.googleapis.com/maps/api/place/details/json'
        '?place_id=$placeId&fields=website&key=$apiKey';

    final res = await http.get(Uri.parse(detailsUrl));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      logger.d('APIのレスポンス: ${data}'); // レスポンスのログ出力

      final website = data['result']?['website'];
      if (website != null) return Uri.parse(website);
    }

    // fallback to Google Maps detail page
    return Uri.parse('https://www.google.com/maps/place/?q=place_id=$placeId');
  }
}

// **********************************************************************************
