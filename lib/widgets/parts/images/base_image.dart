//? search_result_item.dartにて作成されたカードwidgetリストを渡して表示させる
//? imports ===============================================
import 'package:flutter/material.dart';
//* ------------------------------------------------------------

class CommonImage extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const CommonImage({
    super.key,
    required this.imageUrl,
    this.width = 100,
    this.height = 100,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: Image.network(
          imageUrl!,
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      );

    // 画像URLがnullまたは空の場合の処理
    } else {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: borderRadius,
        ),
        child: const Icon(Icons.image_not_supported),
      );
    }
  }
}

//* ------------------------------------------------------------
