//? search_result_item.dartにて作成されたカードwidgetリストを渡して表示させる
//? imports ====================================================
import 'package:flutter/material.dart';
import 'package:gm_reviews_search_doctor_app/features/search_area_map/widgets/parts/map_switch_btn.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';
import 'package:gm_reviews_search_doctor_app/widgets/parts/images/base_image.dart';
import 'package:gm_reviews_search_doctor_app/widgets/parts/texts/link_text.dart';
import 'package:gm_reviews_search_doctor_app/widgets/parts/texts/base_text.dart';
import 'package:gm_reviews_search_doctor_app/widgets/parts/cards/styled_card.dart';
//* ------------------------------------------------------------

class HospitalInfoCard extends StatelessWidget {
  final Map<String, dynamic> place;


  const HospitalInfoCard({
    super.key,

    //
    required this.place
  });

//* ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final imageUrl = place['photoUrl'];
    final linkText = place['name'];
    final addressText = place['vicinity'];
    final rating = place['rating'];
    final placeId = place['place_id'] as String;
    final lat = place['geometry']['location']['lat'];
    final lng = place['geometry']['location']['lng'];

    // TODO リンクURLを生成→作成したServiceを利用する
    final Uri linkUrl = Uri.parse('https://www.google.com/maps/place/?q=place_id=${place['place_id']}');

    logger.d('[HospitalInfoCard] ビルド開始: \nplaceId=$placeId, \nlinkText=$linkText, \naddressText=$addressText, \nrating=$rating, \nlat=$lat, \nlng=$lng, \nimageUrl=$imageUrl, \nimageUrl=$imageUrl');

    return StyledCard(
      // Row 横並び
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicImage(
            imageUrl: imageUrl,
            width: 100,
            height: 100,
          ),
          const SizedBox(width: 12),
          Expanded(
            // column 縦並び
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinkText(
                  text: linkText,
                  linkUrl: linkUrl,
                  fontSize: 16,
                ),
                const SizedBox(height: 4),
                if (rating != null)
                  BasicText(
                    text: '評価: ${rating!.toStringAsFixed(1)}',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                const SizedBox(height: 4),
                BasicText(
                  text: addressText,
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
                const SizedBox(height: 8),
                MapAppSwitchButton(
                  lat: lat,
                  lng: lng,
                  placeId: placeId
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//* ------------------------------------------------------------
