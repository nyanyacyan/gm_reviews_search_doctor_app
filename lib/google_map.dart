import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:logger/logger.dart';
import 'package:gm_reviews_search_doctor_app/strings.dart';

//! ------------------------------------------------------------
/// Googleマップへのリンクボタン→アプリがない場合にはブラウザにてGoogleマップを開く
///
//! ------------------------------------------------------------

final logger = Logger();

class MapAppSwitchButton extends StatelessWidget {
  final double lat;
  final double lng;
  final String label;

  const MapAppSwitchButton({
    super.key,
    required this.lat,  // 緯度
    required this.lng,  // 経度
    this.label = AppStrings.textMapButton,  // ボタンのラベル
  });

  /// Googleマップを開く
  void _openGoogleMap(BuildContext context, double lat, double lng) async {
    final messenger = ScaffoldMessenger.of(context);

    logger.d('Googleマップを開く');
    final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      logger.e('Googleマップを開けませんでした');
      messenger.showSnackBar(
        const SnackBar(content: Text('地図を開けませんでした')),
      );
    }
  }

  /// Googleマップを開くボタン
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _openGoogleMap(context, lat, lng),
      child: Text(label),
    );
  }
}
