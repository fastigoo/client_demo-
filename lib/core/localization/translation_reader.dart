import 'dart:convert';

import 'package:flutter/services.dart';

abstract class TranslationReader {

  static Map<String, String>? ar;
  static Map<String, String>? en;
  static Map<String, String>? fr;

  static Future<void> initialize() async {

    final responseEnglish = await rootBundle.loadString('assets/translation/english.json');
    final responseFrench = await rootBundle.loadString('assets/translation/french.json');
    final responseArabic = await rootBundle.loadString('assets/translation/arabic.json');

    en = Map<String, String>.from(json.decode(responseEnglish));
    fr = Map<String, String>.from(json.decode(responseFrench));
    ar = Map<String, String>.from(json.decode(responseArabic));

  }
}