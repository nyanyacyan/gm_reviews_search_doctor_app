//? imports ====================================================
import 'dart:convert' show json;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
// *************************************************************
//? gm_detail_placeへのリクエストを行うクラス
// マップアプリ（ブラウザ）を開くためにはdetail_placeのAPIを使用する必要がある

class GMDetailPlaceRequest {
  static Future<Uri?> findPlaceWebsiteOrNull(String placeId) async {
    final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
    final detailsUrl =
        'https://maps.googleapis.com/maps/api/place/details/json'
        '?place_id=$placeId&fields=website&key=$apiKey';

    final res = await http.get(Uri.parse(detailsUrl));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final website = data['result']?['website'];
      if (website != null) {
        return Uri.parse(website);
      }
    }

    // サイトが登録されていない場合には null を返す
    return null;
  }
}

// *************************************************************
