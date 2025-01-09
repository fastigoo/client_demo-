import 'dart:convert';

import 'package:flutter/services.dart';

abstract class TranslationReader {

  static Map<String, String>? ar;
  static Map<String, String>? en;

  static Future<void> initialize() async {

    final responseArabic = await rootBundle.loadString('assets/translation/arabic.json');
    final responseEnglish = await rootBundle.loadString('assets/translation/english.json');

    ar = Map<String, String>.from(json.decode(responseArabic));
    en = Map<String, String>.from(json.decode(responseEnglish));

  }
}