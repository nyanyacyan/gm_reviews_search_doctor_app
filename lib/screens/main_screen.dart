//? main_screenになる部分を定義
//? imports ====================================================
import 'package:flutter/material.dart';
import 'package:gm_reviews_search_doctor_app/utils/global_keys.dart';
import 'package:gm_reviews_search_doctor_app/const/strings.dart';
import 'package:gm_reviews_search_doctor_app/const/select_value.dart';
import 'package:gm_reviews_search_doctor_app/widgets/search_input_screen.dart';
import 'package:gm_reviews_search_doctor_app/features/search_area_map/widgets/result_display.dart';
import 'package:gm_reviews_search_doctor_app/features/search_area_map/services/search_places.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart';

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

  // @override
  // void initState() {
  //   super.initState();

  //   // WidgetsBinding で post-frame に SnackBar 表示（テスト）
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     logInfo('[MainScreen] postFrameCallbackが呼ぼう');
  //     ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
  //       const SnackBar(content: Text('✅ SnackBar 表示テスト in MainScreen')),
  //     );
  //     logInfo('[MainScreen] postFrameCallbackが呼ばれました');
  //   });
  // }

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
          builder:
              (_) => DraggableScrollableSheet(
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
                      scrollController: scrollController, // スクロールコントローラーを渡す
                    ),
                  );
                },
              ),
        );
      } else {
        if (!mounted) return; // ウィジェットがまだマウントされているか確認
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
          const SnackBar(content: Text(MainWidgetStrings.errMsgDropdownEmpty)),
        );
      }
    } catch (e, stackTrace) {
      logger.e('検索中にエラーが発生しました: $e');
      logger.e('StackTrace: $stackTrace');
      if (!mounted) return; // ウィジェットがまだマウントされているか確認
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(content: Text(MainWidgetStrings.errMsgSearchFailed)),
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
          onSearchPressed: () => _search(), // ← 引数で渡す！
        ),
      ),
    );
  }
}

// *************************************************************
