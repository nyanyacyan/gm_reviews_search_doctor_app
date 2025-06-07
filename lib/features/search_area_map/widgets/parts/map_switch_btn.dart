import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gm_reviews_search_doctor_app/const/strings.dart';
import 'package:gm_reviews_search_doctor_app/features/search_area_map/services/gm_detail_place_request.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';

// **********************************************************************************


//? Googleマップへのリンクボタン→アプリがない場合にはブラウザにてGoogleマップを開く
class MapAppSwitchButton extends StatelessWidget {
  final double lat;
  final double lng;
  final String placeId;
  final String label;

  const MapAppSwitchButton({
    super.key,
    required this.lat,
    required this.lng,
    required this.placeId,
    this.label = AppStrings.textMapButton,
  });

  Future<void> _openGoogleMap(BuildContext context) async {
    logger.d('[MapAppSwitchButton] ボタン押下: placeId=$placeId');
    final messenger = ScaffoldMessenger.of(context);

    try {
      final Uri url = await GMDetailPlaceRequest.findPlaceWebsiteOrNull(placeId);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        logger.e('[MapAppSwitchButton] URL起動失敗: $url');
        messenger.showSnackBar(const SnackBar(content: Text('地図を開けませんでした')));
      }
    } catch (e, stackTrace) {
      logger.e('[MapAppSwitchButton] 例外: $e');
      logger.e('StackTrace: $stackTrace');
      messenger.showSnackBar(const SnackBar(content: Text('地図リンクの取得に失敗しました')));
    }
  }


// ------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: TextButton(
        // ボタンのスタイルを設定
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          minimumSize: const Size.fromHeight(28),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),

        // 同じクラス内の場合にはそのまま記述できる
        onPressed: () => _openGoogleMap(context),
        child: Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// **********************************************************************************
