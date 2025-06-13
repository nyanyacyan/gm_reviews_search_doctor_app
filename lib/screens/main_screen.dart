//? main_screenになる部分を定義
//? imports ====================================================
import 'package:flutter/material.dart';
import 'package:gm_reviews_search_doctor_app/utils/dialog.dart';
import 'package:gm_reviews_search_doctor_app/const/strings.dart';
import 'package:gm_reviews_search_doctor_app/const/select_value.dart';
import 'package:gm_reviews_search_doctor_app/basic_widgets/search_input_screen.dart';
import 'package:gm_reviews_search_doctor_app/features/search_area_map/widgets/result_display.dart';
import 'package:gm_reviews_search_doctor_app/features/search_area_map/services/search_places.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';
import 'package:gm_reviews_search_doctor_app/features/search_area_map/services/exceptions.dart';

// *************************************************************

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreen();
}

// *************************************************************

class _MainScreen extends State<MainScreen> {
  String _stationName = '';
  String _selectedCategory = MainWidgetStrings.initialValue;
  List<Map<String, dynamic>> _places = [];

  final List<String> _categoryItems = SelectValue.medicalTypeList;

  // -------------------------------------------------------------

  Future<void> _search() async {
    try {
      if (_selectedCategory == MainWidgetStrings.initialValue) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(MainWidgetStrings.errMsgDropdownEmpty)),
        );
        return;
      }

      final results = await getPlaces(
        station: _stationName,
        category: _selectedCategory,
      );

      if (results.isNotEmpty) {
        setState(() {
          _places = results;
        });

        if (!mounted) return;

        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.2,
            maxChildSize: 0.9,
            expand: false,
            builder: (_, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: ResultDisplay(
                  places: _places,
                  scrollController: scrollController,
                ),
              );
            },
          ),
        );
      } else {
        // 病院が見つからなかった場合
        throw NoHospitalsFoundException(); // 明示的に投げる必要あり
      }

    } on StationNotFoundException {
      await showErrorDialog(
        context: context,
        message: '駅名が見つかりませんでした。正しい駅名を入力してください。',
      );
    } on NoHospitalsFoundException {
      await showErrorDialog(
        context: context,
        message: '指定した駅周辺に該当する病院が見つかりませんでした。',
      );
    } catch (e) {
      await showErrorDialog(
        context: context,
        message: '検索中にエラーが発生しました。通信状況をご確認ください。',
      );
    }
  }

  // -------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    logDebug(
      '[MainScreen] ビルド開始: _stationName=$_stationName, _selectedCategory=$_selectedCategory',
    );

    return Scaffold(
      appBar: AppBar(title: const Text(MainWidgetStrings.appTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // ← ここを Column にして画像とUIを縦に並べる
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/home_image.png',
              fit: BoxFit.cover, // 横幅にフィット
              width: double.infinity, // 画面幅に広げる
              height: 160, // 任意の高さ
            ),
            const SizedBox(height: 16), // スペース追加
            Expanded(
              child: SearchInputScreen(
                labelText: MainWidgetStrings.searchInputScreenTitle,
                hintText: MainWidgetStrings.inputHintText,
                inputText: _stationName,
                selectedFilterValue: _selectedCategory,
                items: _categoryItems,
                errMsgDropdownEmpty: MainWidgetStrings.errMsgDropdownEmpty,
                btnLabelName: MainWidgetStrings.searchBtnLabel,
                defaultFilterValue: _categoryItems.first,
                onChangedInputText: (value) {
                  setState(() {
                    _stationName = value;
                  });
                },
                onDropdownChanged: (context, newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                onSearchPressed: () => _search(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// *************************************************************
