import 'package:get/get.dart';
import 'package:learning/core/localization/translation_reader.dart';

class Translation extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    "en" : TranslationReader.en!,
    "fr" : TranslationReader.fr!,
    "ar" : TranslationReader.ar!,
  };
}