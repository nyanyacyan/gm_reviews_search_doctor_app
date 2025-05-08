// Flutterの基本UIライブラリを読み込む
// Material DesignのUI部品を使うためのライブラリ
// Material DesignはGoogleが提唱するUIデザインのガイドライン→ボタンなどが見やすいものを定義しているデザイン

// UIパーツには2大派閥がある
// cupertino.dart → iOS風のUI部品
// material.dart → Android風のUI部品
// Androidもiosの両方使う場合にはmaterial.dartを使うのが一般的
// import 'dart:math';

import 'package:flutter/material.dart';

// APIリクエストするためのライブラリ
// yamlでバージョンを指定してインストールする必要がある
import 'package:http/http.dart' as http;

// Jsonデータを扱うための標準ライブラリ
import 'dart:convert';

// pubspec.yamlにdotenvを追加しておく必要がある
// envファイルの読み込み
import 'package:flutter_dotenv/flutter_dotenv.dart';

// strings.dartは文字列を定義するためのファイル
import 'package:gm_reviews_search_doctor_app/strings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gm_reviews_search_doctor_app/utils/logger.dart'; // loggerのimport
import 'package:gm_reviews_search_doctor_app/google_map.dart'; // Googleマップへのリンクボタンのimport
// import 'package:url_launcher/url_launcher.dart';

// アプリの起動時に最初に呼ばれる関数
// どこに書いてもいいが慣習としては先頭に記述
Future<void> main() async {
  // WidgetsFlutterBindingはFlutterのウィジェットを初期化するためのクラス
  WidgetsFlutterBinding.ensureInitialized();

  // setupLogger()はアプリケーションのロガーを初期化するための関数
  await setupLogger();

  // dotenvを初期化する
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

// アプリのルートウィジェット
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '駅チカ 名医リサーチ | 口コミランキング',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const SearchScreen(),
    );
  }
}

// 検索画面の箱を用意
// extends StatefulWidgetはFlutterの基底クラス → StatefulWidgetとは
// class SearchScreenというクラスを定義している → このクラスはStatefulWidgetを継承している
// StatelessWidgetは一度定義したら変えられない
// StatefulWidgetは状態を持つウィジェットで、状態が変わるとUIも変わる → ホワイトボード→何回でも書き換えられる
class SearchScreen extends StatefulWidget {
  // 検索画面のコンストラクタ→keyは目印的なもの→定番の書き方
  const SearchScreen({super.key});

  // @overrideはオーバーライドを示すキーワード
  @override
  // createsState() をオーバーライドさせる → 処理の中身は _SearchScreenState にオーバーライドさせる→Widgetの中身をの処理を入れ込んでいくイメージ
  // createsStateメソッドはState<StatefulWidget>という状態が定義されている→State<SearchScreen>とすることでState<SearchScreen>を定義している呼び出し元と紐づけできる。
  // インスタンス化もここで行われる
  State<SearchScreen> createState() => _SearchScreenState();
}

// 検索画面の状態を管理するクラス
// State<SearchScreen>の状態持ったクラスを定義している
// _SearchScreenStateはプライベートなクラスで、アンダースコアをつけることで他のファイルからはアクセスできないようにしている
class _SearchScreenState extends State<SearchScreen> {
  // finalは変更できない変数を定義するためのキーワード(変数の代入ができない)
  // TextEditingControllerはテキストフィールドの入力を管理するためのクラス
  // Dartでの変数は 型＋変数名 = 値 という形で定義する
  // 変数名は小文字から始めるのが一般的でキャメルケースで定義するのが一般的
  final TextEditingController _stationController = TextEditingController();

  String? _selectedType = null;

  // Mapは辞書データ dynamic型は全ての型を受け入れることができる
  // _placesは医療機関の情報を格納するための変数
  // "_"から始まる変数はプライベートな変数であることを示す→他のファイルからはアクセスできないようにしている
  List<Map<String, dynamic>> _places = [];

  // Future	「あとで結果が返ってくるよ！」という約束（予約）
  // <void>	「何も返さない」って意味（数字とか文字は返さない）
  // searchPlaces()	関数の名前。「検索するよ」って意味の関数名
  // async	「時間がかかる処理だよ！」と教える魔法の言葉
  Future<void> searchPlaces() async {
    // .trim()	前後の空白を取り除く（スペースや改行を消してくれる）
    final station = _stationController.text.trim();

    // stationが空文字かどうかをチェックする
    // isEmptyは空文字を示す
    if (station.isEmpty) return;

    final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
    print('API Key: $apiKey');

    // HTTPGETリクエストするためのURLを作成
    final geocodeUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?address=$station&language=ja&key=$apiKey";

    // 非同期処理にてリクエストの実施を定義
    // Uri.parse(geocodeUrl)	→URLとして解析する（文字列になっているものをURLオブジェクトとして解析）
    final geocodeResponse = await http.get(Uri.parse(geocodeUrl));

    // レスポンスデータをJSON形式で取得（Dartで使えるように変換）
    final geocodeData = json.decode(geocodeResponse.body);

    if (geocodeData['status'] == "OK") {
      final lat = geocodeData['results'][0]['geometry']['location']['lat'];
      final lng = geocodeData['results'][0]['geometry']['location']['lng'];

      final typeMap = {
        '小児科': 'doctor',
        '内科': 'doctor',
        '耳鼻科': 'doctor',
        '眼科': 'doctor',
        '皮膚科': 'doctor',
        '整形外科': 'doctor',
      };

      final placesUrl =
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
          "?location=$lat,$lng"
          "&radius=1500"
          "&type=${typeMap[_selectedType]}"
          "&keyword=$_selectedType" // ←ここで「小児科」などを直接指定！
          "&language=ja"
          "&key=$apiKey";

      // httpGetリクエストするためのURLを作成
      final placesResponse = await http.get(Uri.parse(placesUrl));

      // レスポンスデータをJSON形式で取得（Dartで使えるように変換）
      final placesData = json.decode(placesResponse.body);

      final places = (placesData['results'] ?? []) as List;
      places.sort((a, b) => ((b['rating'] ?? 0).compareTo(a['rating'] ?? 0)));

      // setState()は状態を更新するためのメソッド
      // setState(() { })の中に状態を更新する処理を書くことで、UIが再描画される
      setState(() {
        _places =
            // placesData['results']は医療機関の情報を格納したリスト
            // (placesData['results'] ?? []) as Listはnullの場合は空のリストを返す
            // as Listは型を指定するためのキーワード（resultの中身はリストになっている）
            // placeはplacesData['results']の中の1つの要素（病院1件分のデータ）
            (placesData['results'] as List).map((place) {
              final hospitalPhoto = place['photos']?[0]['photo_reference'];
              final photoUrl =
                  hospitalPhoto != null
                      ? "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$hospitalPhoto&key=$apiKey"
                      : null;

              return {
                'name': place['name'],
                'vicinity': place['vicinity'],
                'rating': place['rating'],
                'user_ratings_total': place['user_ratings_total'],
                'photoUrl': photoUrl,
                'lat': place['geometry']['location']['lat'],
                'lng': place['geometry']['location']['lng'],
                'place_id': place['place_id'],
              };
              // .toList()はリストを作成するためのメソッド
            }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    logger.d('build()が呼ばれました: $_selectedType');

    // Scaffoldは画面の基本的なレイアウトを提供するウィジェット
    return Scaffold(
      // AppBarは画面の上部に表示されるバー
      // Text(AppStrings.appTitle) →AppStringsのクラスにて定義したstatic constに設定した「appTitle」を呼び出す
      appBar: AppBar(title: const Text(AppStrings.appTitle)),
      body: Padding(
        // Paddingはウィジェットの周りに余白を作るためのウィジェット
        // EdgeInsets.all(16.0)は全ての方向に16.0の余白を作る
        // EdgeInsetsはウィジェットの周りに余白を作るためのクラス
        padding: const EdgeInsets.all(16.0),

        // Columnは縦にウィジェットを並べるためのウィジェット
        // childrenはColumnの子ウィジェットを指定するためのプロパティ
        child: Column(
          children: [
            // TextFieldはテキスト入力フィールドを作成するためのウィジェット
            SizedBox(
              width: 300, // 幅を調整
              child: TextField(
                controller: _stationController,
                decoration: const InputDecoration(
                  labelText: AppStrings.searchHint,
                ),
              ),
            ),

            // 余白を作るためのウィジェット
            const SizedBox(height: 32.0),

            Center(
              child: SizedBox(
                width: 300, // 幅を調整
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '希望の診療科を選択してください',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // DropdownButtonはドロップダウンリストを作成するウィジェット
                    DropdownButton<String>(
                      value: _selectedType,
                      isExpanded: true,

                      // hintはドロップダウンリストの初期表示を指定するためのプロパティ
                      hint: const Text(
                        AppStrings.dropDownSelectHint,
                        style: TextStyle(color: Colors.grey),
                      ),
                      items:
                          <String>[
                            '小児科',
                            '内科',
                            '耳鼻科',
                            '眼科',
                            '皮膚科',
                            '整形外科',
                            '歯科',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(child: Text(value)),
                            );
                          }).toList(),

                      // hintはドロップダウンリストの初期表示を指定するためのプロパティ
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedType = newValue!;
                        }); // _selectedTypeに選択された値を代入する
                      }, // onChanged
                    ), // DropdownButton
                  ], // Column.children
                ),
              ),
            ), // Center
            // 余白を作るためのウィジェット
            const SizedBox(height: 32.0),

            // ElevatedButtonは押せるボタンを作成するウィジェット
            // onPressedはボタンが押されたときの処理を指定するためのプロパティ
            // ここがトリガーになることで処理を実施される
            ElevatedButton(
              onPressed: searchPlaces,
              child: const Text(AppStrings.searchButton),
            ),

            // 余白を作るためのウィジェット
            const SizedBox(height: 16.0),

            // スペースをできるだけ広く使ってくれるウィジェット→残ったスペースを使って行う
            // リストを表示させてスクロールできるようにするためのウィジェット
            Expanded(
              child: ListView.builder(
                itemCount: _places.length,
                itemBuilder: (context, index) {
                  final place = _places[index];
                  logger.d(place);

                  // ListTileはリストの1行を作成するためのウィジェット
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        // Rowは横にウィジェットを並べるためのウィジェット
                        // childrenはRowの子ウィジェットを指定するためのプロパティ
                        children: [
                          // 画像を表示するウィジェット
                          if (place['photoUrl'] != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                place['photoUrl'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          else
                            // 画像がない場合はデフォルトの画像を表示する
                            Image.asset(
                              'assets/no_image_photo.png',
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                            ),

                          // 余白を作るためのウィジェット
                          const SizedBox(width: 8),

                          // 画像の右側に病院名、住所、評価を表示するウィジェット
                          Expanded(
                            child: Column(

                              // crossAxisAlignmentは横方向の配置を指定するためのプロパティ
                              // CrossAxisAlignment.startは左寄せにするためのプロパティ
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 病院名をリンク付きor通常表示
                                // リンク付きのテキストを表示するウィジェット
                                // Tooltipは長押しで説明を表示するためのウィジェット
                                // messageは説明文を指定するためのプロパティ
                                // place['website']がnullでない場合はリンク付きのテキストを表示する
                                // place['website']がnullの場合は通常のテキストを表示する
                                Tooltip(
                                  message: '公式サイトまたはGoogleマップを開く',
                                  child: GestureDetector(
                                    onTap: () async {
                                      final placeId = place['place_id'];
                                      final url = await fetchWebsiteOrFallback(placeId);
                                      if (!context.mounted) return;
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url, mode: LaunchMode.externalApplication);
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('リンクを開けませんでした')),
                                        );
                                      }
                                    },
                                    child: Text(
                                      place['name'] ?? '名称なし',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),


                                // 余白を作るためのウィジェット
                                const SizedBox(height: 4),

                                // 評価を表示するウィジェット
                                SelectableText(
                                  '評価: ${place['rating']?.toString() ?? '評価なし'}(${place['user_ratings_total'] ?? 0}件)',
                                  style: const TextStyle(fontSize: 14),
                                ),

                                // 余白を作るためのウィジェット
                                const SizedBox(height: 4),

                                // 住所を表示するウィジェット
                                SelectableText(
                                  place['vicinity'] ?? '住所登録なし',
                                  style: const TextStyle(fontSize: 14),
                                ),

                                // 余白を作るためのウィジェット
                                const SizedBox(height: 4),

                                // 地図アプリへジャンプするためのウィジェット
                                if (place['lat'] != null &&
                                    place['lng'] != null)

                                // 地図アプリへジャンプするためのウィジェット
                                // MapAppSwitchButtonはGoogleマップを開くためのボタン
                                // AppStrings.textMapButtonはボタンのラベルを指定するためのプロパティ
                                  MapAppSwitchButton(
                                    lat: (place['lat'] as num).toDouble(),
                                    lng: (place['lng'] as num).toDouble(),
                                    label: AppStrings.textMapButton,
                                  ),
                              ], // Column.children
                            ),
                          ),
                        ], //Row.children
                      ),
                    ),
                  );
                }, // Child
              ),
            ),
          ], // Column.children
        ),
      ),
    );
  } // build
}
