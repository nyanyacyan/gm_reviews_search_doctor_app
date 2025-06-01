import 'package:flutter/material.dart';

class PlacePhoto extends StatelessWidget {
  final String? photoUrl;

  const PlacePhoto({
    super.key,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    if (photoUrl != null && photoUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          photoUrl!,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Image.asset(
        'assets/no_image_photo.png',
        width: 100,
        height: 100,
        color: Colors.grey[300],
      );
    }
  }
}
