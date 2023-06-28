
import 'package:flutter_application/kvdb/i_key_value_processor.dart';

// 代理+单例
class KeyValueDatabaseHelper implements IKeyValueProcessor{
  // 代理
  IKeyValueProcessor? keyValueProcessor;

  // 单例
  KeyValueDatabaseHelper._internal();
  factory KeyValueDatabaseHelper() => _instance;
  static late final KeyValueDatabaseHelper _instance = KeyValueDatabaseHelper._internal(); // 懒加载

  @override
  Future<void> init(IKeyValueProcessor? keyValueProcessor) async {
    this.keyValueProcessor = keyValueProcessor;
    await this.keyValueProcessor?.init(null);
    return;
  }

  @override
  Future<String> getString(String key) async => await keyValueProcessor?.getString(key) ?? '';

  @override
  Future<void> setString(String key, String value) async {
    await keyValueProcessor?.setString(key, value);
    return;
  }

}