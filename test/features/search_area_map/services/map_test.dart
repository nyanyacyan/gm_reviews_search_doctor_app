
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../base_test/base_classes/base_unit_test.dart';
import 'package:gm_reviews_search_doctor_app/features/search_area_map/services/geocode_service.dart';


final baseTest = BaseUnitTest();

void main() {
  // テストの前に一度だけ実行されるテスト
  setUpAll(() async {
    // 環境変数の読み込み
    await dotenv.load(fileName: '.env.android'); // 適切な.envファイルを指定
  });


  baseTest.runTest(
    '駅名から緯度と経度を取得するテスト',
    () async{
      final stationLocation = await getStationLocation('新宿駅');

      expect(stationLocation, isA<Map<String, double>>());
      expect(stationLocation.containsKey('lat'), true);
      expect(stationLocation.containsKey('lng'), true);
    },

  );
}
