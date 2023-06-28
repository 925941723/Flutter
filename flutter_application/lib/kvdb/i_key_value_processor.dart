/// 键值对型数据库接口
abstract class IKeyValueProcessor{

  Future<void> init(IKeyValueProcessor? keyValueProcessor);

  Future<void> setString(String key, String value);

  Future<String> getString(String key);

}