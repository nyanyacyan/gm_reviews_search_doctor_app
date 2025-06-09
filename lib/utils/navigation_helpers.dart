//? navigation_helpers.dart
//? imports ====================================================
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//* ------------------------------------------------------------
// URLをブラウザで開くための関数

Future<void> launchUrlInBrowser(Uri url) async {
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

// *************************************************************
// 指定されたページに遷移するための関数

Future<void> navigateToPage(BuildContext context, Widget page) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => page),
  );
}

// *************************************************************
