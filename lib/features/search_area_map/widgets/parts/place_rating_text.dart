import 'package:flutter/material.dart';

class PlaceRatingText extends StatelessWidget {
  final double? rating;
  final int? userRatingsTotal;

  const PlaceRatingText({
    super.key,
    this.rating,
    this.userRatingsTotal,
  });

  @override
  Widget build(BuildContext context) {
    final ratingDisplay = rating != null ? rating!.toStringAsFixed(1) : '評価なし';
    final ratingsCount = userRatingsTotal ?? 0;

    return Text(
      '評価: $ratingDisplay（${ratingsCount}件）',
      style: const TextStyle(fontSize: 14),
    );
  }
}
