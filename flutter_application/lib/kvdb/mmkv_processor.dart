
import 'package:flutter_application/kvdb/i_key_value_processor.dart';
import 'package:mmkv/mmkv.dart';

// mmvk实现，仅用于android原生与ios原生
class MMKVProcessor implements IKeyValueProcessor{
  final encryptKey = 'default_MMKV';
  late final MMKV? mmkv;

  @override
  Future<void> init(IKeyValueProcessor? keyValueProcessor) async {
     await MMKV.initialize();
     mmkv = MMKV.defaultMMKV(cryptKey: encryptKey);
     return;
  }

  @override
  Future<String> getString(String key) async => await mmkv?.decodeString(key) ?? '';

  @override
  Future<void> setString(String key, String value) async {
    await mmkv?.encodeString(key, value);
    return;
  }



}