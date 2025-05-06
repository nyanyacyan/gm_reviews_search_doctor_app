import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gm_reviews_search_doctor_app/strings.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';

//! ------------------------------------------------------------
/// Googleマップへのリンクボタン→アプリがない場合にはブラウザにてGoogleマップを開く
///
//! ------------------------------------------------------------

/// Googleマップを開くボタン
class MapAppSwitchButton extends StatelessWidget {
  final double lat;
  final double lng;
  final String label;

  MapAppSwitchButton({
    super.key,
    required this.lat,
    required this.lng,
    this.label = AppStrings.textMapButton,
  }) {
    logger.d('[生成] MapAppSwitchButton: lat=$lat, lng=$lng');
  }

  /// Googleマップを開く
  void _openGoogleMap(BuildContext context, double lat, double lng) async {
    logger.d('Googleマップを開く処理を開始');
    final messenger = ScaffoldMessenger.of(context);

    logger.d('Googleマップを開く');
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      logger.e('Googleマップを開けませんでした');
      messenger.showSnackBar(const SnackBar(content: Text('地図を開けませんでした')));
    }
  }

  /// Googleマップを開くボタン
  @override
  Widget build(BuildContext context) {
    logger.d('[描画] MapAppSwitchButton: lat=$lat, lng=$lng');

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      onPressed: () => _openGoogleMap(context, lat, lng),
      child: Text(label),
    );
  }
}
