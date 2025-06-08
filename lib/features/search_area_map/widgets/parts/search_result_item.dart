//? search_result_item.dartにて作成されたカードwidgetリストを渡して表示させる
//? imports ====================================================
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:gm_reviews_search_doctor_app/features/search_area_map/widgets/parts/map_switch_btn.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:gm_reviews_search_doctor_app/widgets/parts/images/base_image.dart';
import 'package:gm_reviews_search_doctor_app/widgets/parts/texts/link_text.dart';
import 'package:gm_reviews_search_doctor_app/widgets/parts/texts/base_text.dart';
import 'package:gm_reviews_search_doctor_app/utils/dialog.dart';
import 'package:gm_reviews_search_doctor_app/features/search_area_map/services/gm_detail_place_request.dart';
//* ------------------------------------------------------------


class HospitalInfoCard extends StatelessWidget {
  final Map<String, dynamic> place;

  const HospitalInfoCard({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
    final linkText = place['name'];
    final addressText = place['vicinity'];
    final rating = place['rating'];
    final placeId = place['place_id'] as String;
    final lat = place['geometry']['location']['lat'];
    final lng = place['geometry']['location']['lng'];

    final photoData = place['photos']?[0]['photo_reference'];
    final imageUrl = photoData != null
        ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoData&key=$apiKey'
        : null;

    logger.i('[HospitalInfoCard] place内容確認: $place');

    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: imageUrl != null
                    ? Image.network(
                        imageUrl,
                        width: 100,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 100,
                        height: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image),
                      ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Builder(
                          builder: (context) {
                            return ActionLinkTextAutoSize(
                              text: linkText,
                              onTap: () async {
                                try {
                                  final uri = await GMDetailPlaceRequest.findPlaceWebsiteOrNull(placeId);

                                  if (uri != null) {
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                                    } else {
                                      logger.e('[HospitalInfoCard] リンク起動失敗: $uri');
                                      if (!context.mounted) return;
                                      showInfoDialog(
                                        context: context,
                                        title: 'リンクを開けませんでした',
                                        message: 'リンクを開けませんでした。ブラウザで開いてみてください。',
                                      );
                                    }
                                  } else {
                                    logger.w('[HospitalInfoCard] サイトが登録されていません: $linkText');
                                    if (!context.mounted) return;
                                      showInfoDialog(
                                        context: context,
                                        title: '登録サイトなし',
                                        message: 'この施設にはGoogleマップにサイトの登録されていないようです。',
                                      );
                                  }
                                } catch (e) {
                                  if (!context.mounted) return;
                                    showInfoDialog(
                                      context: context,
                                      title: 'サイトが開けませんでした',
                                      message: '処理中にエラーが発生しました。後ほど再度お試しください。',
                                    );
                                  logger.e('[HospitalInfoCard] リンク取得エラー: $e');
                                  logger.e('StackTrace: ${StackTrace.current}');
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            if (rating != null)
                              BasicText(
                                text: '評価: ${rating.toStringAsFixed(1)}',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            const SizedBox(width: 8),
                            if (place['user_ratings_total'] != null)
                              BasicText(
                                text: '口コミ: ${place['user_ratings_total']}件',
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        LinkText(
                          text: addressText,
                          linkUrl: Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng'),
                          fontSize: 12,
                          color: Colors.grey[700]!,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//* ------------------------------------------------------------
