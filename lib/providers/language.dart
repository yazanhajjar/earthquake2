import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageNotifier extends StateNotifier<Map> {
  LanguageNotifier() : super(_englishMap);

  static const Map _arabicMap = {
    'languagenumber': '1',
    'Earthquake': 'الزلزال',
    'Your location': 'موقعك',
    'settings': 'الإعدادات',
    'Emergency': 'الطوارئ',
    'mesure': 'قياس الزلزال',
    'First aid quiz': 'اختبار الإسعافات الأولية',
    'First aid': 'الإسعافات الأولية',
    'Fire prevention quiz': 'اختبار الوقاية من الحرائق',
    'Fire prevention': 'الوقاية من الحرائق',
    'Earthquake Prevention quiz': 'اختبار الوقاية من الزلازل',
    'Earthquake Prevention': 'الوقاية من الزلازل',
    'Selected Year:': 'السنة المختارة',
    'Select Year': 'اختر السنة',
    'Select the force :': 'اختر الشدة ',
    'Start mesuring': 'بدأ القياس',
    'End mesuring': 'إنهاء القياس',
    'mesurephrase': 'للحصول على نتائج جيدة ضع الهاتف على مكان صلب و أضعط بدأ',
    'Earthquake mesuring': 'قياس شدة الزلزال',
    'Emergency Places': 'أماكن الطوارئ',
    'title': 'شاشة الإعدادات'
  };
  static const Map _englishMap = {
    'languagenumber': '0',
    'Earthquake': 'Earthquake',
    'Your location': 'Your location',
    'settings': 'settings',
    'Emergency': 'Emergency',
    'mesure': 'mesure',
    'First aid quiz': 'First aid quiz',
    'First aid': 'First aid',
    'Fire prevention quiz': 'Fire prevention quiz',
    'Fire prevention': 'Fire prevention',
    'Earthquake Prevention quiz': 'Earthquake Prevention quiz',
    'Earthquake Prevention': 'Earthquake Prevention',
    'Selected Year:': 'Selected Year:',
    'Select Year': 'Select Year',
    'Select the force :': 'Select the force :',
    'Start mesuring': 'Start mesuring',
    'End mesuring': 'End mesuring',
    'mesurephrase':
        'To get good result but the phone on solid place and press on Start',
    'Earthquake mesuring': 'Earthquake mesuring',
    'Emergency Places': 'Emergency Places',
    'title': 'setting screen',
  };

  void changeLanguage(String language) {
    state = language == 'arabic' ? _arabicMap : _englishMap;
  }
}

final languageProvider = StateNotifierProvider<LanguageNotifier, Map>((ref) {
  return LanguageNotifier();
});
