
import 'package:flutter_application/kvdb/i_key_value_processor.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 通用型SharedPreferences
class SharedPreferencesProcessor implements IKeyValueProcessor{
  late final SharedPreferences? sharedPreferences;

  @override
  Future<void> init(IKeyValueProcessor? keyValueProcessor) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return;
  }

  @override
  Future<String> getString(String key) async => await sharedPreferences?.getString(key) ?? '';

  @override
  Future<void> setString(String key, String value) async{
     await sharedPreferences?.setString(key, value);
     return;
  }

}