import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTitleLink extends StatelessWidget {
  final String? name;
  final String? placeId;

  const PlaceTitleLink({
    super.key,
    this.name,
    this.placeId,
  });

  @override
  Widget build(BuildContext context) {
    final displayName = name ?? '名称なし';

    if (placeId == null || placeId!.isEmpty) {
      return Text(
        displayName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
    }

    final url = Uri.parse("https://www.google.com/maps/place/?q=place_id=$placeId");

    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('リンクを開けませんでした')),
            );
          }
        }
      },
      child: Text(
        displayName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
