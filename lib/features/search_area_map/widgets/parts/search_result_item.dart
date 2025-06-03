import 'package:flutter/material.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';
import 'package:gm_reviews_search_doctor_app/widgets/parts/images/base_image.dart';
import 'package:gm_reviews_search_doctor_app/widgets/parts/texts/link_text.dart';
import 'package:gm_reviews_search_doctor_app/widgets/parts/texts/base_text.dart';
import 'package:gm_reviews_search_doctor_app/widgets/parts/cards/styled_card.dart';
import 'package:gm_reviews_search_doctor_app/widgets/parts/buttons/base_btn.dart';

class HospitalInfoCard extends StatelessWidget {
  final String? imageUrl;
  final String linkText;
  final Uri linkUrl;
  final String addressText;
  final double? rating;
  final VoidCallback onMapPressed;

  const HospitalInfoCard({
    super.key,
    required this.imageUrl,
    required this.linkText,
    required this.linkUrl,
    required this.addressText,
    required this.onMapPressed,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    logger.d('HospitalInfoCard: linkText: $linkText, linkUrl: $linkUrl, addressText: $addressText, rating: $rating');
    return StyledCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonImage(
            imageUrl: imageUrl,
            width: 100,
            height: 100,
          ),
          const SizedBox(width: 12),
          Expanded(
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
                  CommonText(
                    text: '評価: ${rating!.toStringAsFixed(1)}',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                const SizedBox(height: 4),
                CommonText(
                  text: addressText,
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
                const SizedBox(height: 8),
                BaseBtn(
                  btnLabel: '地図で見る',
                  backgroundColor: Colors.blue,
                  characterColor: Colors.white,
                  onPressedFunc: onMapPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

