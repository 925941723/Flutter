import 'package:dio/dio.dart';
import 'package:flutter_application/network/dio_util.dart';
import 'package:flutter_application/data/source/remote/persistent_interceptor.dart';

// 远程数据源
class RemoteDataSource{
  RemoteDataSource._internal();

  factory RemoteDataSource() => _instance;

  // 懒加载
  static late final RemoteDataSource _instance = RemoteDataSource._internal();

  late final Dio _dio = DioUtil.getDio("https://gd-casicloud.com/sit-api/", interceptors: [
    PersistentInterceptor(),
  ])
  ..options.contentType = Headers.jsonContentType;
  
  Future test() async {
    return _dio.post('admin/login/token', data: {
      'username': 'admin',
      'password': 'GDhtyw@2022',
    },
      options: Options(contentType: Headers.formUrlEncodedContentType) // 修改单个请求方式
    );
  }

  Future testFail() async {
    return _dio.post('admin/login/token', data: {
      'username': 'admin',
      'password': 'GDhtyw@2022',
    },
    );
  }
}