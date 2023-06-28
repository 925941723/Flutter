
// 单例模式
class SingletonUtil {
  SingletonUtil._internal();

  factory SingletonUtil() => _instance;

  // 懒加载
  static late final SingletonUtil _instance = SingletonUtil._internal();
}