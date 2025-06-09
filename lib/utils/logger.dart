//? loggerを設定をカスタマイズ
//? imports ====================================================
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:developer' as developer; // ← ここに移動！

late final Logger logger;
// -------------------------------------------------------------

// 実行処理関数
// setupLogger関数は、アプリケーションのロガーを初期化するためのもの
Future<DailyFileLogOutput> setupLogger() async {
  final fileOutput = await DailyFileLogOutput.create();

  // Loggerクラスの各設定にカスタマイズを反映
  // printerは出力のフォーマットを指定
  // outputは出力先を指定
  // ConsoleOutputは、ターミナルなどでの背景色を変更するために使用
  logger = Logger(
    level: Level.debug,
    printer: CustomLogPrinter(), // CustomLogPrinterクラスを使用
    output: MultiOutput([
      ConsoleOutput(),
      fileOutput, // DailyFileLogOutputクラスを使用
    ]),
  );
  return fileOutput;
}

// *************************************************************

class CustomLogPrinter extends LogPrinter {
  static const levelColors = {
    Level.debug: '\x1B[90m',
    Level.info: '\x1B[34m',
    Level.warning: '\x1B[33m',
    Level.error: '\x1B[31m',
    Level.fatal: '\x1B[35m',
  };

  static const levelLabels = {
    Level.debug: '🔍 DEBUG',
    Level.info: '💡 INFO',
    Level.warning: '⚠️ WARNING',
    Level.error: '⛔ ERROR',
    Level.fatal: '🚨 FATAL',
  };

  @override
  List<String> log(LogEvent event) {
    final color = CustomLogPrinter.levelColors[event.level] ?? '';
    final label =
        CustomLogPrinter.levelLabels[event.level] ??
        event.level.name.toUpperCase();
    const resetColor = '\x1B[0m';

    return ['$color[$label] ${event.message}$resetColor'];
  }
}

//? ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// loggerのカスタマイズ
// ログファイルの指定

//? ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// LogOutputクラスを継承して、ログメッセージをファイルに出力するクラス
// LogOutputはloggerのアウトプットをしようとする際に呼ばれるクラス
class DailyFileLogOutput extends LogOutput {
  // IOSinkはログメッセージをファイルに書き込むためのもの
  // _sinkは変数名
  // IOSinkはメソッド（dart:ioライブラリ）→ファイルに文字を書き込むためのメソッド
  late final IOSink _sink;

  // コンストラクタ(__init__)
  DailyFileLogOutput._(this._sink);

  // createメソッドは、ログファイルを作成し、古いログを削除するためのもの
  static Future<DailyFileLogOutput> create() async {
    final now = DateTime.now(); // 現在の日付と時刻を取得
    final dateStr = DateFormat('yyyy-MM-dd').format(now); // 日付を文字列にフォーマット
    final directory =
        await getApplicationDocumentsDirectory(); // アプリのドキュメントディレクトリを取得
    final file = File(
      '${directory.path}/log/app_log_$dateStr.txt',
    ); // ログファイルのパス
    await file.create(recursive: true); // ディレクトリが存在しない場合は作成
    final sink = file.openWrite(mode: FileMode.append); // 追記モードで開く

    // 古いログ削除（7日以上前）
    final logDir = Directory('${directory.path}/log');
    if (await logDir.exists()) {
      final files = logDir.listSync();
      for (var file in files) {
        if (file is File) {
          final stat = await file.stat();
          final modified = stat.modified;
          if (now.difference(modified).inDays > 7) {
            await file.delete();
          }
        }
      }
    }

    return DailyFileLogOutput._(sink);
  }

  // LogOutputのoutputメソッドをオーバーライド
  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      _sink.writeln(line);
    }
  }

  // LogOutputのcloseメソッドをオーバーライド
  void dispose() {
    _sink.close();
  }
}

//? ===========================================================
//? 開発用デバッグログ（developer.log 使用）
//? ===========================================================

const _reset = '\x1B[0m';
const _gray = '\x1B[90m';
const _blue = '\x1B[34m';
const _yellow = '\x1B[33m';
const _red = '\x1B[31m';
const _magenta = '\x1B[35m';

void logDebug(String msg) {
  developer.log('$_gray[DEBUG] $msg$_reset');
}

void logInfo(String msg) {
  developer.log('$_blue[INFO] $msg$_reset');
}

void logWarning(String msg) {
  developer.log('$_yellow[WARNING] $msg$_reset');
}

void logError(String msg) {
  developer.log('$_red[ERROR] $msg$_reset');
}

void logCritical(String msg) {
  developer.log('$_magenta[CRITICAL] $msg$_reset');
}
