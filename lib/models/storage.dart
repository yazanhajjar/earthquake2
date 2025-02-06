import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static late SharedPreferences pref;
  static Future<void> initializeDefaults() async {
    pref = await SharedPreferences.getInstance();
    if (pref.getInt('languagenumber') == null) {
      await pref.setInt('languagenumber', 0); // Set default value
    }
    if(pref.getBool('lightmode')==null){
      await pref.setBool('lightmode', true);
    }
    if(pref.getInt('force')==null){
      await pref.setInt('force', 1);
    }
    if(pref.getInt('text')==null){
      await pref.setInt('text', 0);
    }
    if(pref.getBool('login')==null){
      await pref.setBool('lightmode', false);
    }
    if(pref.getStringList('plan')==null){
      await pref.setStringList('plan', []);
    }

  }

  static Future<void> setvalue(String thekey, dynamic value) async {
    if (value is int) {
      await pref.setInt(thekey, value);
    }
    if (value is String) {
      await pref.setString(thekey, value);
    }
    if (value is bool) {
      await pref.setBool(thekey, value);
    }
    if (value is double) {
      await pref.setDouble(thekey, value);
    }
    if (value is List<String>) {
      await pref.setStringList(thekey, value);
    }
  }

  static getvalue(String thekey) async {
    var val=pref.get(thekey);
    return val;
  }
}
