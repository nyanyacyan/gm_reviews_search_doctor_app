import 'package:flutter/material.dart';

class PlaceAddressText extends StatelessWidget {
  final String? address;

  const PlaceAddressText({
    super.key,
    this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      address ?? '住所登録なし',
      style: const TextStyle(fontSize: 14),
    );
  }
}
