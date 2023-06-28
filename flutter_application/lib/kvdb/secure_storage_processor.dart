import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_application/kvdb/i_key_value_processor.dart';

// 安全型数据库
class SecureStorageProcessor implements IKeyValueProcessor{
  late final FlutterSecureStorage? storage ;

  @override
  Future<void> init(IKeyValueProcessor? keyValueProcessor) async {
    storage = FlutterSecureStorage();
  }

  @override
  Future<String> getString(String key) async => await storage?.read(key: key) ?? '';

  @override
  Future<void> setString(String key, String value) async{
    await storage?.write(key: key, value: value);
  }

}