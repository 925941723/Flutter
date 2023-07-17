
import 'package:flutter_application/data/source/remote/remote_data_source.dart';

/// 数据仓库
class AppRepository{
  // 远程数据源
  var remoteDataSource = RemoteDataSource();

  AppRepository._internal();

  factory AppRepository() => _instance;

  // 懒加载
  static late final AppRepository _instance = AppRepository._internal();

  Future test(){
    return remoteDataSource.test();
  }

  Future testFail(){
    return remoteDataSource.testFail();
  }
}