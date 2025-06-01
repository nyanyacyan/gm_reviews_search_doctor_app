// search_result_list.dart
import 'package:flutter/material.dart';
import 'search_result_item.dart';

class SearchResultList extends StatelessWidget {
  final List<Map<String, dynamic>> places;

  const SearchResultList({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return const Center(child: Text('検索結果はありません'));
    }
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        return SearchResultItem(place: places[index]);
      },
    );
  }
}
