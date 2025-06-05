//? search_result_item.dartにて作成されたカードwidgetリストを渡して表示させる
//? imports ====================================================
import 'package:flutter/material.dart';
import 'package:gm_reviews_search_doctor_app/features/search_area_map/widgets/parts/search_result_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _stationController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  List<Map<String, dynamic>> _searchResults = [];

  Future<void> _search() async {
    // ここで検索処理を実施
    final results = await searchPlaces(
      station: _stationController.text,
      category: _categoryController.text,
    );

    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('医療機関検索')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _stationController,
              decoration: const InputDecoration(labelText: '駅名'),
            ),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: '診療科（例：耳鼻科）'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _search,
              child: const Text('検索'),
            ),
            const SizedBox(height: 12),

            // 検索結果があれば表示、なければ非表示
            if (_searchResults.isNotEmpty)
              Expanded(child: SearchResultList(places: _searchResults)),
          ],
        ),
      ),
    );
  }
}
