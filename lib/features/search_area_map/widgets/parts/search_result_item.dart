import 'package:flutter/material.dart';
import 'package:gm_reviews_search_doctor_app/features/search_area_map/widgets/parts/place_photo.dart';
import 'package:gm_reviews_search_doctor_app/features/search_area_map/widgets/parts/place_title_link.dart';
import 'package:gm_reviews_search_doctor_app/features/search_area_map/widgets/parts/place_rating_text.dart';
import 'package:gm_reviews_search_doctor_app/features/search_area_map/widgets/parts/place_address_text.dart';
import 'package:gm_reviews_search_doctor_app/features/search_area_map/widgets/parts/map_app_button.dart';

class SearchResultItem extends StatelessWidget {
  final Map<String, dynamic> place;

  const SearchResultItem({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PlacePhoto(photoUrl: place['photoUrl']),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PlaceTitleLink(name: place['name'], placeId: place['place_id']),
                  const SizedBox(height: 4),
                  PlaceRatingText(
                    rating: place['rating'],
                    totalRatings: place['user_ratings_total'],
                  ),
                  const SizedBox(height: 4),
                  PlaceAddressText(address: place['vicinity']),
                  const SizedBox(height: 4),
                  if (place['lat'] != null && place['lng'] != null)
                    MapAppSwitchButton(
                      lat: (place['lat'] as num).toDouble(),
                      lng: (place['lng'] as num).toDouble(),
                      label: '地図で見る',
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
