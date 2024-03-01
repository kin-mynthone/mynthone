import 'package:get/get.dart';

part '../localization/english_translation_map.dart';
part '../localization/russian_translation_map.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': _englishTranslationMap,
        'ru_RU': _russianTranslationMap,
      };
}
